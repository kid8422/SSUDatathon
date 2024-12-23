from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.db import connection
from datetime import datetime
import json

@csrf_exempt
def DB_login(request):
    error = None
    username = ""
    password = ""
    if request.method == "POST":
        username = request.POST.get('username', "")
        password = request.POST.get('password', "")
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            if user.is_staff:  # 관리자만 접근 가능
                login(request, user)
                return redirect('DB_home')
            else:
                error = "You are not authorized to access this page."
        else:
            error = "Invalid username or password."

    # 데이터베이스에서 B1 및 4F 데이터를 가져옵니다.
    with connection.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) FROM book WHERE location = '보존서고'")
        b1_count = cursor.fetchone()[0]

        cursor.execute("SELECT COUNT(*) FROM book WHERE location = '4층인문'")
        f4_count = cursor.fetchone()[0]
    
    return render(request, 'main/login.html', {
        'error': error,
        'username': username,
        'password': password,
        'b1_count': b1_count,
        'f4_count': f4_count,
    })

@csrf_exempt
def DB_logout(request):
    logout(request)
    return redirect('DB_login')

@csrf_exempt
@login_required(login_url='DB_login')
def DB_home(request):
    # DB 테이블 이름 가져오기
    with connection.cursor() as cursor:
        cursor.execute("SHOW TABLES;")
    return render(request, 'main/home.html')