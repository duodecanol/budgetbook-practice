from django.contrib.auth import get_user_model

UserModel = get_user_model()


user = UserModel.objects.create_user(
    username='test1@test.com',
    email='test1@test.com',
    password='1111')
user.is_superuser = False
user.is_staff = False
user.save()

user = UserModel.objects.create_user(
    username='test2@test.com',
    email='test2@test.com',
    password='1111')
user.is_superuser = False
user.is_staff = False
user.save()

user = UserModel.objects.create_user(
    username='test3@test.com',
    email='test3@test.com',
    password='1111')
user.is_superuser = False
user.is_staff = False
user.save()