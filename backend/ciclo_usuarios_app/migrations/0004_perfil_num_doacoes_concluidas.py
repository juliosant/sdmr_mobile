# Generated by Django 4.0.4 on 2022-05-15 13:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ciclo_usuarios_app', '0003_remove_pontocoleta_cod_endereco_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='perfil',
            name='num_doacoes_concluidas',
            field=models.IntegerField(default=0),
        ),
    ]