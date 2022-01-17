from django.contrib.auth.models import AbstractUser, UserManager
from django.db import models
from django.utils.translation import gettext_lazy as _


class UserAccountManager(UserManager):

    # 추후 가입 폼 필수기재 항목 변경을 위한 함수 등록
    def create_user(self, username, email=None, password=None, **extra_fields):
        return super().create_user(username=email,  # username은 email과 같게
                                   email=email,
                                   password=password,
                                   **extra_fields)

    def create_superuser(self, username, email=None, password=None, **extra_fields):
        return super().create_superuser(username=email,  # username은 email과 같게
                                        email=email,
                                        password=password,
                                        **extra_fields)


class User(AbstractUser):
    """
    기본 유저 클래스를 확장하여 사용. 기본필드는 필요하므로 AbstractBaseUser보다는 AbstractUser를 상속받는다.
    """
    photo = models.ImageField(_('User Photo'), upload_to='users/photos', null=True, blank=True)
    date_of_birth = models.DateField(_('Date of birth'), null=True, blank=True)
    mobile_number = models.CharField(_('User mobile phone number'),  max_length=15, null=True, blank=True)
    rrn = models.CharField(_('Resident Registration Number'), max_length=63, null=True, blank=True, unique=True)
    country_of_origin = models.CharField(_('User country of origin'),  max_length=255, null=True, blank=True)
    location = models.CharField(_('User location'),  max_length=255, null=True, blank=True)
    deleted_at = models.DateTimeField(_('User is deleted'), null=True, default=None, help_text='삭제 상태를 나타냅니다')

    # TODO: Reference Models
    # default_currency = models.CharField(_('Default Currency'),  max_length=3, null=True, blank=True)
    # user_assets = 뷰에서 구현

    REQUIRED_FIELDS = ['email']
    EMAIL_FIELD = 'email'

    objects = UserAccountManager()

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')
        ordering = ['-date_joined']  # 가입한 날짜 순으로 정렬

    def __str__(self):
        return self.email
