
from rest_framework import viewsets, generics
from rest_framework import permissions
from rest_framework.response import Response

from rest_framework.views import APIView

from .models.assets import Asset, BankAccount, Cash, CreditCard
from .models.currency import Currency
from .models.categories import Category
from .models.transaction import Transaction
from budgetbook.serializers import *


class BankAccountViewSet(viewsets.ModelViewSet):

    serializer_class = BankAccountSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return BankAccount.objects.filter(owner=user).order_by('create_date')


class CashViewSet(viewsets.ModelViewSet):

    serializer_class = CashSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Cash.objects.filter(owner=user).order_by('create_date')


class CreditCardViewSet(viewsets.ModelViewSet):

    serializer_class = CreditCardSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return CreditCard.objects.filter(owner=user).order_by('create_date')


class AssetViewSet(viewsets.ModelViewSet):

    serializer_class = AssetSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        # Model assets에 InheritanceManager가 object를 관리하여 서브클래스 선택이 가능하도록 함.
        return Asset.objects.filter(owner=user).select_subclasses()  # Filtering by Model Object
        # return Asset.objects.raw("SELECT * FROM budgetbook_asset WHERE owner_id = %s", [user.pk])

    # def perform_create(self, serializer):
    #     serializer.data.owner = self.request.user
    #     super(AssetViewSet, self).perform_create(serializer)

class TransactionViewSet(viewsets.ModelViewSet):

    serializer_class = TransactionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        # payment_method가 asset을 참조하므로 그 소유자인 owner가 user와 일치하는 결과만을 보여준다.
        user = self.request.user
        return Transaction.objects.all().filter(payment_method__owner=user).order_by('create_date')
        # return Transaction.objects.all().order_by('create_date')


class CategoryViewSet(viewsets.ModelViewSet):

    serializer_class = CategorySerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Category.objects.all()


class CurrencyViewSet(viewsets.ModelViewSet):

    serializer_class = CurrencySerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Currency.objects.all()



## TRASH
class RawQueryDjango(viewsets.GenericViewSet):
    def get(self):
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM budgetbook_asset")
            rows = cursor.fetchall()
            # serializer = RawQuerySerializer(rows, many=True)
            print(rows)
            return Response({'detail': 1111 })

