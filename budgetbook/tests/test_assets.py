from django.test import TransactionTestCase

from userprofile.models import User
from budgetbook.models import BankAccount, Currency, CreditCard


class BankAccountTest(TransactionTestCase):
    """ BankAccount Test"""

    def setUp(self):

        self.user = User.objects.create()
        self.user.username = "testcase"
        self.user.save()

        self.krw = Currency.objects.create(name="한국원", code="KRW", sign="₩")

        self.bankaccount = BankAccount.objects.create(owner=self.user,
                                              name="높은이자통장",
                                              amount=612511.00,
                                              bank_name="우리은행",
                                              account_number="0262216-415131",
                                              currency=self.krw)

    def test_create_bankaccount(self):

        # self.assertEqual(self.bankaccount, None)
        BankAccount.objects.create(owner=self.user,
                                              name="낮은이자통장",
                                              amount=1321.00,
                                              bank_name="우리은행",
                                              account_number="984654-415131",
                                              currency=self.krw)
        self.assertEqual(len(self.user.assets.all()), 1)


class CreditCardTest(TransactionTestCase):

    def setUp(self):
        self.user = User.objects.create()
        self.user.username = "testcase"
        self.user.save()

        self.krw = Currency.objects.create(name="한국원", code="KRW", sign="₩")

        self.creditcard = CreditCard.objects.create(owner=self.user,
                                                    name="삼성 모자란 불행카드",
                                                    amount=1321.00,
                                                    card_company_name="삼성카드",
                                                    credit_limit=1000000,
                                                    currency=self.krw)

    def test_create_bankaccount(self):
        self.assertEqual(self.creditcard, None)
        CreditCard.objects.create(owner=self.user,
                                  name="삼성 모자란 불행카드",
                                  amount=1321.00,
                                  card_company_name="삼성카드",
                                  credit_limit=1000000,
                                  currency=self.krw)
        self.assertEqual(len(self.user.assets.all()), 1)
