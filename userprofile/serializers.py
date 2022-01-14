from rest_framework import serializers

from .models import User


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
            'is_deleted',
        )