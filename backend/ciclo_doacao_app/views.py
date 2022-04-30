from django.shortcuts import render
from rest_framework import generics
from .models import Atendimento, Doacao, Material
from .serializer import AtendimentoSerializer, DoacaoSerializer, MaterialSerializer, DoacaoConfirmarSerializer


# ATENDIMENTO

# Create your views here.
class AtendimentoGetCreate(generics.ListCreateAPIView):
    queryset = Atendimento.objects.all()
    serializer_class = AtendimentoSerializer

# API para Alterar/Excluir agendamento
class AtendimentoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Atendimento.objects.all()
    serializer_class = AtendimentoSerializer


# DOACAO

# Create your views here.
class DoacaoGetCreate(generics.ListCreateAPIView):
    queryset = Doacao.objects.all()
    serializer_class = DoacaoSerializer


# API para Alterar/Excluir agendamento
class DoacaoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doacao.objects.all()
    serializer_class = DoacaoSerializer

class DoacaoConfirmarGetCreate(generics.ListCreateAPIView):
    queryset = Doacao.objects.all()
    serializer_class = DoacaoConfirmarSerializer


# API para Alterar/Excluir agendamento
class DoacaoConfirmarUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doacao.objects.all()
    serializer_class = DoacaoConfirmarSerializer


# MATERIAL

# Create your views here.
class MaterialGetCreate(generics.ListCreateAPIView):
    queryset = Material.objects.all()
    serializer_class = MaterialSerializer


# API para Alterar/Excluir agendamento
class MaterialUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Material.objects.all()
    serializer_class = MaterialSerializer