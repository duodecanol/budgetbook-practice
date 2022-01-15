from django.urls import path, include
from django.conf.urls import url
from rest_framework import routers
from . import views

router = routers.DefaultRouter()
router.register(r'test/assets', views.AssetYetAnotherViewSet, basename='yassets')
router.register(r'user/assets', views.AssetList, basename='assets')
router.register(r'user/bankaccounts', views.UserBankAccountViewSet, basename='bankaccount')
router.register(r'user/cashes', views.UserCashViewSet, basename='cash')
router.register(r'user/cards', views.UserCreditCardViewSet, basename='card')
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
    path('assets/<pk>', views.RetrieveAssetAPIView.as_view(), name='full-list')
    # path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]


# api/ ^user/assets/$ [name='assets-list']
# api/ ^user/assets\.(?P<format>[a-z0-9]+)/?$ [name='assets-list']
# api/ ^user/assets/(?P<pk>[^/.]+)/$ [name='assets-detail']
# api/ ^user/assets/(?P<pk>[^/.]+)\.(?P<format>[a-z0-9]+)/?$ [name='assets-detail']