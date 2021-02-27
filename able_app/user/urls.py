from .views import RegisterAPI, LoginAPI, GetData
from knox import views as knox_views
from django.urls import path

urlpatterns = [
    path('user/register/', RegisterAPI.as_view(), name='register'),
    path('user/login/', LoginAPI.as_view(), name='login'),
    path('user/logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('user/logoutall/', knox_views.LogoutAllView.as_view(), name='logoutall'),
    path('get-user-details/<int:user>', GetData.as_view(), name='data')
]