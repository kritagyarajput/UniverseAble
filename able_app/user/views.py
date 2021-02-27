from rest_framework import generics, permissions, status
from rest_framework.views import APIView
from rest_framework.response import Response
from knox.models import AuthToken
from .serializers import UserSerializer, RegisterSerializer, DetailsSerializer
from django.contrib.auth import login
from django.contrib.auth.models import User
from rest_framework import permissions
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView
from .models import MemberDetails

# Register API
class RegisterAPI(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        return Response({
        "user": UserSerializer(user, context=self.get_serializer_context()).data,
        "token": AuthToken.objects.create(user)[1]
        })

# Login API
class LoginAPI(KnoxLoginView):
    permission_classes = (permissions.AllowAny,)

    def post(self, request, format=None):
        serializer = AuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        login(request, user)
        return super(LoginAPI, self).post(request, format=None)

class GetData(APIView):
    def get(self, request, user: int, format=None):
 
        queryset = MemberDetails.objects.filter(user_name__exact=user)
        if not queryset.exists():
            return Response(
                {
                    "user": user,
                    "Error": "No details for this user"
                }, status=status.HTTP_404_NOT_FOUND)
                
        serialize = DetailsSerializer(queryset[0])
        output_data = serialize.data

        return Response(output_data)
