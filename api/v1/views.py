from rest_framework import viewsets
from rest_framework import permissions
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend

from api.v1.serializers import *


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
            return Transaction.all_objects.all().order_by('create_date')

        return Transaction.objects.all().filter(payment_method__owner=user).order_by('create_date')

    def destroy(self, request, *args, **kwargs):
        self.get_object().soft_delete()
        return Response({'message': f"transaction deleted"})



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
        #TODO: production 에서는 objects.all()
        return Currency.objects.filter(code__in=['KRW', 'USD', 'JPY', 'CNY', 'EUR', 'BTC', 'GBP'])
