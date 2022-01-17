# Generated by Django 3.2.9 on 2022-01-14 11:37

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('budgetbook', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='currency',
            name='favorite',
            field=models.ManyToManyField(related_name='favoritesCurrencies', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='asset',
            name='owner',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='assets', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='creditcard',
            name='currency',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='creditcards', to='budgetbook.currency'),
        ),
        migrations.AddField(
            model_name='cash',
            name='currency',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='cashes', to='budgetbook.currency'),
        ),
        migrations.AddField(
            model_name='bankaccount',
            name='currency',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='bankaccounts', to='budgetbook.currency'),
        ),
    ]
