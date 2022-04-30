from django.urls import path
from .views import * #import AtendimentoGetCreate, AtendimentoUpdateDelete, DoacaoGetCreate, DoacaoUpdateDelete, MaterialGetCreate, MaterialUpdateDelete

urlpatterns = [
   path('atendimento/', AtendimentoGetCreate.as_view()),
   path('atendimento/<int:pk>', AtendimentoUpdateDelete.as_view()),

   path('doacao/', DoacaoGetCreate.as_view()),
   path('doacao/<int:pk>', DoacaoUpdateDelete.as_view()),

   path('confirmar_doacao/', DoacaoConfirmarGetCreate.as_view()),
   path('confirmar_doacao/<int:pk>', DoacaoConfirmarUpdateDelete.as_view()),

   path('material/', MaterialGetCreate.as_view()),
   path('material/<int:pk>', MaterialUpdateDelete.as_view()),

]