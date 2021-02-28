from rest_framework import serializers
from django.contrib.auth.models import User
from .models import ScoreModel

# User Serializer
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email')

# Register Serializer
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(validated_data['username'], validated_data['email'], validated_data['password'])

        return user

class ScoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = ScoreModel
        fields = ('id', 'user_name', 'score')
        
# class DetailsSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = MemberDetails
#         fields = ('id', 'user_name', 'members', 'house_size', 'food_choices', 'water_consumption', 'water_frequency', 'purchases'
#         , 'waste_production', 'recycle', 'transport_car', 'transport_public', 'transport_air')
#         read_only_fields = ('id', 'user_name')