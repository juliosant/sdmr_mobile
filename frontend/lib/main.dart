import 'package:flutter/material.dart';
import 'tela_inicial_usuario.dart';

void main() {
  runApp(SDMR());
}

class SDMR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
          child: TelaInicialUsuario()),
    );
  }
}
