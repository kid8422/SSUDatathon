from django.urls import path
from . import views

urlpatterns = [
    path('', views.DB_home, name='DB_home'),
    path('login/', views.DB_login, name='DB_login'),
    path('logout/', views.DB_logout, name='DB_logout'),
    path('book_info/', views.book_info, name='book_info'),
    path('rent_info/', views.rent_info, name='rent_info'),
    path('search/', views.search, name='search_info'),
    path('DB_book/', views.DB_book, name='book_set'),
    path('DB_rent/', views.DB_rent, name='rent_set'),
    path('DB_except/', views.DB_except, name='except_set'),
    path('predict_f4/', views.predict_f4, name='f4_predict'),
    path('predict_b1/', views.predict_b1, name='b1_predict'),
    path('ratio_setting/', views.ratio_setting, name='ratio_predict'),
    #path('login-redirect/', views.login_redirect, name='login_redirect'),
]