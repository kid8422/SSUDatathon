from django.urls import path
from . import views

urlpatterns = [
    path('', views.DB_home, name='DB_home'),
    path('login/', views.DB_login, name='DB_login'),
    path('logout/', views.DB_logout, name='DB_logout'),
    #path('login-redirect/', views.login_redirect, name='login_redirect'),
]