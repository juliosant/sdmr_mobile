from rest_framework import serializers
from .models import Doador, Perfil, PontoColeta
from ciclo_doacao_app.serializer import DoacaoConfirmarSerializer

class PerfilSerializer(serializers.ModelSerializer):
    class Meta:
        model = Perfil
        fields = '__all__'
        #fields = ['username', 'first_name', 'last_name', 'email', 'des_telefone', 'des_tipo_perfi', 'des_sobre_mim']


class DoadorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doador
        fields = ['id', 'username', 'first_name', 'last_name','password', 'email', 
        'des_telefone', 'des_tipo_perfi', 'des_sobre_mim', 'num_pontos_gerais']

class DoadorNomeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doador
        fields = ['first_name', 'last_name', 'num_pontos_gerais']



class PontoColetaSerializer(serializers.ModelSerializer):
    class Meta:
        model = PontoColeta
        fields = ['id', 'username','des_nome_instituicao', 'des_nome_local','first_name', 'last_name', 'password', 'des_nome_rua_av', 
        'des_numero', 'des_bairro', 'des_cidade', 'des_estado', 'des_complemento',
         'email', 'des_telefone', 'des_tipo_perfi', 'des_sobre_mim', 'col_materiais']