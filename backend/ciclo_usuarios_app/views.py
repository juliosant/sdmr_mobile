from cgitb import lookup
from django.shortcuts import render
from rest_framework import generics, filters
from .models import Doador, Perfil, PontoColeta
from .serializers import * #DoadorSerializer, PerfilSerializer, PontoColetaSerializer

from rest_framework.permissions import IsAuthenticated, IsAdminUser

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authtoken.views  import ObtainAuthToken
from rest_framework.authtoken.models import Token

# Create your views here.

class PerfilGetCreate(generics.ListCreateAPIView):
    queryset = Perfil.objects.all()
    serializer_class = PerfilSerializer


# API para Alterar/Excluir agendamento
class PerfilUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Perfil.objects.all()
    serializer_class = PerfilSerializer


# DOADOR

class DoadorGetCreate(generics.ListCreateAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorSerializer

# API para Alterar/Excluir agendamento
class DoadorUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorNomeSerializer


# Mostrar Dados tela inicial
class DoadorNomeUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorNomeSerializer

class DoadorNomeGetCreate(generics.ListCreateAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorNomeSerializer

class DoadorRankeadoGetCreate(generics.ListCreateAPIView):
    queryset = Doador.objects.filter(num_pontos_ranking__gt=0).order_by('-num_pontos_ranking')
    serializer_class = DoadorRankeadoSerializer


# PONTO DE COLETA
class PontoColetaGetCreate(generics.ListCreateAPIView):
    queryset = PontoColeta.objects.all()
    serializer_class = PontoColetaSerializer


# API para Alterar/Excluir agendamento
class PontoColetaUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = PontoColeta.objects.all()
    serializer_class = PontoColetaSerializer


# Mostrar dados tela inicial
class PonoColetaTelaInicialUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = PontoColeta.objects.all()
    serializer_class = PonoColetaTelaInicialSerializer

class PonoColetaTelaInicialGetCreate(generics.ListCreateAPIView):
    queryset = PontoColeta.objects.all()
    serializer_class = PonoColetaTelaInicialSerializer


class PerfilRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        perfils = Perfil.objects.all()
        serializer = PerfilAuthSerializer(perfils, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = PerfilAuthSerializer(data=request.data)
        print(request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )




class PontoColetaRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAuthenticated]

    def get(self, format=None):
        perfils = PontoColeta.objects.all()
        serializer = PontoColetaAuthSerializer(perfils, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = PontoColetaAuthSerializer(data=request.data)
        print(request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )


class DoadorRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAuthenticated]

    def get(self, format=None):
        perfils = Doador.objects.all()
        serializer = DoadorAuthSerializer(perfils, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = DoadorAuthSerializer(data=request.data)
        print(request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )


class PerfilRetornTokenId(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        perfil = Perfil.objects.get(id=user.id)
        #print(perfil.des_tipo_perfi)
        return Response({'token': token.key, 'user': user.id, 'tipo_perfil': perfil.des_tipo_perfi})

obter_token_id_perfil = PerfilRetornTokenId.as_view()


class PontoColetaBuscaRecordView(generics.ListAPIView):
    search_fields = ['$col_materiais','des_cidade', 'des_nome_instituicao']
    print(filters.SearchFilter)
    filter_backends = (filters.SearchFilter,)
    queryset = PontoColeta.objects.all()
    serializer_class = PontoColetaSerializer
