from rest_framework import serializers
from .models import Doador, Perfil, PontoColeta
from rest_framework.validators import UniqueTogetherValidator

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


class PerfilAuthSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        perfil = Perfil.objects.create_user(**validated_data)
        return perfil

    class Meta:
        model = Perfil
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=Perfil.objects.all(),
                fields=['username', 'email',]
            )
        ]


class PontoColetaAuthSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        perfil = PontoColeta.objects.create_user(**validated_data)
        return perfil

    class Meta:
        model = PontoColeta
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=PontoColeta.objects.all(),
                fields=['username', 'email',]
            )
        ]


class DoadorAuthSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        perfil = Doador.objects.create_user(**validated_data)
        return perfil

    class Meta:
        model = Doador
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=Doador.objects.all(),
                fields=['username', 'email',]
            )
        ]