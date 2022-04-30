from rest_framework import serializers

from .models import Atendimento, Doacao, Material

class AtendimentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Atendimento
        fields = '__all__'

class DoacaoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doacao
        fields = '__all__'

class MaterialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Material
        fields = '__all__'


class DoacaoConfirmarSerializer(serializers.ModelSerializer):
    nome_solicitante = serializers.PrimaryKeyRelatedField(source='cod_solicitante.first_name' , read_only=True, many=False,)
    sobrenome_solicitante = serializers.PrimaryKeyRelatedField(source='cod_solicitante.last_name' ,read_only=True, many=False) #queryset=Doador.objects.all()
    des_email_solicitante = serializers.PrimaryKeyRelatedField(source='cod_solicitante.email' ,read_only=True, many=False)
    des_telefone_solicitante = serializers.PrimaryKeyRelatedField(source='cod_solicitante.des_telefone' ,read_only=True, many=False)
    #materiais = serializers.StringRelatedField(many=True, read_only=True)
    materiais = MaterialSerializer(many=True, read_only=True)
    class Meta:
        model = Doacao
        fields = ['id', 'cod_solicitante', 'nome_solicitante', 'sobrenome_solicitante', 
        'des_email_solicitante', 'des_telefone_solicitante',
        'cod_beneficiario', 'dat_dia', 'des_hora', 'bool_confirmado', 
        'des_status_atual_atendimento', 'des_status_atual_doacao', 'materiais',]





'''
 = models.ForeignKey(Perfil, on_delete=CASCADE, related_name="solicitante")
    cod_beneficiario = models.ForeignKey(Perfil, on_delete=CASCADE, related_name="beneficiario")
    des_endereco = models.CharField(max_length=200)
    dat_dia = models.DateField() 
    des_hora = models.TimeField()
    bool_confirmado = models.BooleanField(blank=True)
    des_status_atual_atendimento = models.CharField(max_length=1, choices=STATUS_ATENDIMENTO)
    des_obs_beneficiario = models.TextField(max_length=300, blank=True)
    num_pontos_doacao = models.FloatField()
    dat_criacao = models.DateTimeField(auto_now_add=True)
    dat_alteracao = models.DateTimeField(null=True, blank=True)
    tipo_atendimento = models.BooleanField(blank=True)
'''