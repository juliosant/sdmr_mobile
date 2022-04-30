
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
   path('pontoColeta/<int:pk>', PontoColetaUpdateDelete.as_view())
]