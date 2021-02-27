from .views import RegisterAPI, LoginAPI, GetData, DetailEntryAPI
from knox import views as knox_views
from django.urls import path, include
from django.contrib.auth.views import LogoutView
from django.conf import settings
from django.conf.urls import url

urlpatterns = [
    path('user/register/', RegisterAPI.as_view(), name='register'),
    path('user/login/', LoginAPI.as_view(), name='login'),
    path('get-user-details/<int:user>', GetData.as_view(), name='data'),
    path('post-user-details', DetailEntryAPI.as_view(), name='data_upload'),
    path("user/logout/", LogoutView.as_view(), name="logout")
]