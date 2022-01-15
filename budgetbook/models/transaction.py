from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils.translation import gettext as _
from model_utils.fields import StatusField
from model_utils import Choices

from budgetbook.models import Asset, Currency, Category


class Transaction(models.Model):
    class TransactionClassification(models.IntegerChoices):
        EXPENSE = 0
        INCOME = 1
        TRANSFER = 2

    title = models.CharField(_('transaction title'), max_length=127)
    amount = models.DecimalField(_('amount'), decimal_places=4, max_digits=65)
    classification = models.IntegerField(_('transaction classification'),
                                         choices=TransactionClassification.choices,
                                         default=TransactionClassification.EXPENSE)
    currency = models.ForeignKey(Currency, verbose_name=_('currency'),
                                 related_name='transactions',
                                 on_delete=models.PROTECT)
    seller = models.CharField(_('seller name'), max_length=127, help_text='거래처명. 거래한 업체의 상호명 개인의 이름 등')
    transaction_datetime = models.DateTimeField(_('datetime of transaction'), null=True)
    payment_method = models.ForeignKey(Asset, verbose_name=_('payment method'),
                                       related_name='transactions',
                                       on_delete=models.PROTECT)
    category = models.ForeignKey(Category, verbose_name=_('transaction category'),
                                 related_name='transactions',
                                 null=True, blank=True,
                                 on_delete=models.PROTECT)
    data = models.JSONField(_('additional transaction data'), null=False, blank=False, help_text='추가적인 세부내역/기재사항 등을 저장')
    create_date = models.DateTimeField(_('created datetime of this item'), auto_now_add=True, editable=False)
    last_modified = models.DateTimeField(_('last modified'), auto_now=True)
    is_active = models.BooleanField(_('is active'), default=True)
    is_deleted = models.BooleanField(_('is deleted'), default=False)

    def __str__(self):
        return f"[{self.pk}], ({self.title}) {self.amount} => {self.data} __ {self.currency}"


class WhatsDiffBtwStatusAndTextChoiceField(models.Model):
    CUSTOM_CHOICES = Choices('borned_remit', 'borned_payin',
                     'noticed_remit', 'noticed_payin',
                     'done_remit', 'done_payin')
    class CustomIntChoice(models.IntegerChoices):
        EXPENSE = 0
        INCOME = 1
        TRANSFER = 2
    class CustomCharChoice(models.TextChoices):
        EXPENSE = 'EX', 'Expense'
        INCOME = 'IN', 'Income'
        TRANSFER = 'TR', 'Transfer'

    int_choice_field = models.IntegerField(choices=CustomIntChoice.choices)
    txt_choice_filed = models.CharField(choices=CustomCharChoice.choices, max_length=2, default=CustomCharChoice.EXPENSE)
    status_filed = StatusField(choices_name='CUSTOM_CHOICES')