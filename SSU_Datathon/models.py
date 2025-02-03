# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class DdcCount(models.Model):
    number_0 = models.PositiveIntegerField(db_column='0')  # Field renamed because it wasn't a valid Python identifier.
    number_100 = models.PositiveIntegerField(db_column='100')  # Field renamed because it wasn't a valid Python identifier.
    number_200 = models.PositiveIntegerField(db_column='200')  # Field renamed because it wasn't a valid Python identifier.
    number_300 = models.PositiveIntegerField(db_column='300')  # Field renamed because it wasn't a valid Python identifier.
    number_400 = models.PositiveIntegerField(db_column='400')  # Field renamed because it wasn't a valid Python identifier.
    number_500 = models.PositiveIntegerField(db_column='500')  # Field renamed because it wasn't a valid Python identifier.
    number_600 = models.PositiveIntegerField(db_column='600')  # Field renamed because it wasn't a valid Python identifier.
    number_700 = models.PositiveIntegerField(db_column='700')  # Field renamed because it wasn't a valid Python identifier.
    number_800 = models.PositiveIntegerField(db_column='800')  # Field renamed because it wasn't a valid Python identifier.
    number_900 = models.PositiveIntegerField(db_column='900')  # Field renamed because it wasn't a valid Python identifier.

    class Meta:
        managed = False
        db_table = 'DDC_count'


class IsbnRentCount(models.Model):
    isbn = models.CharField(db_column='ISBN', primary_key=True, max_length=20)  # Field name made lowercase.
    id_count = models.PositiveIntegerField(db_column='ID_count', blank=True, null=True)  # Field name made lowercase.
    number_2004 = models.PositiveIntegerField(db_column='2004', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2005 = models.PositiveIntegerField(db_column='2005', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2006 = models.PositiveIntegerField(db_column='2006', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2007 = models.PositiveIntegerField(db_column='2007', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2008 = models.PositiveIntegerField(db_column='2008', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2009 = models.PositiveIntegerField(db_column='2009', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2010 = models.PositiveIntegerField(db_column='2010', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2011 = models.PositiveIntegerField(db_column='2011', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2012 = models.PositiveIntegerField(db_column='2012', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2013 = models.PositiveIntegerField(db_column='2013', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2014 = models.PositiveIntegerField(db_column='2014', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2015 = models.PositiveIntegerField(db_column='2015', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2016 = models.PositiveIntegerField(db_column='2016', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2017 = models.PositiveIntegerField(db_column='2017', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2018 = models.PositiveIntegerField(db_column='2018', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2019 = models.PositiveIntegerField(db_column='2019', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2020 = models.PositiveIntegerField(db_column='2020', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2021 = models.PositiveIntegerField(db_column='2021', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2022 = models.PositiveIntegerField(db_column='2022', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2023 = models.PositiveIntegerField(db_column='2023', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2024 = models.PositiveIntegerField(db_column='2024', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.

    class Meta:
        managed = False
        db_table = 'ISBN_rent_count'


class NoneIsbnRentCount(models.Model):
    title = models.CharField(max_length=510)
    id_count = models.PositiveIntegerField(db_column='ID_count', blank=True, null=True)  # Field name made lowercase.
    number_2004 = models.PositiveIntegerField(db_column='2004', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2005 = models.PositiveIntegerField(db_column='2005', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2006 = models.PositiveIntegerField(db_column='2006', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2007 = models.PositiveIntegerField(db_column='2007', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2008 = models.PositiveIntegerField(db_column='2008', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2009 = models.PositiveIntegerField(db_column='2009', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2010 = models.PositiveIntegerField(db_column='2010', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2011 = models.PositiveIntegerField(db_column='2011', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2012 = models.PositiveIntegerField(db_column='2012', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2013 = models.PositiveIntegerField(db_column='2013', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2014 = models.PositiveIntegerField(db_column='2014', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2015 = models.PositiveIntegerField(db_column='2015', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2016 = models.PositiveIntegerField(db_column='2016', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2017 = models.PositiveIntegerField(db_column='2017', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2018 = models.PositiveIntegerField(db_column='2018', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2019 = models.PositiveIntegerField(db_column='2019', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2020 = models.PositiveIntegerField(db_column='2020', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2021 = models.PositiveIntegerField(db_column='2021', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2022 = models.PositiveIntegerField(db_column='2022', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2023 = models.PositiveIntegerField(db_column='2023', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2024 = models.PositiveIntegerField(db_column='2024', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.

    class Meta:
        managed = False
        db_table = 'None_ISBN_rent_count'


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class LargeClassification(models.Model):
    tag = models.CharField(db_column='TAG', primary_key=True, max_length=20)  # Field name made lowercase.
    number_000 = models.PositiveIntegerField(db_column='000', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_100 = models.PositiveIntegerField(db_column='100', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_200 = models.PositiveIntegerField(db_column='200', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_300 = models.PositiveIntegerField(db_column='300', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_400 = models.PositiveIntegerField(db_column='400', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_500 = models.PositiveIntegerField(db_column='500', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_600 = models.PositiveIntegerField(db_column='600', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_700 = models.PositiveIntegerField(db_column='700', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_800 = models.PositiveIntegerField(db_column='800', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_900 = models.PositiveIntegerField(db_column='900', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.

    class Meta:
        managed = False
        db_table = 'large_classification'


class MiddleClassification(models.Model):
    tag = models.CharField(db_column='TAG', primary_key=True, max_length=20)  # Field name made lowercase.
    number_000 = models.PositiveIntegerField(db_column='000', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_010 = models.PositiveIntegerField(db_column='010', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_020 = models.PositiveIntegerField(db_column='020', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_030 = models.PositiveIntegerField(db_column='030', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_040 = models.PositiveIntegerField(db_column='040', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_050 = models.PositiveIntegerField(db_column='050', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_060 = models.PositiveIntegerField(db_column='060', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_070 = models.PositiveIntegerField(db_column='070', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_080 = models.PositiveIntegerField(db_column='080', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_090 = models.PositiveIntegerField(db_column='090', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_100 = models.PositiveIntegerField(db_column='100', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_110 = models.PositiveIntegerField(db_column='110', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_120 = models.PositiveIntegerField(db_column='120', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_130 = models.PositiveIntegerField(db_column='130', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_140 = models.PositiveIntegerField(db_column='140', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_150 = models.PositiveIntegerField(db_column='150', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_160 = models.PositiveIntegerField(db_column='160', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_170 = models.PositiveIntegerField(db_column='170', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_180 = models.PositiveIntegerField(db_column='180', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_190 = models.PositiveIntegerField(db_column='190', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_200 = models.PositiveIntegerField(db_column='200', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_210 = models.PositiveIntegerField(db_column='210', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_220 = models.PositiveIntegerField(db_column='220', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_230 = models.PositiveIntegerField(db_column='230', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_240 = models.PositiveIntegerField(db_column='240', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_250 = models.PositiveIntegerField(db_column='250', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_260 = models.PositiveIntegerField(db_column='260', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_270 = models.PositiveIntegerField(db_column='270', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_280 = models.PositiveIntegerField(db_column='280', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_290 = models.PositiveIntegerField(db_column='290', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_300 = models.PositiveIntegerField(db_column='300', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_310 = models.PositiveIntegerField(db_column='310', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_320 = models.PositiveIntegerField(db_column='320', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_330 = models.PositiveIntegerField(db_column='330', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_340 = models.PositiveIntegerField(db_column='340', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_350 = models.PositiveIntegerField(db_column='350', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_360 = models.PositiveIntegerField(db_column='360', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_370 = models.PositiveIntegerField(db_column='370', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_380 = models.PositiveIntegerField(db_column='380', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_390 = models.PositiveIntegerField(db_column='390', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_400 = models.PositiveIntegerField(db_column='400', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_410 = models.PositiveIntegerField(db_column='410', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_420 = models.PositiveIntegerField(db_column='420', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_430 = models.PositiveIntegerField(db_column='430', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_440 = models.PositiveIntegerField(db_column='440', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_450 = models.PositiveIntegerField(db_column='450', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_460 = models.PositiveIntegerField(db_column='460', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_470 = models.PositiveIntegerField(db_column='470', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_480 = models.PositiveIntegerField(db_column='480', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_490 = models.PositiveIntegerField(db_column='490', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_500 = models.PositiveIntegerField(db_column='500', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_510 = models.PositiveIntegerField(db_column='510', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_520 = models.PositiveIntegerField(db_column='520', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_530 = models.PositiveIntegerField(db_column='530', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_540 = models.PositiveIntegerField(db_column='540', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_550 = models.PositiveIntegerField(db_column='550', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_560 = models.PositiveIntegerField(db_column='560', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_570 = models.PositiveIntegerField(db_column='570', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_580 = models.PositiveIntegerField(db_column='580', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_590 = models.PositiveIntegerField(db_column='590', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_600 = models.PositiveIntegerField(db_column='600', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_610 = models.PositiveIntegerField(db_column='610', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_620 = models.PositiveIntegerField(db_column='620', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_630 = models.PositiveIntegerField(db_column='630', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_640 = models.PositiveIntegerField(db_column='640', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_650 = models.PositiveIntegerField(db_column='650', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_660 = models.PositiveIntegerField(db_column='660', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_670 = models.PositiveIntegerField(db_column='670', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_680 = models.PositiveIntegerField(db_column='680', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_690 = models.PositiveIntegerField(db_column='690', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_700 = models.PositiveIntegerField(db_column='700', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_710 = models.PositiveIntegerField(db_column='710', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_720 = models.PositiveIntegerField(db_column='720', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_730 = models.PositiveIntegerField(db_column='730', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_740 = models.PositiveIntegerField(db_column='740', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_750 = models.PositiveIntegerField(db_column='750', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_760 = models.PositiveIntegerField(db_column='760', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_770 = models.PositiveIntegerField(db_column='770', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_780 = models.PositiveIntegerField(db_column='780', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_790 = models.PositiveIntegerField(db_column='790', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_800 = models.PositiveIntegerField(db_column='800', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_810 = models.PositiveIntegerField(db_column='810', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_820 = models.PositiveIntegerField(db_column='820', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_830 = models.PositiveIntegerField(db_column='830', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_840 = models.PositiveIntegerField(db_column='840', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_850 = models.PositiveIntegerField(db_column='850', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_860 = models.PositiveIntegerField(db_column='860', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_870 = models.PositiveIntegerField(db_column='870', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_880 = models.PositiveIntegerField(db_column='880', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_890 = models.PositiveIntegerField(db_column='890', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_900 = models.PositiveIntegerField(db_column='900', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_910 = models.PositiveIntegerField(db_column='910', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_920 = models.PositiveIntegerField(db_column='920', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_930 = models.PositiveIntegerField(db_column='930', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_940 = models.PositiveIntegerField(db_column='940', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_950 = models.PositiveIntegerField(db_column='950', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_960 = models.PositiveIntegerField(db_column='960', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_970 = models.PositiveIntegerField(db_column='970', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_980 = models.PositiveIntegerField(db_column='980', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_990 = models.PositiveIntegerField(db_column='990', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.

    class Meta:
        managed = False
        db_table = 'middle_classification'


class RecentRent(models.Model):
    id = models.CharField(db_column='ID', primary_key=True, max_length=10)  # Field name made lowercase.
    duration = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'recent_rent'


class Rent(models.Model):
    id = models.CharField(db_column='ID', max_length=10)  # Field name made lowercase.
    rent_date = models.DateField()
    tag = models.CharField(db_column='TAG', max_length=5, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'rent'


class RentCount(models.Model):
    id = models.CharField(db_column='ID', primary_key=True, max_length=10)  # Field name made lowercase.
    number_2004 = models.PositiveIntegerField(db_column='2004', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2005 = models.PositiveIntegerField(db_column='2005', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2006 = models.PositiveIntegerField(db_column='2006', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2007 = models.PositiveIntegerField(db_column='2007', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2008 = models.PositiveIntegerField(db_column='2008', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2009 = models.PositiveIntegerField(db_column='2009', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2010 = models.PositiveIntegerField(db_column='2010', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2011 = models.PositiveIntegerField(db_column='2011', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2012 = models.PositiveIntegerField(db_column='2012', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2013 = models.PositiveIntegerField(db_column='2013', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2014 = models.PositiveIntegerField(db_column='2014', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2015 = models.PositiveIntegerField(db_column='2015', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2016 = models.PositiveIntegerField(db_column='2016', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2017 = models.PositiveIntegerField(db_column='2017', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2018 = models.PositiveIntegerField(db_column='2018', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2019 = models.PositiveIntegerField(db_column='2019', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2020 = models.PositiveIntegerField(db_column='2020', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2021 = models.PositiveIntegerField(db_column='2021', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2022 = models.PositiveIntegerField(db_column='2022', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2023 = models.PositiveIntegerField(db_column='2023', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.
    number_2024 = models.PositiveIntegerField(db_column='2024', blank=True, null=True)  # Field renamed because it wasn't a valid Python identifier.

    class Meta:
        managed = False
        db_table = 'rent_count'
