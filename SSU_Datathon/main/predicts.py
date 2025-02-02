from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.cache import never_cache
from django.db import connection
from pathlib import Path
from datetime import datetime, timedelta, date
import pandas as pd
import xgboost as xgb
import os
import re
import math
import json
from .models import Book
from django.db.models import Q
from dotenv import load_dotenv

load_dotenv()
NAME = os.getenv('DB_NAME')

##############################################################
####################### 모델 불러오기 #########################
###############################################################

BASE_DIR = Path(__file__).resolve().parent.parent
MODELPATH = os.path.join(BASE_DIR, 'main', 'static', 'main', 'models')

loaded_models = []

# 폴더 내 모든 파일 탐색
for filename in os.listdir(MODELPATH):
    # 모델 파일이라고 가정할 확장자를 체크하거나, 필요한 경우 필터링할 수 있음
    if filename.endswith(".json"):
        file_path = os.path.join(MODELPATH, filename)
        
        # XGBoost scikit-learn 래퍼 객체를 생성
        model = xgb.XGBRegressor()

        # 모델 불러오기
        model.load_model(file_path)
        
        # 리스트에 저장
        loaded_models.append(model)

# 예측 함수
def predict_term_year_model(input_data, year):
    # 각 모델로부터 예측
    pred_model = []
    for i in range(len(loaded_models)):
        pred_model.append(loaded_models[i].predict(input_data))

    w = [0 for _ in range(5)]
    if year % 5 == 4: # 2004
        w[0], w[1], w[2], w[3], w[4] = 0.7, 0.1, 0.05, 0.05, 0.1
    elif year % 5 == 0: # 2005
        w[0], w[1], w[2], w[3], w[4] = 0.1, 0.7, 0.1, 0.05, 0.05
    elif year % 5 == 1: # 2006
        w[0], w[1], w[2], w[3], w[4] = 0.05, 0.1, 0.7, 0.1, 0.05
    elif year % 5 == 2: # 2007
        w[0], w[1], w[2], w[3], w[4] = 0.05, 0.05, 0.1, 0.7, 0.1
    else:
        w[0], w[1], w[2], w[3], w[4] = 0.1, 0.05, 0.05, 0.1, 0.7
        
    # 가중 평균
    ensemble_pred = sum([pred_model[i] * w[i] for i in range(5)])
    return ensemble_pred

##############################################################
####################### 4층 인문 예측 #########################
###############################################################

@login_required(login_url='DB_login')
def load_book_info_predict(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            
            location = data.get('location')  # 선택된 데이터 가져오기

            with connection.cursor() as cursor:
                cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{location}'")
                raw_data = cursor.fetchall()[0]
        
            numeric_data = list(raw_data[1:])
            result_data_json = json.dumps(numeric_data)
            return JsonResponse({'success': True, 'data': result_data_json})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)

    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

def extract_movable_books_sorted(result_df_sorted, move_max, quantity):
    """
    Parameters:
    - result_df_sorted (pd.DataFrame): '예측 결과'로 정렬된 데이터프레임.
    - move_max (dict): 각 대분류별 옮길 수 있는 최대 권수.
    - quantity (int): 추출할 권수.
    - excluded_categories (set): 추출에서 제외할 대분류 집합.

    Returns:
    - extracted (pd.DataFrame): 추출된 권수 데이터프레임.
    - unavaliable_list (list): 이동 불가한 대분류와 그 수량.
    """
    extracted_indices = []
    move_max_copy = move_max.copy()
    unavaliable_counts = {k: 0 for k in move_max_copy.keys()}
    
    for idx, row in result_df_sorted.iterrows():
        category = str(row['대분류'])
        if move_max_copy.get(category, 0) > 0:
            extracted_indices.append(idx)
            move_max_copy[category] -= 1
            if move_max_copy[category] == 0:
                del move_max_copy[category]  # 더 이상 추출할 필요 없음
            if len(extracted_indices) == quantity:
                break
    
    move_book_list = result_df_sorted.loc[extracted_indices].copy()
    
    # 이동 불가 대분류와 그 수량 계산
    for category, remaining in move_max_copy.items():
        deficit = move_max[category] - remaining
        if deficit > 0:
            unavaliable_counts[category] = deficit
    
    # 불가능한 대분류 목록 생성
    unavaliable_list = [[k, v] for k, v in unavaliable_counts.items() if v > 0]
    
    return move_book_list, unavaliable_list

@login_required(login_url='DB_login')
def predict_book_lib(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            
            location = data.get('location')  # 선택된 데이터 가져오기
            quantity = int(data.get('quantity'))
            year = int(data.get('year'))
            with connection.cursor() as cursor:
                cursor.execute("SELECT rent_time FROM rent_info ORDER BY rent_time DESC LIMIT 1 OFFSET 0")
                raw_data = cursor.fetchone()[0]
                end_date = raw_data

            years_range = range(end_date.year - year, end_date.year + 1)
            rc_sum_str = " + ".join([f"SUM(rc.`{_}`)" for _ in years_range])
            irc_sum_str = " + ".join([f"SUM(irc.`{_}`)" for _ in years_range])
            sum_str = " + ".join([f"SUM(`{_}`)" for _ in years_range])
            
            with connection.cursor() as cursor:
                cursor.execute(f"""
                                SELECT
                                    book.ID, registration_year, registration_month, get_course,
                                    DDC, title, author, publisher, publication_year, location, duration,
                                    COALESCE({rc_sum_str}, 0) AS total_rent, COALESCE({irc_sum_str}, 0) AS rent_count, ID_count,
                                    registration, book.ISBN, large_code
                                FROM book
                                LEFT JOIN recent_rent       ON book.ID = recent_rent.ID
                                LEFT JOIN rent_count AS rc        ON book.ID = rc.ID
                                LEFT JOIN ISBN_rent_count AS irc   ON book.ISBN = irc.ISBN
                                WHERE location = '{location}' AND `except` = '0'
                                GROUP BY book.ID, registration_year, registration_month,
                                        get_course, DDC, publication_year, location, duration
                                ORDER BY book.ID
                            """)
                raw_data = cursor.fetchall()
                raw_df = pd.DataFrame(raw_data, columns=[
                    'ID', '등록연도', '등록월', '수서방법',
                    '분류코드', '제목', '저자', '출판사', '출판연도', '소장위치', '최근대출',
                    '총 대출 횟수', 'rent_count', 'book_count', '등록일자', 'ISBN', '대분류', 
                ])
                df = raw_df[['ID', '등록연도', '등록월', '수서방법', '분류코드', '제목', '저자', '출판사', '출판연도', '소장위치', '최근대출', '총 대출 횟수', 'rent_count', 'book_count']].copy()
                result_df = raw_df[['ID', '등록일자', '수서방법', '분류코드', 'ISBN', '제목', '저자', '출판사', '출판연도', '대분류']].copy()
        
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT title, author, publisher, ID_count, COALESCE({sum_str}, 0) AS rent_count FROM None_ISBN_rent_count GROUP BY title, author, publisher")
                raw_data = cursor.fetchall()
                None_ISBN_df = pd.DataFrame(raw_data, columns=['제목', '저자', '출판사', 'book_count', 'rent_count'])

                None_ISBN_df = None_ISBN_df.astype(object)
                None_ISBN_df['rent_count'] = None_ISBN_df['rent_count'].astype(float)
                None_ISBN_df['book_count'] = None_ISBN_df['book_count'].astype(float)
        
            df_merged = pd.merge(df, None_ISBN_df, on=['제목', '저자', '출판사'], how='left')
            df_merged['rent_count_x'] = df_merged['rent_count_x'].fillna(df_merged['rent_count_y'])
            df_merged['book_count_x'] = df_merged['book_count_x'].fillna(df_merged['book_count_y'])
            df_merged.drop('rent_count_y', axis=1, inplace=True)
            df_merged.drop('book_count_y', axis=1, inplace=True)
            df_merged.rename(columns={'rent_count_x': 'rent_count', 'book_count_x': 'book_count'}, inplace=True)
            df_merged.drop(columns=['제목', '저자', '출판사'], inplace=True)
            df_merged['ID'] = df_merged['ID'].str.split('_').str[-1].astype(int)
            df_merged['수서방법'] = df_merged['수서방법'].astype('category')
            df_merged['분류코드'] = df_merged['분류코드'].astype(float)
            df_merged['출판연도'] = df_merged['출판연도'].astype(int)
            df_merged['소장위치'] = df_merged['소장위치'].astype('category')
            df_merged['최근대출'] = df_merged['최근대출'].fillna(7305).astype(int)
            df_merged['rent_count'] = df_merged['rent_count'].fillna(0).astype(int)
            df_merged['book_count'] = df_merged['book_count'].fillna(0).astype(int)
            df_merged['총 대출 횟수'] = df_merged['총 대출 횟수'].astype(int)
            df_onehot = pd.get_dummies(df_merged)
            df_onehot['소장위치_보존서고'] = 0
            y_data = df_onehot['rent_count'] / df_onehot['book_count']
            y_data = y_data.fillna(0)
            df_onehot.drop(columns=['rent_count', 'book_count'], inplace=True)
            start_date = date(end_date.year - year, 1, 1)            # 2019-01-01
            diff_days = (end_date.date() - start_date).days  # 2019-01-01 ~ 2024-10-31까지 일수
            df_onehot.loc[df_onehot['최근대출'] > diff_days, '최근대출'] = diff_days
        
            term_y_pred = predict_term_year_model(df_onehot, end_date.year - year)
            result_df['예측 결과'] = term_y_pred
            result_df_sorted = result_df.sort_values(by='예측 결과', ascending=True).reset_index(drop=True) # 오름차순
 
            # 분류별 최소치 값 불러오기
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT * FROM DDC_ratio WHERE TAG = '{location}'")
                raw_data = cursor.fetchone()
                ddc_minimum_list = [int(x) for x in raw_data[1:]]
                ddc_minimum = {str(index): value for index, value in enumerate(ddc_minimum_list)}

            # 현재 있는 권수 불러오기
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{location}'")
                raw_data = cursor.fetchone()
                location_list = [int(x) for x in raw_data[1:]]
                location_book = {str(index): value for index, value in enumerate(location_list)}

            # 옮길 수 있는 권 수 계산
            move_max = {key: location_book[key] - ddc_minimum[key] for key in location_book}
            
            # 이동 가능한 수량만큼 추출
            move_book_list, unavaliable_list = extract_movable_books_sorted(result_df_sorted, move_max, quantity)
            
            large_code_counts = move_book_list.groupby("대분류").size().to_dict()
            for i in range(10):
                large_code_counts.setdefault(str(i), 0)  # 문자열 키로 변환하여 0으로 기본값 설정
            actual_list = [location_book[str(i)] for i in range(len(location_book))]
            difference_list = [location_book[str(i)] - large_code_counts[str(i)] for i in range(len(large_code_counts))]
            actual_list_json = json.dumps(actual_list)
            result_data_json = json.dumps(difference_list)

            move_book_list2 = move_book_list.copy()
            move_book_list2["예측 결과"] = move_book_list2["예측 결과"].apply(lambda x: round(x, 3))
            move_book_list2.drop(columns=['대분류'], inplace=True)

            predict_df_tuples = list(move_book_list2.itertuples(index=False, name=None))
            
            return JsonResponse({'success': True, 'actualData': actual_list_json, 'data': result_data_json, 'predict' : predict_df_tuples})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)

    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

##############################################################
####################### 데이터 전처리 #########################
###############################################################

@login_required(login_url='DB_login')
def load_db_update(request):
    if request.method == "POST":
        try:
            db = ["book", "rent", "large_classification", "middle_classification", 
                  "rent_count", "year_month_count", "year_month_count_detail", 
                  "ISBN_rent_count", "None_ISBN_rent_count","recent_rent", ]
            data = {}

            with connection.cursor() as cursor:
                for table in db:
                    cursor.execute(f"SELECT `timestamp` FROM timestamp WHERE `table` = '{table}'")
                    raw_data = cursor.fetchall()[0]
                    if raw_data[0] == None:
                        d = "변동 내역 없음"
                    else:
                        d = raw_data[0].strftime("%Y년 %m월 %d일 %H시 %M분 %S초").replace(" 0", " ")
                    data[table] = d
            
            return JsonResponse({'success': True, 'data': data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)

    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def preprocessing_db(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            
            option = data.get('data')  # 선택된 데이터 가져오기

            error = []

            if 'ISBN 제공 도서 대여 정보' in option:
                try: 
                    with connection.cursor() as cursor:
                        cursor.execute("SELECT ID, rent_date, ISBN FROM rent NATURAL JOIN book WHERE rent.ID = book.ID")
                        raw_data = cursor.fetchall()

                        ISBN_df = pd.DataFrame(raw_data, columns=['ID', 'rent_date', 'ISBN'])
                        ISBN_df['rent_year'] = pd.to_datetime(ISBN_df['rent_date']).dt.year
                        ISBN_df = ISBN_df[ISBN_df['ISBN'] != '0']

                        result_df = ISBN_df.groupby('ISBN').agg(
                            도서ID개수=('ID', lambda x: x.nunique()),  # 고유 도서 ID 개수
                        ).reset_index()

                        years = list(range(2004, 2025))
                        for year in years:
                            result_df[year] = 0  # 기본값 0 설정
                        year_counts = ISBN_df.groupby(['ISBN', 'rent_year']).size().unstack(fill_value=0)

                        for year in years:
                            if year in year_counts.columns:
                                result_df[year] = result_df['ISBN'].map(year_counts[year])
                        result_df = result_df.astype(object)
                except Exception as e:
                    error.append(str(e))

                try:
                    with connection.cursor() as cursor:
                        insert_query = """
                            INSERT INTO ISBN_rent_count 
                            (ISBN, ID_count, `2004`, `2005`, `2006`, `2007`, `2008`, `2009`, `2010`, `2011`, `2012`, `2013`, 
                            `2014`, `2015`, `2016`, `2017`, `2018`, `2019`, `2020`, `2021`, `2022`, `2023`, `2024`) 
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                            ON DUPLICATE KEY UPDATE 
                            ID_count = VALUES(ID_count),
                            `2004` = VALUES(`2004`), `2005` = VALUES(`2005`), `2006` = VALUES(`2006`), 
                            `2007` = VALUES(`2007`), `2008` = VALUES(`2008`), `2009` = VALUES(`2009`), 
                            `2010` = VALUES(`2010`), `2011` = VALUES(`2011`), `2012` = VALUES(`2012`), 
                            `2013` = VALUES(`2013`), `2014` = VALUES(`2014`), `2015` = VALUES(`2015`), 
                            `2016` = VALUES(`2016`), `2017` = VALUES(`2017`), `2018` = VALUES(`2018`), 
                            `2019` = VALUES(`2019`), `2020` = VALUES(`2020`), `2021` = VALUES(`2021`), 
                            `2022` = VALUES(`2022`), `2023` = VALUES(`2023`), `2024` = VALUES(`2024`)
                        """
                        data_tuples = [
                            (
                                result_df.iloc[i, 0], result_df.iloc[i, 1], result_df.iloc[i, 2], result_df.iloc[i, 3], result_df.iloc[i, 4], result_df.iloc[i, 5], 
                                result_df.iloc[i, 6], result_df.iloc[i, 7], result_df.iloc[i, 8], result_df.iloc[i, 9], result_df.iloc[i, 10], result_df.iloc[i, 11], 
                                result_df.iloc[i, 12], result_df.iloc[i, 13], result_df.iloc[i, 14], result_df.iloc[i, 15], result_df.iloc[i, 16], result_df.iloc[i, 17], 
                                result_df.iloc[i, 18], result_df.iloc[i, 19], result_df.iloc[i, 20], result_df.iloc[i, 21], result_df.iloc[i, 22]
                            )
                            for i in range(len(result_df))
                        ]
                        cursor.executemany(insert_query, data_tuples)
                    connection.commit()
                except Exception as e:
                    connection.rollback()  # 오류 발생 시 롤백
                    error.append(str(e))


            if 'ISBN 미제공 도서 대여 정보' in option:
                try: 
                    with connection.cursor() as cursor:
                        cursor.execute("SELECT ID, rent_date, ISBN, title, author, publisher FROM rent NATURAL JOIN book WHERE rent.ID = book.ID")
                        raw_data = cursor.fetchall()

                        ISBN_df = pd.DataFrame(raw_data, columns=['ID', 'rent_date', 'ISBN', '제목', '저자', '출판사'])
                        ISBN_df['rent_year'] = pd.to_datetime(ISBN_df['rent_date']).dt.year
                        ISBN_df = ISBN_df[ISBN_df['ISBN'] == '0']

                        result_df = ISBN_df.groupby(['제목', '저자', '출판사']).agg(
                            도서ID개수=('ID', lambda x: x.nunique()),  # 고유 도서 ID 개수
                        ).reset_index()

                        years = list(range(2004, 2025))
                        for year in years:
                            result_df[year] = 0  # 기본값 0 설정
                        year_counts = ISBN_df.groupby(['제목', '저자', '출판사', 'rent_year']).size().unstack(fill_value=0)

                        for year in years:
                            if year in year_counts.columns:
                                result_df[year] = result_df.set_index(['제목', '저자', '출판사']).index.map(year_counts[year])
                        result_df = result_df.astype(object)

                except Exception as e:
                    error.append(str(e))

                try:
                    with connection.cursor() as cursor:
                        insert_query = """
                            INSERT INTO None_ISBN_rent_count 
                            (title, author, publisher, ID_count, `2004`, `2005`, `2006`, `2007`, `2008`, `2009`, `2010`, `2011`, `2012`, `2013`, 
                            `2014`, `2015`, `2016`, `2017`, `2018`, `2019`, `2020`, `2021`, `2022`, `2023`, `2024`) 
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                            ON DUPLICATE KEY UPDATE 
                            ID_count = VALUES(ID_count),
                            `2004` = VALUES(`2004`), `2005` = VALUES(`2005`), `2006` = VALUES(`2006`), 
                            `2007` = VALUES(`2007`), `2008` = VALUES(`2008`), `2009` = VALUES(`2009`), 
                            `2010` = VALUES(`2010`), `2011` = VALUES(`2011`), `2012` = VALUES(`2012`), 
                            `2013` = VALUES(`2013`), `2014` = VALUES(`2014`), `2015` = VALUES(`2015`), 
                            `2016` = VALUES(`2016`), `2017` = VALUES(`2017`), `2018` = VALUES(`2018`), 
                            `2019` = VALUES(`2019`), `2020` = VALUES(`2020`), `2021` = VALUES(`2021`), 
                            `2022` = VALUES(`2022`), `2023` = VALUES(`2023`), `2024` = VALUES(`2024`);
                        """
                        data_tuples = [
                            (
                                result_df.iloc[i, 0], result_df.iloc[i, 1], result_df.iloc[i, 2], result_df.iloc[i, 3], result_df.iloc[i, 4], 
                                result_df.iloc[i, 5], result_df.iloc[i, 6], result_df.iloc[i, 7], result_df.iloc[i, 8], result_df.iloc[i, 9], 
                                result_df.iloc[i, 10], result_df.iloc[i, 11], result_df.iloc[i, 12], result_df.iloc[i, 13], result_df.iloc[i, 14], 
                                result_df.iloc[i, 15], result_df.iloc[i, 16], result_df.iloc[i, 17], result_df.iloc[i, 18], result_df.iloc[i, 19], 
                                result_df.iloc[i, 20], result_df.iloc[i, 21], result_df.iloc[i, 22], result_df.iloc[i, 23], result_df.iloc[i, 24]
                            )
                            for i in range(len(result_df))
                        ]
                        cursor.executemany(insert_query, data_tuples)
                    connection.commit()
                except Exception as e:
                    connection.rollback()  # 오류 발생 시 롤백
                    error.append(str(e))


            if '최근 대여 날짜 정보' in option:
                try: 
                    with connection.cursor() as cursor:
                        cursor.execute("SELECT ID, registration FROM book")
                        book_rows = cursor.fetchall()

                        book_df = pd.DataFrame(book_rows, columns=['ID', '등록날짜'])
                        book_df['등록날짜'] = pd.to_datetime(book_df['등록날짜'])

                        cursor.execute("SELECT ID, rent_date FROM rent")
                        rent_rows = cursor.fetchall()

                        rent_df = pd.DataFrame(rent_rows, columns=['ID', '대여날짜'])
                        rent_df['대여날짜'] = pd.to_datetime(rent_df['대여날짜'])

                        latest_rent = rent_df.groupby('ID')['대여날짜'].max()

                        default_date = latest_rent.max()

                        book_df['Delta'] = None  # Delta 컬럼 생성 (초기값 None)
                        book_df.set_index('ID', inplace=True)

                        for book_id, last_rent_date in latest_rent.items():
                            book_df.at[book_id, 'Delta'] = (default_date - last_rent_date).days

                        book_df['Delta'] = book_df['Delta'].fillna((default_date - book_df['등록날짜']).dt.days)
                        book_df = book_df.infer_objects(copy=False)
                        book_df['Delta'] = book_df['Delta'].astype(int)

                        book_df.reset_index(inplace=True)
                        book_df['Delta'] = book_df['Delta'].astype(int)

                        book_df['Delta'] = book_df['Delta'].apply(lambda x: max(x, 0))
                except Exception as e:
                    error.append(str(e))
                
                try:
                    with connection.cursor() as cursor:
                        insert_query = """
                            INSERT INTO recent_rent (ID, duration) 
                            VALUES (%s, %s)
                            ON DUPLICATE KEY UPDATE 
                            duration = VALUES(duration);
                        """
                        data_tuples = [
                            (
                                book_df.iloc[i, 0], book_df.iloc[i, 2],
                            )
                            for i in range(len(book_df))
                        ]
                        cursor.executemany(insert_query, data_tuples)
                    connection.commit()
                except Exception as e:
                    connection.rollback()  # 오류 발생 시 롤백
                    error.append(str(e))

            if len(error) == 0:
                return JsonResponse({'success': True, 'data': data})
            else:
                return JsonResponse({'success': False, 'message': str(e)}, status=400)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def save_book_data(request):
    if request.method == "POST":
        data = json.loads(request.body)
        book = data.get('book')  # book 데이터 받기
        location = data.get('location')  # 위치 데이터 받기
        request.session['book_data'] = book
        request.session['location'] = location
        return JsonResponse({'success': True})

@login_required(login_url='DB_login')
def move_detail(request):
    book = request.session.get('book_data', {})  # 세션에서 가져오기
    location = request.session.get('location', {})  # 세션에서 가져오기
    print(location)
    book_json = json.dumps(book)
    return render(request, 'main/predict/detail_predict.html', {
        'book': book_json,
        'len' : len(book),
        'location': location
        })

@login_required(login_url='DB_login')
def load_book_max_page_len(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)  # 요청 데이터 파싱
            pageSize = int(body.get("pageSize", 25))
            bookLen = int(body.get("bookLen", 1))
            return JsonResponse({'success': True, 'data': math.ceil(bookLen / pageSize)})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)
    
def load_book_data(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            page = int(data.get('page', 1))  # 선택된 데이터 가져오기
            pageSize = int(data.get('pageSize', 25))
            order = int(data.get('order', 1))
            start = (page - 1) * pageSize
            end = (page * pageSize)
            book = request.session.get('book_data', {})  # 세션에서 가져오기
            if not order:
                book = book[::-1]
            if end > len(book):
                end = len(book)
            book_data = book[start:end].copy()
            return JsonResponse({'success': True, 'data': book_data})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def download_book_data(request):
    if request.method == "POST":
        book = request.session.get('book_data', {})  # 세션에서 가져오기

        keys = ["도서ID", "등록일자", "수서방법", "분류코드", "ISBN",
            "서명", "저자", "출판사", "출판연도", "예측 결과"]
        transformed_data = [dict(zip(keys, row)) for row in book]
        return JsonResponse({'success': True, 'data': transformed_data})
        

##############################################################
####################### 4층 인문 예측 #########################
###############################################################

@login_required(login_url='DB_login')
def predict_book_b1(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            
            location = data.get('location')  # 선택된 데이터 가져오기
            quantity = int(data.get('quantity'))
            year = int(data.get('year'))
            with connection.cursor() as cursor:
                cursor.execute("SELECT rent_time FROM rent_info ORDER BY rent_time DESC LIMIT 1 OFFSET 0")
                raw_data = cursor.fetchone()[0]
                end_date = raw_data

            years_range = range(end_date.year - year, end_date.year + 1)
            rc_sum_str = " + ".join([f"SUM(rc.`{_}`)" for _ in years_range])
            irc_sum_str = " + ".join([f"SUM(irc.`{_}`)" for _ in years_range])
            sum_str = " + ".join([f"SUM(`{_}`)" for _ in years_range])
            
            with connection.cursor() as cursor:
                cursor.execute(f"""
                                SELECT
                                    book.ID, registration_year, registration_month, get_course,
                                    DDC, title, author, publisher, publication_year, location, duration,
                                    COALESCE({rc_sum_str}, 0) AS total_rent, COALESCE({irc_sum_str}, 0) AS rent_count, ID_count,
                                    registration, book.ISBN, large_code
                                FROM book
                                LEFT JOIN recent_rent       ON book.ID = recent_rent.ID
                                LEFT JOIN rent_count AS rc        ON book.ID = rc.ID
                                LEFT JOIN ISBN_rent_count AS irc   ON book.ISBN = irc.ISBN
                                WHERE location = '{location}' AND `except` = '0'
                                GROUP BY book.ID, registration_year, registration_month,
                                        get_course, DDC, publication_year, location, duration
                                ORDER BY book.ID
                            """)
                raw_data = cursor.fetchall()
                raw_df = pd.DataFrame(raw_data, columns=[
                    'ID', '등록연도', '등록월', '수서방법',
                    '분류코드', '제목', '저자', '출판사', '출판연도', '소장위치', '최근대출',
                    '총 대출 횟수', 'rent_count', 'book_count', '등록일자', 'ISBN', '대분류', 
                ])
                df = raw_df[['ID', '등록연도', '등록월', '수서방법', '분류코드', '제목', '저자', '출판사', '출판연도', '소장위치', '최근대출', '총 대출 횟수', 'rent_count', 'book_count']].copy()
                result_df = raw_df[['ID', '등록일자', '수서방법', '분류코드', 'ISBN', '제목', '저자', '출판사', '출판연도', '대분류']].copy()
        
            with connection.cursor() as cursor:
                cursor.execute(f"SELECT title, author, publisher, ID_count, COALESCE({sum_str}, 0) AS rent_count FROM None_ISBN_rent_count GROUP BY title, author, publisher")
                raw_data = cursor.fetchall()
                None_ISBN_df = pd.DataFrame(raw_data, columns=['제목', '저자', '출판사', 'book_count', 'rent_count'])

                None_ISBN_df = None_ISBN_df.astype(object)
                None_ISBN_df['rent_count'] = None_ISBN_df['rent_count'].astype(float)
                None_ISBN_df['book_count'] = None_ISBN_df['book_count'].astype(float)
        
            df_merged = pd.merge(df, None_ISBN_df, on=['제목', '저자', '출판사'], how='left')
            df_merged['rent_count_x'] = df_merged['rent_count_x'].fillna(df_merged['rent_count_y'])
            df_merged['book_count_x'] = df_merged['book_count_x'].fillna(df_merged['book_count_y'])
            df_merged.drop('rent_count_y', axis=1, inplace=True)
            df_merged.drop('book_count_y', axis=1, inplace=True)
            df_merged.rename(columns={'rent_count_x': 'rent_count', 'book_count_x': 'book_count'}, inplace=True)
            df_merged.drop(columns=['제목', '저자', '출판사'], inplace=True)
            df_merged['ID'] = df_merged['ID'].str.split('_').str[-1].astype(int)
            df_merged['수서방법'] = df_merged['수서방법'].astype('category')
            df_merged['분류코드'] = df_merged['분류코드'].astype(float)
            df_merged['출판연도'] = df_merged['출판연도'].astype(int)
            df_merged['소장위치'] = df_merged['소장위치'].astype('category')
            df_merged['최근대출'] = df_merged['최근대출'].fillna(7305).astype(int)
            df_merged['rent_count'] = df_merged['rent_count'].fillna(0).astype(int)
            df_merged['book_count'] = df_merged['book_count'].fillna(0).astype(int)
            df_merged['총 대출 횟수'] = df_merged['총 대출 횟수'].astype(int)
            df_onehot = pd.get_dummies(df_merged)
            df_onehot['소장위치_4층인문'] = 0
            y_data = df_onehot['rent_count'] / df_onehot['book_count']
            y_data = y_data.fillna(0)
            df_onehot.drop(columns=['rent_count', 'book_count'], inplace=True)
            start_date = date(end_date.year - year, 1, 1)            # 2019-01-01
            diff_days = (end_date.date() - start_date).days  # 2019-01-01 ~ 2024-10-31까지 일수
            df_onehot.loc[df_onehot['최근대출'] > diff_days, '최근대출'] = diff_days
            expected_features = ['ID', '등록연도', '등록월', '분류코드', '출판연도', '최근대출', '총 대출 횟수', 
                    '수서방법_기타', '수서방법_사서선정', '수서방법_수서정보없음', '수서방법_수업지정', 
                    '수서방법_이용자희망', '수서방법_학과신청', '소장위치_4층인문', '소장위치_보존서고']
            df_onehot = df_onehot[expected_features]
        
            term_y_pred = predict_term_year_model(df_onehot, end_date.year - year)
            result_df['예측 결과'] = term_y_pred
            result_df_sorted = result_df.sort_values(by='예측 결과', ascending=False).reset_index(drop=True) # 오름차순
            
            try:
                # 현재 있는 권수 불러오기
                with connection.cursor() as cursor:
                    cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{location}'")
                    raw_data = cursor.fetchone()
                    location_list = [int(x) for x in raw_data[1:]]
                    location_book = {str(index): value for index, value in enumerate(location_list)}

                # 옮길 수 있는 권 수 계산
                move_max = {key: location_book[key] for key in location_book}
                
                # 이동 가능한 수량만큼 추출
                move_book_list, unavaliable_list = extract_movable_books_sorted(result_df_sorted, move_max, quantity)
                
                large_code_counts = move_book_list.groupby("대분류").size().to_dict()
                for i in range(10):
                    large_code_counts.setdefault(str(i), 0)  # 문자열 키로 변환하여 0으로 기본값 설정
                actual_list = [location_book[str(i)] for i in range(len(location_book))]
                difference_list = [location_book[str(i)] - large_code_counts[str(i)] for i in range(len(large_code_counts))]
                actual_list_json = json.dumps(actual_list)
                result_data_json = json.dumps(difference_list)

                move_book_list2 = move_book_list.copy()
                move_book_list2["예측 결과"] = move_book_list2["예측 결과"].apply(lambda x: round(x, 3))
                move_book_list2.drop(columns=['대분류'], inplace=True)

                predict_df_tuples = list(move_book_list2.itertuples(index=False, name=None))
            except Exception as e:
                print(e)
            
            return JsonResponse({'success': True, 'actualData': actual_list_json, 'data': result_data_json, 'predict' : predict_df_tuples})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)

    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

##############################################################
####################### 분류별 최소치 #########################
###############################################################

@login_required(login_url='DB_login')
def setting_ratio(request):
    if request.method == 'POST':
        data = json.loads(request.body)  # 요청 데이터 파싱
        location = data.get('location')  # 선택된 데이터 가져오기
        DDC = data.get('DDC')
        quantity = int(data.get('quantity'))
        keys = ['000', '100', '200', '300', '400', '500', '600', '700', '800', '900']
        with connection.cursor() as cursor:
            cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{location}'")
            raw_data = cursor.fetchone()
            value_list = raw_data[1:]
            max_dict = dict(zip(keys, value_list))
            print(max_dict)

        with connection.cursor() as cursor:
            if DDC == '전체':
                update_statements = [
                    f"`{key}` = {min(quantity, max_dict.get(key, quantity))}" for key in max_dict.keys()
                ]
                query = ", ".join(update_statements)
                cursor.execute(f"""
                            UPDATE DDC_ratio 
                                SET {query}
                                WHERE TAG = '{location}';
                            """)
            else:
                v = min(max_dict[DDC], quantity)
                cursor.execute(f"""
                               UPDATE DDC_ratio SET `{DDC}` = {v} WHERE TAG = '{location}';
                               """)
        
        with connection.cursor() as cursor:
            cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{location}'")
            raw_data = cursor.fetchone()
            location_list = list(raw_data[1:])

            cursor.execute(f"SELECT * FROM DDC_ratio WHERE TAG = '{location}'")
            raw_data = cursor.fetchone()
            ratio_list = list(raw_data[1:])

            location_list_json = json.dumps(location_list)
            ratio_list_json = json.dumps(ratio_list)
        
        return JsonResponse({'success': True, 'setting': ratio_list_json, 'location': location_list_json}, status=200)
    
@login_required(login_url='DB_login')
def load_ratio(request):
    if request.method == 'POST':
        data = json.loads(request.body)  # 요청 데이터 파싱
        location = data.get('location')  # 선택된 데이터 가져오기
        
        with connection.cursor() as cursor:
            cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{location}'")
            raw_data = cursor.fetchone()
            location_list = list(raw_data[1:])

            cursor.execute(f"SELECT * FROM DDC_ratio WHERE TAG = '{location}'")
            raw_data = cursor.fetchone()
            ratio_list = list(raw_data[1:])

            location_list_json = json.dumps(location_list)
            ratio_list_json = json.dumps(ratio_list)
        
        return JsonResponse({'success': True, 'setting': ratio_list_json, 'location': location_list_json}, status=200)