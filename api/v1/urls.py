from django.urls import path, include
from rest_framework import routers
from api.v1 import views

router = routers.DefaultRouter()
router.register(r'user/assets', views.AssetViewSet, basename='asset')
router.register(r'user/bankaccounts', views.BankAccountViewSet, basename='bankaccount')
router.register(r'user/cashes', views.CashViewSet, basename='cash')
router.register(r'user/cards', views.CreditCardViewSet, basename='card')
router.register(r'user/transactions', views.TransactionViewSet, basename='transaction')
router.register(r'categories', views.CategoryViewSet, basename='category')
router.register(r'currencies', views.CurrencyViewSet, basename='currency')
"""
admin/assets
admin/assets/<pk>
user/bankaccounts
user/cards
user/cash
"""

urlpatterns = [
    path('', include(router.urls)),
    # url(r'^assets/(?P<pk>[0-9]+)$', views.RetrieveAssetAPIView.as_view(), name='full-list')
    # path('assets/<pk>', views.RetrieveAssetAPIView.as_view(), name='full-list')
    # path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]


# api/ ^user/assets/$ [name='assets-list']
# api/ ^user/assets\.(?P<format>[a-z0-9]+)/?$ [name='assets-list']
# api/ ^user/assets/(?P<pk>[^/.]+)/$ [name='assets-detail']
# api/ ^user/assets/(?P<pk>[^/.]+)\.(?P<format>[a-z0-9]+)/?$ [name='assets-detail']