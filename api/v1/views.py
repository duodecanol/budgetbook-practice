from rest_framework import viewsets
from rest_framework import permissions
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend

from api.v1.serializers import *
import logging

class BankAccountViewSet(viewsets.ModelViewSet):

    serializer_class = BankAccountSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if user.is_anonymous:
            return BankAccount.objects.none()
        elif user.is_superuser:  # 관리자는 모든 결과를 볼 수 있다.
            return BankAccount.all_objects.all().order_by('create_date')

        return BankAccount.objects.filter(owner=user).order_by('create_date')

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"bank account deleted"})


class CashViewSet(viewsets.ModelViewSet):

    serializer_class = CashSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if user.is_anonymous:
            return Cash.objects.none()
        elif user.is_superuser:  # 관리자는 모든 결과를 볼 수 있다.
            return Cash.all_objects.all().order_by('create_date')

        return Cash.objects.filter(owner=user).order_by('create_date')

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"cash deleted"})


class CreditCardViewSet(viewsets.ModelViewSet):

    serializer_class = CreditCardSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if user.is_anonymous:
            return CreditCard.objects.none()
        elif user.is_superuser:  # 관리자는 모든 결과를 볼 수 있다.
            return CreditCard.all_objects.all().order_by('create_date')

        return CreditCard.objects.filter(owner=user).order_by('create_date')

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"credit card deleted"})


class AssetViewSet(viewsets.ModelViewSet):

    serializer_class = AssetSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if user.is_anonymous:
            return Asset.objects.none()
        elif user.is_superuser:  # 관리자는 모든 결과를 볼 수 있다.
            return Asset.all_objects.all().order_by('create_date')

        # Model assets에 InheritanceManager가 object를 관리하여 서브클래스 선택이 가능하도록 함.
        return Asset.objects.filter(owner=user).select_subclasses()  # Filtering by Model Object
        # return Asset.objects.raw("SELECT * FROM budgetbook_asset WHERE owner_id = %s", [user.pk])

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"asset deleted"})

    # def perform_create(self, serializer):
    #     serializer.data.owner = self.request.user
    #     super(AssetViewSet, self).perform_create(serializer)

class TransactionViewSet(viewsets.ModelViewSet):

    serializer_class = TransactionSerializer
    permission_classes = [permissions.IsAuthenticated]

    #TODO: 복구 요청시 post요청으로 받아서 self.get_object().restore() 실행한다.

    def get_queryset(self):
        # payment_method가 asset을 참조하므로 그 소유자인 owner가 user와 일치하는 결과만을 보여준다.
        user = self.request.user
        if user.is_anonymous:
            return Transaction.objects.none()
        elif user.is_superuser:  # 관리자는 모든 결과를 볼 수 있다.
            return Transaction.all_objects.all().order_by('-create_date')  # DESC

        return Transaction.objects.all().filter(payment_method__owner=user).order_by('-create_date')

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"transaction deleted"})

    @action(methods=['GET'], detail=False, permission_classes=[permissions.IsAuthenticated],
            url_path=r'deleteds', url_name='deleted-list', name='Deleted list')
    def get_deleteds(self, request):
        user = self.request.user
        deleted_transactions = None

        if user.is_anonymous:
            return Transaction.objects.none()
        elif user.is_superuser:
            deleted_transactions = Transaction.all_objects.all() \
                .filter(deleted_at__isnull=False) \
                .order_by('-deleted_at')
        elif user.is_authenticated:
            deleted_transactions = Transaction.all_objects.all() \
                .filter(deleted_at__isnull=False) \
                .filter(payment_method__owner=user) \
                .order_by('-deleted_at')

        page = self.paginate_queryset(deleted_transactions)

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(deleted_transactions, many=True)

        return Response(serializer.data)

    @action(methods=['GET'], detail=False, permission_classes=[permissions.IsAuthenticated],
            url_path=r'deleteds/(?P<deleted_transaction_id>[0-9]+)',
            url_name='deleted-detail', name='Deleted detail')
    def get_deleted(self, request, deleted_transaction_id):
        user = self.request.user
        deleted_transactions = None

        if user.is_anonymous:
            return Transaction.objects.none()
        elif user.is_superuser:
            deleted_transactions = Transaction.all_objects.all()\
                .filter(deleted_at__isnull=False) \
                .order_by('-deleted_at')
        elif user.is_authenticated:
            deleted_transactions = Transaction.all_objects.all() \
                .filter(deleted_at__isnull=False) \
                .filter(payment_method__owner=user) \
                .order_by('-deleted_at')

        serializer = self.get_serializer(deleted_transactions, many=True)
        deleted_transaction_id = int(deleted_transaction_id)
        data_length = deleted_transactions.count()

        if deleted_transaction_id < 0 or deleted_transaction_id > data_length - 1:
            return Response({'message': f"Index out of range. Input valid value from 0 to {data_length - 1}"})

        return Response(serializer.data[deleted_transaction_id])

    @get_deleted.mapping.delete
    def delete_deleted(self, request, deleted_transaction_id, *args, **kwargs):
        user = self.request.user
        deleted_transactions = None

        if user.is_anonymous:
            return Transaction.objects.none()
        elif user.is_superuser:
            deleted_transactions = Transaction.all_objects.all()\
                .filter(deleted_at__isnull=False) \
                .order_by('-deleted_at')
        elif user.is_authenticated:
            deleted_transactions = Transaction.all_objects.all() \
                .filter(deleted_at__isnull=False) \
                .filter(payment_method__owner=user) \
                .order_by('-deleted_at')

        deleted_transaction_id = int(deleted_transaction_id)
        data_length = deleted_transactions.count()

        if deleted_transaction_id < 0 or deleted_transaction_id > data_length - 1:
            return Response({'message': f"Index out of range. Input valid value from 0 to {data_length - 1}"})

        deleted_transaction = deleted_transactions[deleted_transaction_id]
        deleted_transaction.restore()

        return Response({'massage': f"Transaction restored: [{deleted_transaction.pk}] {deleted_transaction.title}, "
                                    f"{deleted_transaction.amount}, {deleted_transaction.seller}"})




class CategoryViewSet(viewsets.ModelViewSet):

    serializer_class = CategorySerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['classification', 'name', 'is_active']

    def get_queryset(self):
        if self.request.user.is_anonymous:
            return Category.objects.none()
        elif self.request.user.is_superuser:
            return Category.all_objects.all()

        return Category.objects.all()

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"category deleted"})


class CurrencyViewSet(viewsets.ModelViewSet):

    serializer_class = CurrencySerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    http_method_names = ['get', 'options']  # 현재 단계에서는 get만 가능하도록 제한한다.

    def get_queryset(self):
        if self.request.user.is_anonymous:
            return Currency.objects.none()
        elif self.request.user.is_superuser:
            return Currency.objects.all()
        #TODO: production 에서는 objects.all()  // 여기서 필터링하지 말고 모델 object에서 필터링한다. Asset 추가 옵션으로 모두 나옴.
        return Currency.objects.filter(code__in=['KRW', 'USD', 'JPY', 'CNY', 'EUR', 'BTC', 'GBP'])
