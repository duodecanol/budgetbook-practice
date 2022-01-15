
from rest_framework import viewsets, generics
from rest_framework import permissions
from rest_framework.response import Response

from rest_framework.views import APIView

from .models.assets import Asset, BankAccount, Cash, CreditCard
from .serializers import AssetSerializer, AssetDetailsSerializer, BankAccountSerializer, CashSerializer, \
    CreditCardSerializer, AssetYetAnotherSerializer


class UserBankAccountViewSet(viewsets.ModelViewSet):

    serializer_class = BankAccountSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return BankAccount.objects.filter(owner=self.request.user).order_by('create_date')


class UserCashViewSet(viewsets.ModelViewSet):

    serializer_class = CashSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Cash.objects.filter(owner=self.request.user).order_by('create_date')


class UserCreditCardViewSet(viewsets.ModelViewSet):

    serializer_class = CreditCardSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return CreditCard.objects.filter(owner=self.request.user).order_by('create_date')


class AssetList(viewsets.ModelViewSet):
    # queryset = Asset.objects.all().filter(owner=request.Request.user)
    serializer_class = AssetSerializer
    # permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        Asset.objects.select_subclasses()
        return Asset.objects.filter(owner=user)  # Filtering by Model Object
        # return Asset.objects.raw("SELECT * FROM budgetbook_asset WHERE owner_id = %s", [user.pk])

    # def perform_create(self, serializer):
    #     serializer.data.owner = self.request.user
    #     super(AssetViewSet, self).perform_create(serializer)

class AssetYetAnotherViewSet(viewsets.ModelViewSet):
    serializer_class = AssetYetAnotherSerializer
    queryset = Asset.objects.all()

class AssetSubClassFieldsMixin(object):

    def get_queryset(self):
        return Asset.objects.select_subclasses()


class RetrieveAssetAPIView(AssetSubClassFieldsMixin, generics.RetrieveDestroyAPIView):
    serializer_class = AssetSerializer



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

