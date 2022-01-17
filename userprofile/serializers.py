from rest_framework import serializers
from dj_rest_auth.serializers import LoginSerializer as RestAuthLoginSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer as RestAuthRegisterSerializer
# from dj_rest_auth.views import LoginView

from django.contrib.auth import get_user_model
from .models import User

UserModel = get_user_model()


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = (
            'id',
            'username',
            'email',
            'first_name', 'last_name',
            'date_joined',
            'photo',
            'date_of_birth',
            'mobile_number',
            'rrn',
            'country_of_origin',
            'location',
            'deleted_at',
        )
        read_only_fields = ('id', 'email', 'date_joined', 'deleted_at', )


class UserLoginSerializer(RestAuthLoginSerializer):
    username = None

class UserSignUpSerializer(RestAuthRegisterSerializer):
    username = None
    password1 = serializers.CharField(write_only=True, style={'input_type': 'password'})
    password2 = serializers.CharField(write_only=True, style={'input_type': 'password'})