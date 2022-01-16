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
