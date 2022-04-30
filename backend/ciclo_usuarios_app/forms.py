from dataclasses import field
from .models import Perfil
from django.contrib.auth import forms as forms_user

class PerfilChangeForm(forms_user.UserChangeForm):
    class Meta(forms_user.UserChangeForm.Meta):
        model = Perfil


class PerfilCreationForm(forms_user.UserCreationForm):
    class Meta(forms_user.UserCreationForm.Meta):
        model = Perfil