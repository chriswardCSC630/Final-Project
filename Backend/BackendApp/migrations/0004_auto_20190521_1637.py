# Generated by Django 2.1.7 on 2019-05-21 16:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('BackendApp', '0003_auto_20190521_1404'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sport',
            name='teacher',
            field=models.CharField(default='none', max_length=60),
        ),
        migrations.AlterField(
            model_name='sport',
            name='title',
            field=models.CharField(default='none', max_length=60),
        ),
    ]
