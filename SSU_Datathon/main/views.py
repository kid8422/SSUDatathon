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
import json

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
        cursor.execute("SELECT count(*) FROM book WHERE location = '4층인문'")
        f4_count = cursor.fetchone()[0]

        cursor.execute("SELECT count(*) FROM book WHERE location = '보존서고'")
        b1_count = cursor.fetchone()[0]

        cursor.execute("SELECT DDC, location FROM book")
        raw_data = cursor.fetchall()

        df = pd.DataFrame(raw_data, columns=['DDC', 'location'])
        df['DDC'] = df['DDC'].astype(float).astype(int)

        bins = range(0, 1001, 100)
        labels = [f"{x:03d}" for x in range(0, 1000, 100)]
        df['DDC_range'] = pd.cut(df['DDC'], bins=bins, labels=labels, right=False)

        range_counts = df['DDC_range'].value_counts(sort=False)
        range_list = range_counts.reindex(labels, fill_value=0).tolist()
        range_json = json.dumps(range_list)
        print(range_json)

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
    # DB 테이블 이름 가져오기
    with connection.cursor() as cursor:
        cursor.execute("SHOW TABLES;")
    return render(request, 'main/home.html')