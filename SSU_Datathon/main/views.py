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