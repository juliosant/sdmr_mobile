# Generated by Django 4.0.4 on 2022-04-24 17:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ciclo_doacao_app', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='doacao',
            name='des_status_atual_doacao',
            field=models.CharField(choices=[('0', 'Aguardando inicio'), ('0', 'Confirmada'), ('1', 'Precisa Revisar'), ('2', 'Cancelada'), ('3', 'Aguardando Materiais')], max_length=1),
        ),
    ]
