from rest_framework import serializers

from budgetbook.models.assets import (Asset, BankAccount, Cash, CreditCard)
from budgetbook.models.currency import Currency
from budgetbook.models.categories import Category
from budgetbook.models.transaction import Transaction


class AssetSerializer(serializers.ModelSerializer):

    def to_representation(self, instance):
        if isinstance(instance, BankAccount):
            return BankAccountSerializer(instance=instance).data
        elif isinstance(instance, Cash):
            return CashSerializer(instance=instance).data
        elif isinstance(instance, CreditCard):
            return CreditCardSerializer(instance=instance).data

    class Meta:
        model = Asset
        fields = '__all__'


class BankAccountSerializer(serializers.ModelSerializer):
    transactions = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='transaction-detail'
    )

    class Meta:
        model = BankAccount
        fields = [
            'name',
            'bank_name',
            'currency',
            'account_number',
            'owner',
            'transactions',
        ]


class CashSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cash
        fields = '__all__'


class CreditCardSerializer(serializers.ModelSerializer):
    class Meta:
        model = CreditCard
        fields = '__all__'

class UserAssetForeignKey(serializers.PrimaryKeyRelatedField):
    def get_queryset(self):
        return Asset.objects.filter(owner=self.context['request'].user)

class TransactionSerializer(serializers.ModelSerializer):

    payment_method = UserAssetForeignKey()

    class Meta:
        model = Transaction
        fields = (
            'id',
            'title', 'amount', 'currency',
            'category', 'classification',
            'seller', 'transaction_datetime',
            'payment_method', 'last_modified',
            'data',
            'is_deleted',
        )


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class CurrencySerializer(serializers.ModelSerializer):
    class Meta:
        model = Currency
        fields = '__all__'



