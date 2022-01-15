from django.contrib import admin

from .models import BankAccount, Cash, CreditCard
from .models import Currency
from .models import Category
from .models import Transaction
from .models import WhatsDiffBtwStatusAndTextChoiceField

admin.site.register(BankAccount)
admin.site.register(Cash)
admin.site.register(CreditCard)
admin.site.register(Currency)
admin.site.register(Category)
admin.site.register(Transaction)
admin.site.register(WhatsDiffBtwStatusAndTextChoiceField)
