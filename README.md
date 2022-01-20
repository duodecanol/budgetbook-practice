# simple-budgetbook-practice

가계부 앱을 위한 API
Django, Django rest framework를 이용한 API 서버 for 가계부 관리

---


## 개발환경

- OS:
  - Windows 10 Pro 21H1
- IDE:
  - Pycharm
  - Visual Studio Code
- App Environment:
  - Python 3.8.2
  - MySQL 5.7.30		
- Tested On:
  - Docker Windows Desktop
  - Postman
  - Chrome browser
  - Edge browser

---

## 데이터 모델 설계

옛날과는 달리 가계부를 쓸 때 요즘에는 현금 사용인 경우가 별로 없습니다. 현금 대용의 체크카드나, 신용카드 등이 주를 이루고 있어서 사용자가 가지고 있는 '결제수단'이 데이터 모델에 빠질 수 없다고 생각했습니다.

뱅크샐러드 앱을 자주 사용하고 있어서, 거래내역 카테고리나 거래의 분류는 그곳에서 보고 개념을 차용했습니다.



## 개발목표

### 기능

- [x] 고객은 회원가입은 **이메일** // **비밀번호** 입력
- [x] 고객은 회원 가입이후, 로그인과 로그아웃이 가능
- [ ] 고객은 회원 가입이후, n일간 로그인하지 않으면 휴면계정 처리
- [ ] 고객은 회원 가입이후, 회원탈퇴 처리를 요청할 수 있음
- 로그인한 고객은 다음의 동작이 가능
  - [x] 가계부에 기록: 거래내역(지출/수입/이체) 제목, 금액, 메모 및 기타 정보 [Post, Put]
  - [x] 기록한 내역은 수정할 수 있다. [Patch]
  - [x] 가계부에서 삭제를 원하는 내역은 삭제 할 수 있다. [Delete]
  - [x] 삭제한 내역은 언제든지 다시 복구 할 수 있어야 한다. [Restore]
  - [x] 가계부에서 기록한 가계부 리스트 조회 가능. [List]
  - [x] 가계부의 상세 내역 조회 가능. [Retrieve]
- [x] 로그인하지 않은 고객 => 가계부 내역에 대한 접근 제한 처리

### 기타

- [x] Docker compose하여 구동되도록

- [x] DB 관련 테이블에 대한 DDL 파일 저장

  - [ ] DDL/ -> `simplebudgetbook-structure_only.sql` 구조만 생성하며, 그 외 파일들은 번호순으로 테스트를 거치며 저장한 데이터를 같이 INSERT합니다.

- [ ]  테스트 케이스  
  - [ ]  Django TransactionTestCase
  - [ ]  Postman bulk execution   
     - `simplebudgetbook.postman_collection.json`  
  


# API 설명

## 계정관련

- account/signup/
  - [POST] 회원가입
  - parameter: `email`, `password1`, `password2`

- account/ login/ [name='rest_login']
  - [POST] 유저 로그인
  - parameter:  `email`, `password`
- account/ logout/ [name='rest_logout']
  - [POST] 유저 로그아웃
- account/ user/ [name='rest_user_details']
  - [ GET, PUT, PATCH ] 유저 상세 프로필
- account/ password/change/ [name='rest_password_change']
  - [POST] 비밀번호 변경 
  - parameter: `password1`, `password2`
  - <font color="red">#FIXME: 비밀번호가 마스킹처리되지 않음</font>
- account/ password/reset/ [name='rest_password_reset']
  - [POST]  reset comfirm이 불가능하므로 미구현
- account/ password/reset/confirm/ [name='rest_password_reset_confirm']
  - 미구현

---

## 가계부



### 사용자 자산

- `api/v1/ ^user/assets/$` [name='asset-list']
  - [GET, POST, DELTE]  <strike>POST, DELTE </strike>  사용자 자산(계좌,현금,카드)를 목록으로 가져옵니다.
- `api/v1/ ^user/assets/(?P<pk>[^/.]+)/$` [name='asset-detail']
  - [GET, PUT, PATCH, DELETE]  사용자 자산 상세

#### - 은행계좌


- `api/v1/ ^user/bankaccounts/$` [name='bankaccount-list']

  - [GET, POST, DELTE] 사용자 은행계좌를 목록으로 가져옵니다.
- `api/v1/ ^user/bankaccounts/(?P<pk>[^/.]+)/$` [name='bankaccount-detail']

  - [GET, PUT, PATCH, DELTE]  사용자 은행계좌 상세

#### - 현금

- `api/v1/ ^user/cashes/$` [name='cash-list']
  - [GET, POST, DELTE]  사용자 현금들(통화 및 내역별)을 목록으로 가져옵니다.
- `api/v1/ ^user/cashes/(?P<pk>[^/.]+)/$` [name='cash-detail']
  - [GET, PUT, PATCH, DELTE]  사용자 현금 상세

#### - 신용카드

- `api/v1/ ^user/cards/$` [name='card-list']
  - [GET, POST, DELTE] 사용자 신용카드를 목록으로 가져옵니다.
- `api/v1/ ^user/cards/(?P<pk>[^/.]+)/$` [name='card-detail']
  - [GET, PUT, PATCH, DELTE]  사용자 신용카드 상세

### 거래내역

- `api/v1/ ^user/transactions/$` [name='transaction-list']

  - [GET, POST] 사용자 거래내역을 목록으로 가져옵니다.

- `api/v1/ ^user/transactions/(?P<pk>[^/.]+)/$` [name='transaction-detail']

  - [GET, PUT, PATCH, DELETE] 사용자 거래내역 상세
  - 삭제는 실제로 DB에서 삭제하지 않고 삭제되었다고 표시하는 Soft delete를 수행합니다.

- `api/v1/ ^user/transactions/deleteds/$` [name='transaction-deleted-list']

  - [GET]사용자 거래내역 중 삭제된 항목들을 불러옵니다. 

- `api/v1/ ^user/transactions/deleteds/(?P<deleted_transaction_id>[0-9]+)/$` [name='transaction-deleted-detail']

  - [GET] 삭제되었다고 표시된 항목 중 n번째 항목을 가져옵니다.
  - [DELETE] 삭제되었다고 표시된 항목 중 n번째 항목을 복구합니다. (삭제된 것을 삭제하여 복구합니다.)

  

### 카테고리

- `api/v1/ ^categories/$`      [name='category-list']
  - [GET, POST] 지출/소비/이체 분류의 카테고리. 리스트
- `api/v1/ ^categories/(?P<pk>[^/.]+)/$` [name='category-detail']
  - [GET, PUT, PATCH, DELETE] 카테고리 상세
  - 하위 카테고리를 함께 반환한다.



### 돈 단위

- `api/v1/ ^currencies/$`  [name='currency-list']
  -  [GET] 돈 단위 리스트
  -  총 개의 178개 세계통화를 DB에 담아두었으나 현재 단계에서는 응답결과로 한국 원 (KRW)를 포함한 7개 통화만 제공한다.
- `api/v1/ ^currencies/(?P<pk>[^/.]+)/$` [name='currency-detail']
  -  [GET] 돈 단위 상세





## 특기할만한 문제 해결 사항

### SoftDelete Model을 상속한 Super/sub type의 테이블의 queryset에서 삭제된 레코드를 필터링하는 문제

soft delete는 여러 모델에 적용될 것이 예상된다. 

우선, user의 profile, 그리고 asset 및 transaction을 포함한 거의 모든 테이블에서 `DELETE` 요청시에 실제로 데이터를 삭제하는 것이 아니라 삭제되었다고 표시만 하고 쿼리셋에서 필터링한다.

```python
from django.db import models
from django.utils import timezone


class SoftDeleteManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(deleted_at__isnull=True)


class SoftDeleteModelMixin(models.Model):
    deleted_at = models.DateTimeField(null=True, default=None)
    objects = SoftDeleteManager()  # 기본 object는 deleted_at이 not null인 자료만 가짐. L7 참조.
    all_objects = models.Manager()  # admin 등은 삭제된 아이템까지 보려면 all_object를 사용.

    def soft_delete(self):
        self.deleted_at = timezone.now()  # DELETE 요청의 시점을 기록
        self.save(update_fields=['deleted_at'])

    def restore(self):
        self.deleted_at = None  # 복구하여 해당필드를 다시 null로 만듦
        self.save(update_fields=['deleted_at'])

    class Meta:
        abstract = True
```



Asset은 은행계좌, 현금, 카드로 구성되어 있다. DB 테이블은 super/sub 타입으로 나타난다.

```python
from model_utils.managers import InheritanceManager

class Asset(SoftDeleteModelMixin):
    objects = InheritanceManager()
    name = models.CharField(_(_('name')), max_length=255)

class BankAccount(Asset):
    bank_name = models.CharField(_('bank name'), max_length=255)    
class Cash(Asset):	pass
    currency = ... ()
class CreditCard(Asset):
    card_company_name = models.CharField(_('card company name'), max_length=255)
    
```



Asset이 `SoftDeleteModelMixin` 을 상속하면서 `is_delete` 필드를 가지며, 관련 메서드와 `object`의 매니저도 상속받는다. 그런데, super/sub 타입이기 때문에 object의 매니저는 `model_utils` 의 `InheritanceManager`를 사용해야 `.../asset` 요청시에 sub 타입들을 함께 가져온다.   위 코드의 상태에서는 get 요청을 해보면 삭제된 레코드들을 필터링하지 않고 그대로 가져오는 것을 볼 수 있다. 

`Asset`은 이미 `SoftDeleteModelMixin`을 상속하지만, `object` property를 다시 구성해주도록 한다.

```python
class CustomInheritanceManager(SoftDeleteManager, InheritanceManager):
    pass
class Asset(SoftDeleteModelMixin):
    objects = CustomInheritanceManager()
    name = models.CharField(_(_('name')), max_length=255)
```

`SoftDeleteModelMixin`의 object는 이미 `SoftDeleteManager`를 사용하고 있긴 하지만, 위와 같이 `SoftDeleteManager` 와 `InheritanceManager`를 섞은 `CustomInheritanceManager`를 만들어 준다. 단, `SoftDeleteManager`가 앞에 와야 `is_delete` 필드에 대한 필터링이 제대로 동작한다.

왜 그렇게 동작하는지 `model_utils`의 코드를 살펴보면서 이해하는 과정을 거쳤다. 

`InheritanceManager`의 상위 클래스인  `InheritanceManagerMixin`이 이미 `get_queryset` 메서드를 가지고 있기 때문에,  `InheritanceManager` 만을 object에 사용하면 override된다. 그러면 `is_delete` 필터링이 되지 않는다. 그렇기 때문에 중복되기는 하지만 object에서 `SoftDeleteManager`를 다시 사용해서 `get_queryset` 메서드의 우선권을 갖는다.

```python
class InheritanceManagerMixin:
    _queryset_class = InheritanceQuerySet

    def get_queryset(self):
        return self._queryset_class(self.model)

    def select_subclasses(self, *subclasses):
        return self.get_queryset().select_subclasses(*subclasses)

    def get_subclass(self, *args, **kwargs):
        return self.get_queryset().get_subclass(*args, **kwargs)

    def instance_of(self, *models):
        return self.get_queryset().instance_of(*models)


class InheritanceManager(InheritanceManagerMixin, models.Manager):
    pass
```

