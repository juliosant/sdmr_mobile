import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:sdmr/main.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:sdmr/ciclo_usuarios/tela_escolher_tipo_usuario_cadastro.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';

class TelaCadastroDoador extends StatefulWidget {
  const TelaCadastroDoador({Key? key}) : super(key: key);

  @override
  State<TelaCadastroDoador> createState() => _TelaCadastroDoadorState();
}

class _TelaCadastroDoadorState extends State<TelaCadastroDoador> {
  String token_permissao = '';
  String usuario = '';
  String nome = '';
  String sobrenome = '';
  String email = '';
  String telefone = '';
  String senha = '';
  String confirmar_senha = '';

  void obter_permissao_criacao() async {
    http.Response response = await http.post(
      Uri.parse(kUrlToken),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        "username": "admin",
        "password": "admin"
      },),
    );
    setState(() {
      token_permissao = jsonDecode(response.body)['token'];
    });


  }
  void cadastrar_doador(
      /*String usuario,
      String nome,
      String sobrenome,
      String email,
      String telefone,
      String senha*/
  ) async{
    try{

      http.Response response = await http.post(
        Uri.parse(kUrlUsuarios+"cadastro_doador/"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $token_permissao",
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(
          <String, dynamic>{
            "username": usuario,
            "first_name": nome,
            "last_name": sobrenome,
            "email": email,
            "des_telefone": telefone,
            "des_tipo_perfi": "D",
            "password": senha
          }
      ),
    );
    if (response.statusCode == 201){
      print('ok-atualizou_status');
      setState(() {
        globalToken = '';
      });
      Alert(
        style: AlertStyle(
          isCloseButton: false,
          backgroundColor: Colors.white,
        ),
        onWillPopActive: true,
        context: context,
        //type: AlertType.success,
        image: Image.asset("img/icon_alert_sucesso.png"),
        title: "Doador Criado",
        desc: "Seja bem-vindo",
        buttons: [
          DialogButton(
            color: Colors.teal,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>TelaLogin()), (route) => false),
            width: 120,
          )
        ],
      ).show();
    }
    else {
      print('Não deu');
    }
    }
    catch(e){
      print(e);
    }

  }

  @override
  void initState() {
    obter_permissao_criacao();
    print('permissao obtida: $token_permissao');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Cadastro',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(

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
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    nome = val;
                  });
                  print(nome);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    sobrenome = val;
                  });
                  print(sobrenome);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sobrenome',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                  print(email);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    telefone = val;
                  });
                  print(telefone);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefone',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
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
              SizedBox(height: 10.0,),
              Container(
                child: TextField(
                  onChanged: (val){
                    setState(() {
                      confirmar_senha = val;
                    });
                    print(confirmar_senha);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar senha',
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    cadastrar_doador();
                    /*Alert(
                      style: AlertStyle(
                          isCloseButton: false,
                          backgroundColor: Colors.white,
                      ),
                      onWillPopActive: true,
                      context: context,
                      //type: AlertType.success,
                      image: Image.asset("img/icon_alert_sucesso.png"),
                      title: "Doador Criado",
                      desc: "Seja bem-vindo",
                      buttons: [
                        DialogButton(
                          color: Colors.teal,
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context)=>TelaLogin()), (route) => false),
                          width: 120,
                        )
                      ],
                    ).show();*/
                  },
                  child: Text('Cadastrar', style: kTextoBotao,),
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
                    'Voltar',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),

                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
