from django.db import models
from .currency import Currency

class Asset(models.Model):

    name = models.CharField('name', max_length=255)
    amount = models.DecimalField('amount', decimal_places=4, max_digits=16)
    create_date = models.DateTimeField('creation date', auto_now_add=True, editable=False)
    is_active = models.BooleanField('is active', default=True)
    data = models.JSONField('related data', null=True, blank=True)

    class Meta:
        abstract = True


class BankAccount(Asset):

    bank_name = models.CharField('bank name', max_length=255)
    account_number = models.CharField('bank account number', max_length=255)
    currency = models.ForeignKey(Currency, related_name='bankaccounts', on_delete=models.CASCADE)


class Cash(Asset):
    currency = models.ForeignKey(Currency, related_name='cashes', on_delete=models.CASCADE)
    pass


class CreditCard(Asset):

    card_company_name = models.CharField('card company name', max_length=255)
    currency = models.ForeignKey(Currency, related_name='creditcards', on_delete=models.CASCADE)
    monthly_limit = models.DecimalField('card monthly limit amount', decimal_places=4, max_digits=16)
