from django.db import models
from django.db.models.deletion import CASCADE

from ciclo_usuarios_app.models import Doador

# Create your models here.
class Cupom(models.Model):
    STATUS_CUPOM = [
        ('A', 'DISPONÍVEL'),
        ('E', "EXPIRADO"),
        ('U', 'INDISPONÍVEL'),
    ]

    cod_doador = models.ForeignKey(Doador, on_delete=CASCADE)
    num_valor = models.DecimalField(max_digits=7, decimal_places=2, null=False, blank=False)
    des_chave = models.CharField(max_length=200, null=False, blank=False)
    bool_usado = models.BooleanField(default=False)
    dat_expiracao = models.DateTimeField()
    des_status = models.CharField(max_length=1, choices=STATUS_CUPOM)
    dat_criacao = models.DateTimeField(auto_now_add=True)