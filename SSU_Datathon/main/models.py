from django.db import models

# Create your models here.
class Book(models.Model):
    id = models.CharField(db_column='ID', primary_key=True, max_length=10)  # Field name made lowercase.
    registration_year = models.PositiveIntegerField()
    registration_month = models.PositiveIntegerField()
    get_course = models.CharField(max_length=10)
    ddc = models.CharField(db_column='DDC', max_length=20)  # Field name made lowercase.
    isbn = models.CharField(db_column='ISBN', max_length=20)  # Field name made lowercase.
    title = models.CharField(max_length=510)
    author = models.CharField(max_length=160, blank=True, null=True)
    publisher = models.CharField(max_length=220, blank=True, null=True)
    publication_year = models.CharField(max_length=60, blank=True, null=True)
    location = models.CharField(max_length=5)

    class Meta:
        managed = False
        db_table = 'book'