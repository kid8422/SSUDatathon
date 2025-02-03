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
from django.db.models import Q

@never_cache
def DB_login(request):
    error = None
    username = ""
    password = ""
    if request.method == "POST":
        username = request.POST.get('username', "")
        password = request.POST.get('password', "")
        # 인증 시도
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            if user.is_staff:  # 관리자만 접근 가능
                login(request, user)
                return redirect('DB_home')
            else:
                messages.error(request, "You are not authorized to access this page.")
                return redirect('DB_login')
        else:
            messages.error(request, "Invalid username or password.")
            return redirect('DB_login')

    # 데이터베이스에서 B1 및 4F 데이터를 가져옵니다.
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM large_classification WHERE TAG = '4층인문'")
        raw_data = cursor.fetchall()[0]
        f4_count = sum(raw_data[1:])

        cursor.execute("SELECT * FROM large_classification WHERE TAG = '보존서고'")
        raw_data = cursor.fetchall()[0]
        b1_count = sum(raw_data[1:])

        cursor.execute("SELECT * FROM large_classification WHERE TAG = '전체'")
        raw_data = cursor.fetchall()[0]
        range_list = list(raw_data[1:])
        range_json = json.dumps(range_list)

    return render(request, 'main/login.html', {
        'b1_count': b1_count,
        'f4_count': f4_count,
        'range_list': range_json
    })

def DB_logout(request):
    logout(request)
    return redirect('DB_login')

@login_required(login_url='DB_login')
def DB_home(request):
    return render(request, 'main/main.html')

@login_required(login_url='DB_login')
def book_info(request):
    return render(request, 'main/info/book_info.html')

@login_required(login_url='DB_login')
def rent_info(request):
    return render(request, 'main/info/rent_info.html')

@login_required(login_url='DB_login')
def search(request):
    return render(request, 'main/info/search_info.html')

@login_required(login_url='DB_login')
def DB_book(request):
    return render(request, 'main/set/book_set.html')

@login_required(login_url='DB_login')
def DB_rent(request):
    return render(request, 'main/set/rent_set.html')

@login_required(login_url='DB_login')
def DB_except(request):
    return render(request, 'main/set/except_set.html')

@login_required(login_url='DB_login')
def predict_f4(request):
    return render(request, 'main/predict/f4_predict.html')

@login_required(login_url='DB_login')
def predict_b1(request):
    return render(request, 'main/predict/b1_predict.html')

@login_required(login_url='DB_login')
def ratio_setting(request):
    return render(request, 'main/predict/ratio_predict.html')

@login_required(login_url='DB_login')
def DB_preprocessing(request):
    return render(request, 'main/predict/preprocessing_predict.html')

@login_required(login_url='DB_login')
def dev_info(request):
    return render(request, 'main/dev_info.html')

@login_required(login_url='DB_login')
def load_book_info(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            selected_data = data.get('selectedData', [])  # 선택된 데이터 가져오기
            
            raw_list_large = []
            raw_list_middle = []
            with connection.cursor() as cursor:
                for select in selected_data:
                    cursor.execute(f"SELECT * FROM large_classification WHERE TAG = '{select}'")
                    raw_data = cursor.fetchall()[0]
                    raw_list_large.append(raw_data)

                    cursor.execute(f"SELECT * FROM middle_classification WHERE TAG = '{select}'")
                    raw_data = cursor.fetchall()[0]
                    raw_list_middle.append(raw_data)

            numeric_data_large = [d[1:] for d in raw_list_large]
            result_large = [sum(x) for x in zip(*numeric_data_large)]
            result_large_json = json.dumps(result_large)

            numeric_data_middle = [d[1:] for d in raw_list_middle]
            result_middle = [sum(x) for x in zip(*numeric_data_middle)]
            result_middle_json = json.dumps(result_middle)

            # 여기서 데이터 처리 로직 추가
            return JsonResponse({'success': True, 'large': result_large_json, 'middle': result_middle_json})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)

    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)

@login_required(login_url='DB_login')
def load_rent_info(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)  # 요청 데이터 파싱
            selected_data = data.get('selectedData', [])  # 선택된 데이터 가져오기
            raw_categories = selected_data['categories']
            categories = [item.split()[0] for item in raw_categories]
            years = selected_data['years']

            raw_data_list = []

            with connection.cursor() as cursor:
                if len(categories) == 10:
                    for year in years:
                        cursor.execute(f"""
                                        SELECT * FROM year_month_count WHERE year = '{year}'
                                        """)
                        raw_data = cursor.fetchone()
                        raw_data_ = raw_data[1:]
                        raw_data_list.append(raw_data_)
                        summed_values = [sum(x) for x in zip(*raw_data_list)]
                else:
                    query = ' + '.join(f'`{categorie}`' for categorie in categories)
                    for year in years:
                        cursor.execute(f"""
                                        SELECT {query} FROM year_month_count_detail WHERE year = '{year}'
                                       """)
                        raw_data = cursor.fetchall()
                        raw_data_list.append(raw_data)
                        summed_values = [sum(values) for values in zip(*[map(lambda x: x[0], row) for row in raw_data_list])]
            
            print(summed_values)
            value_json = json.dumps(summed_values)

            return JsonResponse({'success': True, 'data': value_json})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)

    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)
@login_required(login_url='DB_login')
def autocomplete(request):
    if request.method == "POST":
        data = json.loads(request.body)  # 요청 데이터 파싱
        title = data.get('title', '')  # 선택된 데이터 가져오기
        jaum = data.get('jaum', '').replace(' ', '')  # 선택된 데이터 가져오기
        bulli = data.get('bulli', '').replace(' ', '')
        with connection.cursor() as cursor:
            if bulli == jaum:
                cursor.execute(f"SELECT DISTINCT title FROM book WHERE jaum LIKE '%{jaum}%' LIMIT 5;")
                book_data = cursor.fetchall()
            else: 
                if len(title) >= 3:
                    cursor.execute(f"SELECT DISTINCT title FROM book WHERE MATCH(title) AGAINST('{title}*' IN BOOLEAN MODE) LIMIT 5;")
                    book_data = cursor.fetchall()
                    if len(book_data) == 0:
                        cursor.execute(f"SELECT DISTINCT title FROM book WHERE MATCH(bulli) AGAINST('{bulli}*' IN BOOLEAN MODE) LIMIT 5;")
                        book_data = cursor.fetchall()
                else:
                    cursor.execute(f"SELECT DISTINCT title FROM book WHERE title LIKE '%{title}%' LIMIT 5;")
                    book_data = cursor.fetchall()
                    if len(book_data) == 0:
                        cursor.execute(f"SELECT DISTINCT title FROM book WHERE bulli LIKE '%{bulli}%' LIMIT 5;")
                        book_data = cursor.fetchall()
        return JsonResponse({'success': True, 'suggestions': book_data})


        

@login_required(login_url='DB_login')
def book_search(request):
    if request.method == "POST":
        data = json.loads(request.body)  # 요청 데이터 파싱
        title = data.get('title', '')  # 선택된 데이터 가져오기
        jaum = data.get('jaum', '').replace(' ', '')  # 선택된 데이터 가져오기
        bulli = data.get('bulli', '').replace(' ', '')
        with connection.cursor() as cursor:
            if bulli == jaum:
                cursor.execute(f"""
                                SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location
                                FROM book WHERE MATCH(jaum) AGAINST('+{jaum}*' IN BOOLEAN MODE)
                                """)
                book_data = cursor.fetchall()
            else: 
                cursor.execute(f"""
                               SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location
                               FROM book WHERE MATCH(title) AGAINST('+{title.replace(" ", "* +")}*' IN BOOLEAN MODE);
                               """)
                book_data = cursor.fetchall()
                if len(book_data) == 0:
                    cursor.execute(f"""
                               SELECT ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location
                               FROM book WHERE MATCH(bulli) AGAINST('+{bulli}*' IN BOOLEAN MODE);
                               """)
                    book_data = cursor.fetchall()
        raw_df = pd.DataFrame(book_data, columns=[
            'ID', '등록일자', '수서방법', '분류코드', 'ISBN', '제목', '저자', '출판사', '출판연도', '소장위치'
        ])
        raw_df['등록일자'] = raw_df['등록일자'].astype(str)
        df_tuples = list(raw_df.itertuples(index=False, name=None))
        request.session['search_book_data'] = df_tuples
        return JsonResponse({'success': True, 'bookLen': len(book_data)})
    
@login_required(login_url='DB_login')
def load_book_search(request):
    if request.method == "POST":
        data = json.loads(request.body)  # 요청 데이터 파싱
        page = int(data.get('page', 1))
        pageSize = int(data.get('pageSize', 25))
        start = (page - 1) * pageSize
        end = (page * pageSize)
        book = request.session.get('search_book_data', {})
        if end > len(book):
            end = len(book)
        book_data = book[start:end].copy()
        return JsonResponse({'success': True, 'data': book_data})