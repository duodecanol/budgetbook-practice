from django.db import models
from django.contrib.auth import get_user_model


User = get_user_model()


class Currency(models.Model):
    """
        금액의 currency 적용 모델
    """

    name = models.CharField('Currency name', max_length=128)
    code = models.CharField('Currency code', max_length=6, blank=True)
    sign = models.CharField('Currency sign', max_length=6)
    favorite = models.ManyToManyField(User, related_name="favoritesCurrencies")

    class Meta:
        ordering = ('name', )
        verbose_name = 'Currency'
        verbose_name_plural = 'Currencies'

    def __str__(self):
        return f"{self.name} [{self.code}]"

