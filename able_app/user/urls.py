from .views import RegisterAPI, LoginAPI, GetAllScore, UpdateDetails
from knox import views as knox_views
from django.urls import path, include
from django.contrib.auth.views import LogoutView
from django.conf import settings
from django.conf.urls import url
from user import views

urlpatterns = [
    path('user/register/', RegisterAPI.as_view(), name='register'),
    path('user/login/', LoginAPI.as_view(), name='login'),
    path('get-all-scores/', GetAllScore.as_view(), name='scores'),
    path('post-details/', UpdateDetails.as_view(), name='details'),
    path("user/logout/", LogoutView.as_view(), name="logout"),
    path('form/', views.form_view, name="form")
]