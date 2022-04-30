from django.shortcuts import render
from rest_framework import generics
from .models import Doador, Perfil, PontoColeta
from .serializer import * #DoadorSerializer, PerfilSerializer, PontoColetaSerializer

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

class DoadorUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorNomeSerializer



# API para Alterar/Excluir agendamento
class DoadorNomeUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorNomeSerializer

class DoadorNomeGetCreate(generics.ListCreateAPIView):
    queryset = Doador.objects.all()
    serializer_class = DoadorNomeSerializer




# PONTO DE COLETA
class PontoColetaGetCreate(generics.ListCreateAPIView):
    queryset = PontoColeta.objects.all()
    serializer_class = PontoColetaSerializer


# API para Alterar/Excluir agendamento
class PontoColetaUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = PontoColeta.objects.all()
    serializer_class = PontoColetaSerializer