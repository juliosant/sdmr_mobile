from django.contrib import admin
from ciclo_usuarios_app.models import Perfil
from django.contrib.auth import admin as auth_admin
from .forms import PerfilChangeForm, PerfilCreationForm

# Register your models here.

@admin.register(Perfil)
class UserAdmin(auth_admin.UserAdmin):
    form = PerfilChangeForm
    add_form = PerfilCreationForm
    model = Perfil
    fieldsets = auth_admin.UserAdmin.fieldsets + (
        ("Campos personalizados", {"fields": ("des_telefone","des_tipo_perfi","des_sobre_mim",)}),
    )