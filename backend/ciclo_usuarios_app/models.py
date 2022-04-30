from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models.deletion import CASCADE
from django.contrib.postgres.fields import ArrayField


# Create your models here.
class Perfil(AbstractUser):
    TIPO_PERFIL = [
        ("D", "Doador"),
        ("P", "Ponto de Coleta")
    ]
    ##code = models.CharField(max_length=11)
    #des_email = models.EmailField(unique=True, 
     #       error_messages={'unique': "Já existe um usuário com este email", 'required': 'Por favor dgite um email'}, )
    des_telefone = models.CharField(max_length=11)
    des_tipo_perfi = models.CharField(max_length=1, choices=TIPO_PERFIL)
    des_sobre_mim = models.TextField(max_length=300)
    #img_profile = models.ImageField(upload_to='img_profile', null=True, blank=True)
    

class Doador(Perfil):
    num_pontos_gerais = models.FloatField(default=0)
    num_pontos_ranking = models.FloatField(default=0)

class Endereco(models.Model):
    des_nome_local = models.CharField(max_length=100)
    des_nome_rua_av = models.CharField(max_length=100)
    des_numero = models.CharField(max_length=10)
    des_bairro = models.CharField(max_length=100)
    des_cidade = models.CharField(max_length=100)
    des_estado = models.CharField(max_length=100)
    des_complemento = models.CharField(max_length=200)


class PontoColeta(Perfil):
    des_nome_instituicao = models.CharField(max_length=200)
    #cod_endereco = models.OneToOneField(Endereco, on_delete=models.CASCADE, null=True, blank=True)
    des_nome_local = models.CharField(max_length=100, null=True)
    des_nome_rua_av = models.CharField(max_length=100, null=True)
    des_numero = models.CharField(max_length=10, null=True)
    des_bairro = models.CharField(max_length=100, null=True)
    des_cidade = models.CharField(max_length=100, null=True)
    des_estado = models.CharField(max_length=100, null=True)
    des_complemento = models.CharField(max_length=200, null=True)
    col_materiais = ArrayField(models.CharField(max_length=100), null=True)