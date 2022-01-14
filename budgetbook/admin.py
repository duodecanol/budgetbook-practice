from django.contrib import admin

from .models import BankAccount, Cash, CreditCard
from .models import Currency

admin.site.register(BankAccount)
admin.site.register(Cash)
admin.site.register(CreditCard)
admin.site.register(Currency)
