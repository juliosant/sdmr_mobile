
from django.urls import path
from .views import * #PerfilGetCreate, PerfilUpdateDelete, DoadorGetCreate, DoadorUpdateDelete, PontoColetaGetCreate, PontoColetaUpdateDelete

urlpatterns = [
   path('', PerfilGetCreate.as_view()),
   path('<int:pk>', PerfilUpdateDelete.as_view()),

   path('doador/', DoadorGetCreate.as_view()),
   path('doador/<int:pk>', DoadorUpdateDelete.as_view()),
   
   path('nome_doador/', DoadorGetCreate.as_view()),
   path('nome_doador/<int:pk>', DoadorNomeUpdateDelete.as_view()),

   path('pontoColeta/', PontoColetaGetCreate.as_view()),
   path('pontoColeta/<int:pk>', PontoColetaUpdateDelete.as_view()),

   path('cadastro_perfil/', PerfilRecordView.as_view(), name='perfil'),
   path('cadastro_pontoColeta/', PontoColetaRecordView.as_view(), name='cadastro_pontoColeta'),
   path('cadastro_doador/', DoadorRecordView.as_view(), name='cadastro_doador'),
]