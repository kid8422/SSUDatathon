import mysql.connector
import csv

# MySQL 데이터베이스 연결
db = mysql.connector.connect(
    host="svc.sel4.cloudtype.app",     # MySQL 서버 주소
    user="root",          # 사용자 이름
    password="m4pkylkb0b6ccde8",  # 비밀번호
    database="hardcoding", # 데이터베이스 이름
    charset="utf8mb4",
    collation="utf8mb4_general_ci",
    port=30584
)

cursor = db.cursor()

# 텍스트 파일 읽기 및 데이터 삽입
with open('../Data/단행본(도서)정보.txt', 'r', encoding='euc-kr') as file:
    reader = csv.reader(file)
    next(reader)  # 첫 번째 행(헤더) 건너뛰기

    # INSERT 쿼리 작성
    query = """
        INSERT INTO book (ID, registration, get_course, DDC, ISBN, title, author, publisher, publication_year, location)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    for row in reader:
        cursor.execute(query, row)

# 변경 사항 저장 및 연결 종료
db.commit()
cursor.close()
db.close()

print("데이터 삽입 완료!")
