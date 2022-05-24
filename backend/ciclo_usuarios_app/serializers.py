from django.db.models.query_utils import Q
from rest_framework import serializers
from ciclo_doacao_app.models import Atendimento
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
    #solicitante  = serializers.SlugRelatedField(slug_field='des_status_atual_atendimento', many=True, read_only=False, queryset=Atendimento.objects.filter(des_status_atual_atendimento='4'))
    #print(type(solicitante))
    #doacoes_concluidas = len(list(solicitante.child_relation.queryset))
    #print(lista_doacoes)
    
    doacoes_concluidas = serializers.SerializerMethodField('get_doacoes_concluidas')

    doacoes_pendentes = serializers.SerializerMethodField('get_doacoes_pendentes')

    class Meta:
        model = Doador
        fields = ['id', 'first_name', 'last_name', 'num_pontos_gerais','num_pontos_ranking', 'doacoes_concluidas', 'doacoes_pendentes']
    
    def get_doacoes_concluidas(self, doador):
        #doacoes_concluidas = doador.id
        doacoes_concluidas = len(list(Atendimento.objects.filter(cod_solicitante=doador.id, des_status_atual_atendimento='4')))
        return doacoes_concluidas

    def get_doacoes_pendentes(self, doador):
        #doacoes_concluidas = doador.id
        doacoes_pendentes = len(list(Atendimento.objects.filter(cod_solicitante=doador.id, des_status_atual_atendimento='2')))
        return doacoes_pendentes

class DoadorRankeadoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Doador
        fields = ['id', 'first_name', 'last_name', 'num_pontos_gerais','num_pontos_ranking']


class PontoColetaSerializer(serializers.ModelSerializer):
    class Meta:
        model = PontoColeta
        fields = ['id', 'username','des_nome_instituicao', 'des_nome_local','first_name', 'last_name', 'password', 'des_nome_rua_av', 
        'des_numero', 'des_bairro', 'des_cidade', 'des_estado', 'des_complemento',
         'email', 'des_telefone', 'des_tipo_perfi', 'des_sobre_mim', 'col_materiais']


class PonoColetaTelaInicialSerializer(serializers.ModelSerializer):
    #solicitante  = serializers.SlugRelatedField(slug_field='des_status_atual_atendimento', many=True, read_only=False, queryset=Atendimento.objects.filter(des_status_atual_atendimento='4'))
    #print(type(solicitante))
    #doacoes_concluidas = len(list(solicitante.child_relation.queryset))
    #print(lista_doacoes)
    
    doacoes_concluidas = serializers.SerializerMethodField('get_doacoes_concluidas')

    doacoes_pendentes = serializers.SerializerMethodField('get_doacoes_pendentes')

    class Meta:
        model = PontoColeta
        fields = ['id', 'doacoes_concluidas', 'doacoes_pendentes']
    
    def get_doacoes_concluidas(self, ptcoleta):
        #doacoes_concluidas = ptcoleta.id
        doacoes_concluidas = len(list(Atendimento.objects.filter(cod_beneficiario=ptcoleta.id, des_status_atual_atendimento='4')))
        return doacoes_concluidas

    def get_doacoes_pendentes(self, ptcoleta):
        buscar = Q(
                Q(cod_beneficiario=ptcoleta.id) &
                Q(
                    Q(des_status_atual_atendimento='0') |
                    Q(des_status_atual_atendimento='1')
                )
            )
        #doacoes_concluidas = ptcoleta.id
        doacoes_pendentes = len(list(Atendimento.objects.filter(buscar))) #cod_beneficiario=ptcoleta.id, des_status_atual_atendimento='0'
        return doacoes_pendentes


class PerfilAuthSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        perfil = Perfil.objects.create_user(**validated_data)
        return perfil

    class Meta:
        model = Perfil
        fields = (
            'id',
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
            'des_nome_instituicao',
            'first_name',
            'last_name',
            'email',
            'des_telefone',
            'des_tipo_perfi',
            'des_nome_local',
            'des_nome_rua_av',
            'des_numero',
            'des_bairro',
            'des_cidade',
            'des_estado',
            'des_complemento',
            'col_materiais',
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
        print(type(perfil))
        return perfil

    class Meta:
        model = Doador
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'des_telefone',
            'des_tipo_perfi',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=Doador.objects.all(),
                fields=['username', 'email',]
            )
        ]