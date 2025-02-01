from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.cache import never_cache
from django.db import connection
from pathlib import Path
from datetime import datetime, timedelta
import pandas as pd
import xgboost as xgb
import os
import re
import math
import json
from .models import Book
from django.db.models import Q

##############################################################
########################## 도서 정보 ##########################
###############################################################
@login_required(login_url='DB_login')
def download_book_data(request):
    if request.method == "POST":
        try: 
            with connection.cursor() as cursor:
                cursor.execute("SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location FROM book")
                book_data = cursor.fetchall()

            keys = ["도서ID", "등록일자", "수서방법", "분류코드", "ISBN",
                "서명", "저자", "출판사", "출판연도", "소장위치"]
            transformed_data = [dict(zip(keys, row)) for row in book_data]
            return JsonResponse({'success': True, 'data': transformed_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def load_book_data(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            page = int(data.get('page', 1))  # 선택된 데이터 가져오기
            pageSize = int(data.get('pageSize', 25))
            start = (page - 1) * pageSize
            #print(f"page : {page}, pageSize : {pageSize}, start : {start}")
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location, `except` FROM book LIMIT {pageSize} OFFSET {start}")
                book_data = cursor.fetchall()
            return JsonResponse({'success': True, 'data': book_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def load_book_max_page_len(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)  # 요청 데이터 파싱
            pageSize = int(body.get("pageSize", 25))
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '전체'")
                book_data = cursor.fetchall()[0]
            total_count = sum(book_data[1:])
            return JsonResponse({'success': True, 'data': math.ceil(total_count / pageSize)})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

def data_check(data):
    if not re.match(r'^SS_\d{6}$', data['bookId']):
        return "도서ID는 'SS_'로 시작하고 6개의 숫자로 구성되어야 합니다."
    
    try:
        datetime.strptime(data['regDate'], '%Y-%m-%d')
    except ValueError:
        return "등록일자는 'YYYY-MM-DD' 형식의 날짜여야 합니다."
    
    if not re.match(r'^\d{3}(\.\d+)?$', data['ddc']):
        return "분류코드는 세 자리 숫자 또는 세 자리 숫자 뒤에 '.'과 숫자가 오는 형식이어야 합니다."
    
    if not re.match(r'^\d{13}$', data['isbn']):
        return "ISBN은 13자리 숫자로 구성된 문자열이어야 합니다."
    
    if not re.match(r'^\d{4}$', data['pubYear']):
        return "출판연도는 4자리의 연도여야 합니다."
    
    # 검사 결과 문제 없음
    return "문제없음"

def data_preprocess(raw_data):
    data = {"ID" : raw_data["bookId"], 
            "registration" : raw_data["regDate"], 
            "get_course" : raw_data["getMethod"], 
            "DDC" : raw_data["ddc"], 
            "ISBN" : raw_data["isbn"], 
            "title" : raw_data["title"], 
            "author" : raw_data["author"], 
            "publisher" : raw_data["publisher"], 
            "publication_year" : raw_data["pubYear"],
            "location": raw_data["location"],
            "except": '1' if raw_data["checked"] else '0',
        }
    data["registration_year"] = int(raw_data["regDate"].split("-")[0])
    data["registration_month"] = str(int(raw_data["regDate"].split("-")[1]))
    data["large_code"] = raw_data["ddc"][0]
    data["middle_code"] = raw_data["ddc"][1]
    data["jaum"] = load_chosung(raw_data["title"])
    data["bulli"] = load_bulli(raw_data["title"])
    return data

# 초성, 중성, 종성 리스트
chosung = [
    "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ",
    "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
]
jungsung = [
    "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ",
    "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
]
jongsung = [
    "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ",
    "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ",
    "ㅋ", "ㅌ", "ㅍ", "ㅎ"
]
    
def load_chosung(text):
    def extract_chosung(char):
        # 한글 유니코드 범위 확인
        if '가' <= char <= '힣':
            base = ord('가')
            char_code = ord(char) - base
            # 초성 계산
            cho = char_code // 588
            return chosung[cho]
        else:
            return char  # 한글이 아니면 그대로 반환
    # 입력 텍스트를 한 글자씩 처리하면서 띄어쓰기만 제거
    return ''.join(extract_chosung(char) if char != ' ' else '' for char in text)

def load_bulli(text):
    def decompose_korean(char):
        # 한글 유니코드 범위 확인
        if '가' <= char <= '힣':
            base = ord('가')
            char_code = ord(char) - base
            # 초성, 중성, 종성 분리
            cho = char_code // 588
            jung = (char_code % 588) // 28
            jong = char_code % 28
            # 초성, 중성, 종성 반환
            return chosung[cho] + jungsung[jung] + (jongsung[jong] if jong != 0 else "")
        else:
            return char  # 한글이 아니면 그대로 반환
    # 입력 텍스트를 한 글자씩 분리 후 처리
    #return ''.join(decompose_korean(char) for char in text)
    return ''.join(decompose_korean(char) if char != ' ' else '' for char in text)

def convert_excel_date(excel_date):
    base_date = datetime(1899, 12, 30)  # 엑셀의 날짜 오차 보정
    return (base_date + timedelta(days=excel_date)).strftime('%Y-%m-%d')

@login_required(login_url='DB_login')
def save_add_book(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            stat = data_check(body)
            if stat == "문제없음":
                data = data_preprocess(body)
                print(f"""({data["ID"]}, {data["registration_year"]},{data["registration_month"]}, {data["get_course"]}, {data["DDC"]}, {data["ISBN"]}, {data["title"]}, {data["author"]}, {data["publisher"]}, {data["publication_year"]}, {data["location"]}, {data["large_code"]}, {data["middle_code"]}, {data["jaum"]}, {data["bulli"]}, {data["registration"]}, {data["except"]})""")
                try:
                    with connection.cursor() as cursor:
                        cursor.execute("""
                            INSERT INTO book (ID, registration_year, registration_month, get_course, DDC, 
                                       ISBN, title, author, publisher, publication_year, location, large_code, middle_code, 
                                       jaum, bulli, registration, `except`)  
                                       VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                            """,
                            (data["ID"], data["registration_year"], data["registration_month"], data["get_course"], data["DDC"], 
                            data["ISBN"], data["title"], data["author"], data["publisher"], data["publication_year"], data["location"], 
                            data["large_code"], data["middle_code"], data["jaum"], data["bulli"], data["registration"], data["except"]))
                    return JsonResponse({'success': True})
                except Exception as e:
                    if e.args[0] == 1062:  # MySQL 에러 코드 1062 (Duplicate entry)
                        return JsonResponse({'success': False, 'message': "이미 존재하는 도서ID입니다."}, status=400)
                    print(f"Error: {e}")
            else:
                return JsonResponse({'success': False, 'message': stat}, status=400)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def save_book_file(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            print(body)
            col_mapping = {col: ord(col) - ord('A') for col in body['cols']}
            df_columns = [
                "ID", "registration", "get_course", "DDC", "ISBN",
                "title", "author", "publisher", "publication_year", "location"
            ]
            df_data = []
            for row in body['rows']:
                df_row = [row[col_mapping[col]] for col in body['cols']]
                df_data.append(df_row)
            df = pd.DataFrame(df_data, columns=df_columns)
            df["registration"] = df["registration"].apply(convert_excel_date)
            df["publication_year"] = df["publication_year"].astype(str)
            df["DDC"] = df["DDC"].astype(str)
            df["ISBN"] = df["ISBN"].astype(str)

            df['validation'] = df.apply(lambda row: data_check({
                'bookId': row['ID'],
                'regDate': row['registration'],
                'ddc': row['DDC'],
                'isbn': row['ISBN'],
                'pubYear': row['publication_year']
            }), axis=1)

            invalid_rows = df[df['validation'] != "문제없음"]

            if invalid_rows.empty:
                processed_data = df.apply(lambda row: data_preprocess({
                    'bookId': row['ID'],
                    'regDate': row['registration'],
                    'getMethod': row['get_course'],
                    'ddc': row['DDC'],
                    'isbn': row['ISBN'],
                    'title': row['title'],
                    'author': row['author'],
                    'publisher': row['publisher'],
                    'pubYear': row['publication_year'],
                    'location': row['location'],
                    'checked': False,
                }), axis=1)
                df_processed = pd.DataFrame(processed_data.tolist())
                print(df_processed['except'])
                try:
                    with connection.cursor() as cursor:
                        insert_query = """
                            INSERT INTO book (ID, registration_year, registration_month, get_course, DDC, 
                                            ISBN, title, author, publisher, publication_year, location, 
                                            large_code, middle_code, jaum, bulli, registration, `except`)  
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                        """
                        data_tuples = [
                            (
                                row["ID"], row["registration_year"], row["registration_month"], row["get_course"], row["DDC"],
                                row["ISBN"], row["title"], row["author"], row["publisher"], row["publication_year"],
                                row["location"], row["large_code"], row["middle_code"], row["jaum"], row["bulli"],
                                row["registration"], row["except"]
                            )
                            for _, row in df_processed.iterrows()
                        ]
                        print(data_tuples)
                        cursor.executemany(insert_query, data_tuples)
                    connection.commit()
                    return JsonResponse({'success': True})
                except Exception as e:
                    connection.rollback()  # 오류 발생 시 롤백
                    print(f"Error: {e}")
                    if e.args[0] == 1062:  # MySQL 에러 코드 1062 (Duplicate entry)
                        duplicate_id = e.args[1].split("'")[1]  # "SS_000001" 추출
                        return JsonResponse({'success': False, 'message': f"'{duplicate_id}'은 이미 존재하는 도서ID입니다."}, status=400)
                    return JsonResponse({'success': False, 'message': f"알 수 없는 오류: {str(e)}"}, status=500)
            else:
                first_invalid_row = invalid_rows.iloc[0]  # 첫 번째 행 가져오기
                first_invalid_id = first_invalid_row["ID"]  # ID 컬럼 값
                first_invalid_validation = first_invalid_row["validation"]  # validation 컬럼 값
                text = f'{first_invalid_id}의 {first_invalid_validation} \n다시 확인해 주세요.'
                return JsonResponse({'success': False, 'message': text}, status=400)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def edit_book(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            stat = data_check(body)
            if stat == "문제없음":
                data = data_preprocess(body)
                print(f"""({data["ID"]}, {data["registration_year"]},{data["registration_month"]}, {data["get_course"]}, {data["DDC"]}, {data["ISBN"]}, {data["title"]}, {data["author"]}, {data["publisher"]}, {data["publication_year"]}, {data["location"]}, {data["large_code"]}, {data["middle_code"]}, {data["jaum"]}, {data["bulli"]}, {data["registration"]}, {data["except"]})""")
                try:
                    with connection.cursor() as cursor:
                        cursor.execute("""
                            UPDATE book SET registration_year = %s, registration_month = %s, get_course = %s, 
                                       DDC = %s, ISBN = %s, title = %s, author = %s, publisher = %s, 
                                       publication_year = %s, location = %s, large_code = %s, middle_code = %s, 
                                       jaum = %s, bulli = %s, registration = %s, `except` = %s
                                       WHERE ID = %s
                            """,
                            (data["registration_year"], data["registration_month"], data["get_course"], data["DDC"], data["ISBN"], 
                            data["title"], data["author"], data["publisher"], data["publication_year"], data["location"], data["large_code"], 
                            data["middle_code"], data["jaum"], data["bulli"], data["registration"], data["except"], data["ID"]))
                    return JsonResponse({'success': True})
                except Exception as e:
                    if e.args[0] == 1062:  # MySQL 에러 코드 1062 (Duplicate entry)
                        return JsonResponse({'success': False, 'message': "이미 존재하는 도서ID입니다."}, status=400)
                    print(f"Error: {e}")
            else:
                return JsonResponse({'success': False, 'message': stat}, status=400)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

##############################################################
########################## 대출 정보 ##########################
###############################################################
@login_required(login_url='DB_login')
def download_rent_data(request):
    if request.method == "POST":
        try: 
            with connection.cursor() as cursor:
                cursor.execute("SELECT ID, rent_date FROM rent")
                book_data = cursor.fetchall()

            keys = ["도서ID", "대출일시"]
            transformed_data = [dict(zip(keys, row)) for row in book_data]
            print(transformed_data)
            return JsonResponse({'success': True, 'data': transformed_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def load_rent_data(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            page = int(data.get('page', 1))  # 선택된 데이터 가져오기
            pageSize = int(data.get('pageSize', 25))
            order = int(data.get('order', 1))
            if order == 1:
                order_by = "DESC"
            else:
                order_by = "ASC"
            start = (page - 1) * pageSize
            #print(f"page : {page}, pageSize : {pageSize}, start : {start}")
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT rent_time, ID, title, author, publisher, DDC, location FROM rent_info ORDER BY rent_time {order_by} LIMIT {pageSize} OFFSET {start}")
                rent_data = cursor.fetchall()
            return JsonResponse({'success': True, 'data': rent_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def load_rent_max_page_len(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)  # 요청 데이터 파싱
            pageSize = int(body.get("pageSize", 25))
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT * FROM year_month_count")
                rent_data = cursor.fetchall()
                total_sum = sum(sum(year_data[1:]) for year_data in rent_data)

            return JsonResponse({'success': True, 'data': math.ceil(total_sum / pageSize)})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

##############################################################
####################### 예외 도서 정보 ########################
###############################################################
@login_required(login_url='DB_login')
def except_download_book_data(request):
    if request.method == "POST":
        try: 
            with connection.cursor() as cursor:
                cursor.execute("SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location FROM book WHERE `except` = '1'")
                book_data = cursor.fetchall()

            keys = ["도서ID", "등록일자", "수서방법", "분류코드", "ISBN",
                "서명", "저자", "출판사", "출판연도", "소장위치"]
            transformed_data = [dict(zip(keys, row)) for row in book_data]
            return JsonResponse({'success': True, 'data': transformed_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def except_load_book_data(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            page = int(data.get('page', 1))  # 선택된 데이터 가져오기
            pageSize = int(data.get('pageSize', 25))
            start = (page - 1) * pageSize
            #print(f"page : {page}, pageSize : {pageSize}, start : {start}")
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location, `except` FROM book WHERE `except` = '1' LIMIT {pageSize} OFFSET {start}")
                book_data = cursor.fetchall()
            return JsonResponse({'success': True, 'data': book_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def except_load_book_max_page_len(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)  # 요청 데이터 파싱
            pageSize = int(body.get("pageSize", 25))
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT count(*) FROM book WHERE `except` = '1'")
                book_data = cursor.fetchone()[0]
            print(book_data)
            return JsonResponse({'success': True, 'data': math.ceil(book_data / pageSize)})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def save_except_book_file(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            col_mapping = {col: ord(col) - ord('A') for col in body['cols']}
            df_columns = ["ID"]
            df_data = []
            for row in body['rows']:
                df_row = [row[col_mapping[col]] for col in body['cols']]
                df_data.append(df_row)
            df = pd.DataFrame(df_data, columns=df_columns)


            df['validation'] = df['ID'].apply(lambda x: "문제없음" if re.match(r'^SS_\d{6}$', x) else "도서ID는 'SS_'로 시작하고 6개의 숫자로 구성되어야 합니다.")

            invalid_rows = df[df['validation'] != "문제없음"]

            if invalid_rows.empty:
                try:
                    with connection.cursor() as cursor:
                        insert_query = """
                            UPDATE book SET `except` = '1' WHERE ID = %s
                        """
                        data_tuples = [
                            (
                                row["ID"]
                            )
                            for _, row in df.iterrows()
                        ]
                        cursor.executemany(insert_query, data_tuples)
                    connection.commit()
                    return JsonResponse({'success': True})
                except Exception as e:
                    connection.rollback()  # 오류 발생 시 롤백
                    print(f"Error: {e}")
                    if e.args[0] == 1062:  # MySQL 에러 코드 1062 (Duplicate entry)
                        duplicate_id = e.args[1].split("'")[1]  # "SS_000001" 추출
                        return JsonResponse({'success': False, 'message': f"'{duplicate_id}'은 이미 존재하는 도서ID입니다."}, status=400)
                    return JsonResponse({'success': False, 'message': f"알 수 없는 오류: {str(e)}"}, status=500)
            else:
                first_invalid_row = invalid_rows.iloc[0]  # 첫 번째 행 가져오기
                first_invalid_id = first_invalid_row["ID"]  # ID 컬럼 값
                first_invalid_validation = first_invalid_row["validation"]  # validation 컬럼 값
                text = f'{first_invalid_id}의 {first_invalid_validation} \n다시 확인해 주세요.'
                return JsonResponse({'success': False, 'message': text}, status=400)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)