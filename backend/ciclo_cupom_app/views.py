from django.shortcuts import render
from rest_framework import generics
from .models import Cupom
from .serializer import CupomSerializer

# Create your views here.
# ATENDIMENTO

# Create your views here.
class CupomGetCreate(generics.ListCreateAPIView):
    queryset = Cupom.objects.all()
    serializer_class = CupomSerializer

# API para Alterar/Excluir agendamento
class CupomUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Cupom.objects.all()
    serializer_class = CupomSerializer
