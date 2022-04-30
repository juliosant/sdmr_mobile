from django.urls import path
from .views import CupomGetCreate, CupomUpdateDelete

urlpatterns = [
   path('cupom/', CupomGetCreate.as_view()),
   path('cupom/<int:pk>', CupomUpdateDelete.as_view()),
]