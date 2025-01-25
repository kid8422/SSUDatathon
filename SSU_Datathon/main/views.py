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
        cursor.execute("SELECT count(*) FROM book WHERE location = '4층인문'")
        f4_count = cursor.fetchone()[0]

        cursor.execute("SELECT count(*) FROM book WHERE location = '보존서고'")
        b1_count = cursor.fetchone()[0]

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

# utils.py 혹은 views.py 등에서 사용
CHOSEONG_LIST = [
    'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ',
    'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ',
    'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ',
    'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
]
JUNGSEONG_LIST = [
    'ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ',
    'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ',
    'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ',
    'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ',
    'ㅣ'
]
JONGSEONG_LIST = [
    '',  # 종성 없는 경우
    'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ',
    'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ',
    'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ',
    'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ',
    'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ',
    'ㅍ', 'ㅎ'
]

def decompose_korean_to_jamo(text: str) -> str:
    """
    주어진 문자열에서 한글 문자를 초성/중성/종성으로 분해하여
    모두 이어붙인 문자열을 반환한다. (예: '사과' -> 'ㅅㅏㄱㅗㅏ')
    """
    result = []
    for char in text:
        # 한글 범위(가 ~ 힣) 확인
        if '가' <= char <= '힣':
            code_point = ord(char) - ord('가')
            chosung_index = code_point // (21 * 28)
            jungseong_index = (code_point // 28) % 21
            jongseong_index = code_point % 28

            # 초성 / 중성 / 종성이 존재하면 각각 추가
            result.append(CHOSEONG_LIST[chosung_index])
            result.append(JUNGSEONG_LIST[jungseong_index])
            if jongseong_index != 0:  # 종성이 있으면
                result.append(JONGSEONG_LIST[jongseong_index])
        else:
            # 한글이 아닌 경우도 그대로 추가하거나,
            # 필요하다면 예외 처리
            result.append(char)
    return "".join(result)

def autocomplete(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            query = data.get('query', '').strip()

            if not query:
                return JsonResponse({'suggestions': []}, status=200)

            # 1) 사용자가 입력한 문자열 자모 분해
            query_jamo = decompose_korean_to_jamo(query)

            # 2) DB에서 Book 전부 가져오거나(데모용),
            #    혹은 어느 정도 필터링(Q로 title__icontains=query) 한 뒤 가져오기
            books = Book.objects.all()  
            # books = Book.objects.filter(Q(title__icontains=query) | Q(author__icontains=query))

            suggestions = []
            for book in books:
                # 책 제목 자모 분해
                title_jamo = decompose_korean_to_jamo(book.title)

                # 3) 부분 문자열 검사 (query_jamo in title_jamo)
                if query_jamo in title_jamo:
                    suggestions.append(book.title)

            # 최대 5개만 반환
            suggestions = suggestions[:5]

            return JsonResponse({'suggestions': suggestions}, status=200)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

    return JsonResponse({'error': 'Invalid request method'}, status=400)

def book_search(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            query = data.get('query', '').strip()

            if not query:
                return JsonResponse({'results': []}, status=200)

            query_jamo = decompose_korean_to_jamo(query)
            books = Book.objects.all()
            matched_books = []

            for book in books:
                title_jamo = decompose_korean_to_jamo(book.title)
                author_jamo = decompose_korean_to_jamo(book.author)

                # 제목 혹은 저자 자모 분해에서 부분 일치 시
                if query_jamo in title_jamo or query_jamo in author_jamo:
                    matched_books.append({
                        'id': book.id,
                        'title': book.title,
                        'author': book.author,
                        'publisher': book.publisher,
                        'publication_year': book.publication_year
                    })

            return JsonResponse({'results': matched_books}, status=200)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

    return JsonResponse({'error': 'Invalid request method'}, status=400)