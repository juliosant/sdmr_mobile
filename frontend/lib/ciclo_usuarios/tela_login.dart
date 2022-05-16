import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sdmr/ciclo_usuarios/doador/tela_inicial_doador.dart';
import 'package:sdmr/ciclo_usuarios/ponto_coleta/tela_inicial_ponto_coleta.dart';
import 'package:sdmr/ciclo_usuarios/tela_erro_login.dart';
import 'package:sdmr/ciclo_usuarios/tela_escolher_tipo_usuario_cadastro.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:sdmr/main.dart';
import 'dart:convert';

import 'package:sdmr/tela_inicial_usuario.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  String usuario = '';
  String senha = '';

  fazerLogin() async{
    http.Response response = await http.post(
      Uri.parse(kUrlToken),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        "username": usuario,
        "password": senha
      },),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200){
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context)=>TelaErroLogin()), (route) => false);
    }
    else {
      setState(() {
        globalToken = jsonDecode(response.body)['token'];
        globalIdUser = jsonDecode(response.body)['user'];
        globalIdPerfilTipo = jsonDecode(response.body)['tipo_perfil'];
      });
      print(globalToken);
      print(globalIdUser);
      print('Deu bom');
      //print(response.body);
      //print(response.statusCode);
      //print(response.body.runtimeType);
      //print(serie_token);
      if (globalIdPerfilTipo == 'D') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TelaInicialDoador()), (
            route) => false);
      }
      else if(globalIdPerfilTipo == 'P') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TelaInicialPontoColeta()), (
            route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Login',
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

                child: TextField(
                  onChanged: (val){
                    setState(() {
                      usuario = val;
                    });
                    print(usuario);
                  },
                  //obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child: TextField(
                  onChanged: (val){
                    setState(() {
                      senha = val;
                    });
                    print(senha);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    fazerLogin();
                  },
                  child: Text('Entrar', style: kTextoBotao,),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaEscolherUsuarioCadastro()), (route) => false);
                  },
                  child: Text(
                      'Não possui conta? Crie agora',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                    ),

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
