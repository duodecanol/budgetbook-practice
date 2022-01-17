from rest_framework import serializers

from budgetbook.models.assets import (Asset, BankAccount, Cash, CreditCard)
from budgetbook.models.currency import Currency
from budgetbook.models.categories import Category
from budgetbook.models.transaction import Transaction


class AssetSerializer(serializers.ModelSerializer):

    def to_representation(self, instance):
        # HyperlinkedRelatedField 가 context로 request를 요구한다.
        # /api/v1/user/bankaccounts 에서는 는 문제가 없으나, ./assets 에서는 nested 요청이므로
        # context가 요구된다.
        if isinstance(instance, BankAccount):
            return BankAccountSerializer(
                instance=instance, context={'request': self.context['request']}).data

        elif isinstance(instance, Cash):
            return CashSerializer(
                instance=instance, context={'request': self.context['request']}).data

        elif isinstance(instance, CreditCard):
            return CreditCardSerializer(
                instance=instance, context={'request': self.context['request']}).data

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
        fields = (
            'id', 'name',
            'bank_name',
            'amount', 'currency',
            'account_number',
            'data', 'owner',
            'transactions',
            'deleted_at',
        )


class CashSerializer(serializers.ModelSerializer):
    transactions = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='transaction-detail'
    )

    class Meta:
        model = Cash
        fields = (
            'id', 'name',
            'amount', 'currency',
            'data', 'owner',
            'transactions',
            'deleted_at',
        )


class CreditCardSerializer(serializers.ModelSerializer):
    transactions = serializers.HyperlinkedRelatedField(
        many=True,
        read_only=True,
        view_name='transaction-detail'
    )

    class Meta:
        model = CreditCard
        fields = (
            'id', 'name',
            'card_company_name',
            'amount', 'currency',
            'credit_limit', 'statement_balance', 'outstanding_balance',
            'billing_cycle_date',
            'data', 'owner',
            'transactions',
            'deleted_at',
        )


class UserAssetForeignKey(serializers.PrimaryKeyRelatedField):
    def get_queryset(self):
        return Asset.objects.filter(owner=self.context['request'].user)


class TransactionSerializer(serializers.ModelSerializer):

    # 현재 단계에서는 결제수단 하이퍼링크를 표시하도록.
    payment_method = serializers.HyperlinkedRelatedField(many=False, read_only=True, view_name='asset-detail')
    # payment_method = serializers.SlugRelatedField(many=False, read_only=True, slug_field='name')

    class Meta:
        model = Transaction
        fields = (
            'id',
            'title', 'amount', 'currency',
            'category', 'classification',
            'seller', 'transaction_datetime',
            'payment_method', 'last_modified',
            'data',
            'deleted_at', #TODO: production 전에는 해당필드 감춤.
        )


class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = Category
        fields = (
            'id',
            'name', 'description', 'classification',
            'last_modified', 'is_active',
            'parent', 'subcategories',
        )

    def get_fields(self):  # get Recursive subcategories field
        fields = super(CategorySerializer, self).get_fields()
        fields['subcategories'] = CategorySerializer(many=True)
        return fields


class CurrencySerializer(serializers.ModelSerializer):

    class Meta:
        model = Currency
        fields = (
            'id', 'name', 'code',
            'sign', 'favorite',
        )



