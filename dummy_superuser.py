from django.contrib.auth import get_user_model
from decouple import config

UserModel = get_user_model()

if not UserModel.objects.filter(username=config('DJANGO_SUPERUSER_USERNAME')).exists():
    user = UserModel.objects.create_user(
        username=config('DJANGO_SUPERUSER_USERNAME'),
        email=config('DJANGO_SUPERUSER_EMAIL'),
        password=config('DJANGO_SUPERUSER_PASSWORD'))
    user.is_superuser = True
    user.is_staff = True
    user.save()
