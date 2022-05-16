import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import 'tela_inicial_usuario.dart';

import 'package:material_tag_editor/tag_editor.dart';
import 'package:material_tag_editor/tag_editor_layout_delegate.dart';
import 'package:material_tag_editor/tag_layout.dart';
import 'package:material_tag_editor/tag_render_layout_box.dart';

String globalToken = '';
int  globalIdUser = 0;
String globalIdPerfilTipo = '';

void main() {
  runApp(SDMR());
}

class SDMR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
          child: TelaLogin(),//TelaInicialUsuario(),
      ),
    );
  }
}
