from rest_framework import serializers

from .models.assets import (Asset, BankAccount, Cash, CreditCard)


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

class AssetYetAnotherSerializer(serializers.ModelSerializer):

    class Meta:
        model = Asset
        fields = '__all__'

class BankAccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = BankAccount
        fields = '__all__'


class CashSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cash
        fields = '__all__'


class CreditCardSerializer(serializers.ModelSerializer):
    class Meta:
        model = CreditCard
        fields = '__all__'


class AssetDetailsSerializer(serializers.ModelSerializer):
    bank_account = BankAccountSerializer()
    credit_card = CreditCardSerializer()
    cash = CashSerializer()

    class Meta:
        model = Asset
        fields = ['pk']
