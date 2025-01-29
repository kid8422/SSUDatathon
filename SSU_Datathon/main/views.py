from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.cache import never_cache
from django.db import connection
from datetime import datetime
import pandas as pd
import math
import json
from .models import Book
from django.db.models import Q
from jamo import h2j, j2hcj  # 한글 자모 분리

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
def download_book_data(request):
    if request.method == "POST":
        try: 
            with connection.cursor() as cursor:
                cursor.execute("SELECT ID, registration_year, get_course, DDC, ISBN, title, author, publisher, publication_year, location FROM book")
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
                cursor.execute(f"SELECT ID, registration_year, get_course, DDC, ISBN, title, author, publisher, publication_year, location FROM book LIMIT {pageSize} OFFSET {start}")
                book_data = cursor.fetchall()
            print(len(book_data))
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

@login_required(login_url='DB_login')
def save_add_book(request):
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            print(body)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=400)
    return JsonResponse({'success': False, 'message': 'Invalid request'}, status=400)


################################################################
### 대출 정보 ####
################################################################
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
                cursor.execute(f"SELECT rent_date, ID, title, author, publisher, DDC, location FROM rent NATURAL JOIN book WHERE book.id = rent.id ORDER BY ID {order_by} LIMIT {pageSize} OFFSET {start}")
                rent_data = cursor.fetchall()
            print(rent_data)
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