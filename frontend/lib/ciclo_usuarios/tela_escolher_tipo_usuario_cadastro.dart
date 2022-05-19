import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sdmr/ciclo_usuarios/doador/tela_cadastrar_doador.dart';
import 'package:sdmr/ciclo_usuarios/ponto_coleta/tela_cadastrar_ponto_coleta.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import 'package:sdmr/constantes/constantes.dart';

class TelaEscolherUsuarioCadastro extends StatefulWidget {
  const TelaEscolherUsuarioCadastro({Key? key}) : super(key: key);

  @override
  State<TelaEscolherUsuarioCadastro> createState() => _TelaEscolherUsuarioCadastroState();
}

class _TelaEscolherUsuarioCadastroState extends State<TelaEscolherUsuarioCadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Escolher tipo de usuario',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context)=>TelaCadastroDoador()), (route) => false);

                },
                child: Text('Doador', style: kTextoBotao,),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context)=>TelaCadastroPontoColeta()), (route) => false);
                },
                child: Text('Ponto de Coleta', style: kTextoBotao,),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
              ),
            ),
            Container(

              child: GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context)=>TelaLogin()), (route) => false);
                },
                child: Text(
                  'Voltar',
                  style: kBotaoRetono,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
