from rest_framework import generics, permissions, status
from rest_framework.views import APIView
from rest_framework.response import Response
from knox.models import AuthToken
from .serializers import UserSerializer, RegisterSerializer, ScoreSerializer
from django.contrib.auth import login, logout
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from rest_framework import permissions
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView
from .models import ScoreModel
from .forms import MemberDetailForm
from django.views.decorators.csrf import csrf_exempt

from django.contrib.auth.decorators import login_required


def form_view(request_iter):
    form = MemberDetailForm()
    return  render(request_iter,'index.html', {"form": form})

class DeleteEntry(APIView):
    def delete(self, request, user_id: int, format=None):
        try: 
            score = ScoreModel.objects.get(user_name=user_id) 
        except ScoreModel.DoesNotExist: 
            return Response({'message': 'The score does not exist'}, status=status.HTTP_404_NOT_FOUND) 
        score.delete()
        return Response({'message': 'Success'}, status=status.HTTP_200_OK)



class GetUserName(APIView):
    def get(self, request, user_id: int, format=None):
        queryset = User.objects.all()
        if user_id is not None:
            queryset = queryset.filter(id__exact=user_id)

        if len(queryset) == 0:
            return Response({"Error": "No output for the selected user"},
                            status=status.HTTP_404_NOT_FOUND)

        serialize = UserSerializer(queryset[0])
        output_data = serialize.data['username']
        return Response(output_data)    

class GetUserScore(APIView):
    def get(self, request, user_id: int, format=None):
        queryset = ScoreModel.objects.all()
        if user_id is not None:
            queryset = queryset.filter(user_name__exact=user_id)

        if len(queryset) == 0:
            return Response({"Error": "No output for the selected user"},
                            status=status.HTTP_404_NOT_FOUND)

        serialize = ScoreSerializer(queryset[0])
        output_data = serialize.data
        return Response(output_data)

class GetAllScore(APIView):
    def get(self, request, format=None):
        queryset = ScoreModel.objects.all().order_by('score')
        if len(queryset) == 0:
            return Response({"Error": "No scores in the Database."},
                            status=status.HTTP_404_NOT_FOUND)
        serialize = ScoreSerializer(queryset, many=True)
        return Response(serialize.data)


class UpdateDetails(APIView):
    def post(self, request, format=None):
        form = MemberDetailForm(request.POST)

        if form.is_valid() and request.user.is_authenticated:
            print(request.user)
            members = form.cleaned_data['members']
            house_size = form.cleaned_data['house_size']
            food_choices = form.cleaned_data['food_choices']
            water_con = form.cleaned_data['water_consumption']
            water_freq = form.cleaned_data['water_frequency']
            purch = form.cleaned_data['purchases']
            waste_prod = form.cleaned_data['waste_production']
            re = form.cleaned_data['recycle']
            car = form.cleaned_data['transport_car'] 
            public = form.cleaned_data['transport_public'] 
            air = form.cleaned_data['transport_air']

            total_score = 0

            total_score = house_score(members, house_size)
            total_score = food_score(food_choices, total_score)
            total_score = water_score(water_con, water_freq, total_score)
            total_score = misc_score(purch, re, waste_prod, total_score)
            total_score = transport_score(car, public, air, total_score)
            
            newScore = ScoreModel(user_name=request.user, score=total_score)
            newScore.save()

            return Response({"score" : total_score}, status=status.HTTP_200_OK)
        elif not request.user.is_authenticated:
            return Response({"Error" : "User GG"}, status=status.HTTP_403_FORBIDDEN)
        else :
            print(form.errors)
            print(form.is_valid)
            return Response({"Error" : 'GG'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
# Grades calucaltion
def house_score(mem : int, size : int):
    score = 0
    if mem == 1:
        score = 14
    elif mem == 2:
        score = 12
    elif mem == 3:
        score = 10
    elif mem == 4:
        score = 8
    elif mem == 5:
        score = 6
    elif mem == 6:
        score = 4
    else :
        score = 2

    if size == 0:
        score += 10
    elif size == 1:
        score += 7
    elif size == 2:
        score += 4
    else :
        score += 2

    return score

def food_score(type : int, current_score : int) :
    if type == 0:
        current_score += 10
    elif type == 1:
        current_score += 8
    elif type == 2:
        current_score += 4
    elif type == 3:
        current_score += 2
    else :
        current_score += 12

    return current_score

def water_score(type: int, freq: int, current_score:int):
    temp_score = 0
    if type == 3:
        return current_score
    else:
        if type == 2:
            if freq > 9:
                temp_score += 3*2
            elif freq > 4 and freq <= 9:
                temp_score += 2*2
            else:
                temp_score += 1*2
        else :
            if freq > 9:
                temp_score += 3
            elif freq > 4 and freq <= 9:
                temp_score += 2
            else:
                temp_score += 1
    res = current_score + temp_score
    return res

def misc_score(purchase: int, recyc : int, waste: int, current_score : int):
    purchase_score = 0
    waste_score = 0
    recycle_score = 24 - (4 * recyc) 
    
    if purchase > 7:
        purchase_score = 10
    elif purchase > 5 and purchase <= 7:
        purchase_score = 8
    elif purchase > 3 and purchase <= 5:
        purchase_score = 6
    elif purchase <= 3 and purchase > 0:
        purchase_score = 4
    else :
        purchase_score = 2

    if waste == 4:
        waste_score = 50
    elif waste == 3:
        waste_score = 40
    elif waste == 2:
        waste_score = 30
    elif waste == 1:
        waste_score = 20
    else :
        waste_score = 5

    return current_score + purchase_score + waste_score + recycle_score

def transport_score(miles_by_car : int, miles_by_public: int, distance_by_air : int, current_score: int):
    car_score = 0
    public_score = 0
    air_score = 0

    if miles_by_car > 15000:
        car_score = 12
    elif miles_by_car > 10000 and miles_by_car <= 15000:
        car_score = 10
    elif miles_by_car > 1000 and miles_by_car <= 10000:
        car_score = 6
    elif miles_by_car > 1 and miles_by_car <= 1000:
        car_score = 4
    else:
        # I don't own a car
        car_score = 0

    if miles_by_public > 20000:
        public_score = 12
    elif miles_by_public > 15000 and miles_by_public <= 20000:
        public_score = 10
    elif miles_by_public > 10000 and miles_by_public <= 15000:
        public_score = 6
    elif miles_by_public > 1000 and miles_by_public <= 10000:
        public_score = 4
    elif miles_by_public > 1 and miles_by_public <= 1000:
        public_score = 2
    else:
        # I don't use public transport
        public_score = 0

    if distance_by_air == 1:
        air_score = 2
    elif distance_by_air == 2:
        air_score = 6
    elif distance_by_air == 3:
        air_score = 20

    return current_score + car_score + public_score + air_score

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
        super(LoginAPI, self).post(request, format=None)
        return Response({
        "user": UserSerializer(user).data,
        "token": AuthToken.objects.create(user)[1],
        })

# These two endpoints uses model//


# # Get details API (can be used for displaying data)
# class GetData(APIView):

#     def get(self, request, user: int, format=None):
#         queryset = MemberDetails.objects.filter(user_name__exact=user)
#         if not queryset.exists():
#             return Response(
#                 {
#                     "user": user,
#                     "Error": "No details for this user"
#                 }, status=status.HTTP_404_NOT_FOUND)
                
#         serialize = DetailsSerializer(queryset[0])
#         output_data = serialize.data

#         return Response(output_data)

# # Details API
# class DetailEntryAPI(generics.GenericAPIView):
#     serializer_class = DetailsSerializer

#     def post(self, request, *args, **kwargs):
#         if not request.user.is_authenticated:
#             return Response({
#                 "Error" : "No user logged in."
#             })
#         serializer = self.get_serializer(data=request.data)
#         serializer.is_valid(raise_exception=True)
#         user_data = serializer.save(user_name=request.user)
#         return Response({
#         "details": DetailsSerializer(user_data, context=self.get_serializer_context()).data
#         }, status=status.HTTP_200_OK)