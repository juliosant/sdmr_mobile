"""project_recycle URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include

from rest_framework.authtoken import views
from ciclo_usuarios_app.views import obter_token_id_perfil

urlpatterns = [
    path('admin/', admin.site.urls),
    path('usuarios/', include('ciclo_usuarios_app.urls')),
    path('doacao/', include('ciclo_doacao_app.urls')),
    path('cupons/', include('ciclo_cupom_app.urls')),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
    path('obter_token/', obter_token_id_perfil, name='obter_token')

]
