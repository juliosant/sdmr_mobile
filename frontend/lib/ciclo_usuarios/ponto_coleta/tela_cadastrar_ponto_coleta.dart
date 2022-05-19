import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdmr/ciclo_usuarios/tela_escolher_tipo_usuario_cadastro.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:sdmr/components/TagMaterial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdmr/main.dart';

class TelaCadastroPontoColeta extends StatefulWidget {
  const TelaCadastroPontoColeta({Key? key}) : super(key: key);

  @override
  State<TelaCadastroPontoColeta> createState() => _TelaCadastroPontoColetaState();
}

class _TelaCadastroPontoColetaState extends State<TelaCadastroPontoColeta> {

  String token_permissao = '';
  String usuario = '';
  String instituicao = '';
  String nome = '';
  String sobrenome = '';
  String email = '';
  String telefone = '';
  String sede = 'N/I';
  String logradouro = '';
  String numero = '';
  String bairro = '';
  String cidade = '';
  String estado = '';
  String complemento = "";
  String senha = '';
  String confirmar_senha = '';
  List<String> tipo_materiais = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

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

  void cadastrar_ponto_coleta(
      /*String usuario,
      String nome,
      String sobrenome,
      String email,
      String telefone,
      String senha*/
      ) async{
    try{

      http.Response response = await http.post(
        Uri.parse(kUrlUsuarios+"cadastro_pontoColeta/"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: "TOKEN $token_permissao",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(
            <String, dynamic>{
              "username": usuario,
              "des_nome_instituicao": instituicao,
              "first_name": "N/I",
              "last_name": "N/I",
              "email": email,
              "des_telefone": telefone,
              "des_tipo_perfi": "P",

              "des_nome_local": "N/I",
              "des_nome_rua_av": logradouro,
              "des_numero": numero,
              "des_bairro": bairro,
              "des_cidade": cidade,
              "des_estado": estado,
              "des_complemento": complemento,
              "col_materiais": tipo_materiais,
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
          title: "Ponto de Coleta Criado",
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

  _onDelete(index) {
    setState(() {
      tipo_materiais.removeAt(index);
    });
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    instituicao = val;
                  });
                  print(instituicao);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome Local/Razão Social',
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
              SizedBox(height: 30.0,),


              TextField(
                onChanged: (val){
                  setState(() {
                    sede = val;
                  });
                  print(usuario);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sede (opcional)',
                ),
              ),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                          logradouro = val;
                        });
                        print(logradouro);
                      },
                      //obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Rua/Avenida',
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                      numero = val;
                    });
                    print(numero);
                      },
                      //obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nº',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    bairro = val;
                  });
                  print(bairro);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bairro',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    cidade = val;
                  });
                  print(cidade);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cidade',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    estado = val;
                  });
                  print(estado);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Estado',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (val){
                  setState(() {
                    complemento = val;
                  });
                  print(complemento);
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Complemento',
                ),
              ),
              SizedBox(height: 30.0,),

              Text(
                'Materiais à receber',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 0.0,),
              TagEditor(
                length: tipo_materiais.length,
                controller: _textEditingController,
                focusNode: _focusNode,
                delimiters: [',', ' ',],
                hasAddButton: false,
                resetTextOnSubmitted: true,
                // This is set to grey just to illustrate the `textStyle` prop
                textStyle: const TextStyle(color: Colors.grey, fontSize: 25),
                onSubmitted: (outstandingValue) {
                  setState(() {
                    tipo_materiais.add(outstandingValue);
                  });
                },
                inputDecoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Digite um material...',
                  hintStyle: TextStyle(color: Colors.teal, fontSize: 20),
                ),
                onTagChanged: (newValue) {
                  setState(() {
                    tipo_materiais.add(newValue);
                  });
                },
                tagBuilder: (context, index) => TagMaterial(
                  index: index,
                  label: tipo_materiais[index],
                  onDeleted: _onDelete,
                ),
                // InputFormatters example, this disallow \ and /
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                ],
              ),
              SizedBox(height: 30.0,),

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
              TextField(
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
              SizedBox(height: 10.0,),

              ElevatedButton(
                onPressed: (){
                  cadastrar_ponto_coleta();
                  /*Alert(
                    style: AlertStyle(isCloseButton: false),
                    onWillPopActive: true,
                    context: context,
                    //type: AlertType.success,
                    image: Image.asset("img/icon_alert_sucesso.png"),
                    title: "Ponto de Coleta Criado",
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
              GestureDetector(
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
            ],
          ),
        ),
      ),
    );
  }
}
