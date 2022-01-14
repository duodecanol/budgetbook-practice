from django.contrib.auth.models import AbstractUser, UserManager
from django.db import models
from django.utils.translation import gettext_lazy as _


class UserAccountManager(UserManager):

    # 추후 가입 폼 필수기재 항목 변경을 위한 함수 등록
    def create_user(self, username, email=None, password=None, **extra_fields):
        return super().create_user(username=username,
                                   email=email,
                                   password=password,
                                   **extra_fields)

    def create_superuser(self, username, email=None, password=None, **extra_fields):
        return super().create_superuser(username=username,
                                        email=email,
                                        password=password,
                                        **extra_fields)


class User(AbstractUser):
    """
    기본 유저 클래스를 확장하여 사용. 기본필드는 필요하므로 AbstractBaseUser보다는 AbstractUser를 상속받는다.
    """
    # TODO: 기본 속성 is_active가 False이면 로그인 불가하도록
    photo = models.ImageField(_('User Photo'), upload_to='users/photos', null=True, blank=True)
    date_of_birth = models.DateField(_('Date of birth'), null=True, blank=True)
    mobile_number = models.CharField(_('User mobile phone number'),  max_length=15, null=True, blank=True)
    rrn = models.CharField(_('Resident Registration Number'), max_length=63, null=True, blank=True)
    country_of_origin = models.CharField(_('User country of origin'),  max_length=255, null=True, blank=True)
    location = models.CharField(_('User location'),  max_length=255, null=True, blank=True)
    is_deleted = models.BooleanField(_('User is deleted'), default=False)
    # TODO: Reference Models
    # default_currency = models.CharField(_('Default Currency'),  max_length=3, null=True, blank=True)
    # user_assets =

    # REQUIRED_FIELDS = []

    objects = UserAccountManager()

    class Meta:
        verbose_name = 'user'
        verbose_name_plural = 'users'
        ordering = ['-date_joined']  # 가입한 날짜 순으로 정렬
