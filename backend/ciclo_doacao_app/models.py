from django.db import models
from django.db.models.deletion import CASCADE
from django.db.models.fields.related import ForeignKey

from ciclo_usuarios_app.models import Perfil

# Create your models here.


class Atendimento(models.Model):
    STATUS_ATENDIMENTO = [
        ("0", "Aguardando Confirmação de Atendimento"),
        ("1", "Confirmado Atendimento"),
        ("2", "Aguardando Confirmação de Doação"),
        ("3", "Cancelado"),
        ("4", "Concluído")
    ]
    cod_solicitante = models.ForeignKey(Perfil, on_delete=CASCADE, related_name="solicitante")
    cod_beneficiario = models.ForeignKey(Perfil, on_delete=CASCADE, related_name="beneficiario")
    des_endereco = models.CharField(max_length=200)
    dat_dia = models.DateField() 
    des_hora = models.TimeField()
    bool_confirmado = models.BooleanField(blank=True)
    des_status_atual_atendimento = models.CharField(max_length=1, choices=STATUS_ATENDIMENTO)
    des_obs_beneficiario = models.TextField(max_length=300, blank=True)
    num_pontos_doacao = models.FloatField(default=0)
    dat_criacao = models.DateTimeField(auto_now_add=True)
    dat_alteracao = models.DateTimeField(null=True, blank=True)
    tipo_atendimento = models.BooleanField(blank=True) # Atendimento marcado ou avuslso?

    #class Meta:
    #    ordering = ['dat_criacao']

class Doacao(Atendimento):
    STATUS_DOACAO = [
        ('0', 'Aguardando inicio'),
        ("1", "Confirmada"),
        ("2", "Precisa Revisar"),
        ("3", "Cancelada"),
        ("4", "Aguardando Materiais")
    ]
    #cod_atendimento = models.ForeignKey(Atendimento, on_delete=CASCADE)
    #dat_criacao_doacao = models.DateTimeField(auto_now_add=True)
    bool_confirmado_doacao = models.BooleanField(blank=True)
    des_status_atual_doacao = models.CharField(max_length=1, choices=STATUS_DOACAO)


class Material(models.Model):
    cod_doacao = ForeignKey(Doacao, on_delete=CASCADE, related_name='materiais')
    des_nome_material = models.CharField(max_length=100)
    des_tipo_material = models.CharField(max_length=100)
    num_quantidade_kg = models.FloatField()
    num_pontos = models.FloatField()

    def __str__(self):
        return '%s:%s:%s:%s' % (
                self.des_nome_material, self.des_tipo_material, 
                self.num_quantidade_kg, self.num_pontos
            )