import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sdmr/ciclo_doacao/doador/tela_buscar_ponto_coleta.dart';
import 'package:sdmr/main.dart';
import 'package:sdmr/tela_inicial_usuario.dart';
import '../../constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';

class TelaAgendarDoacao extends StatefulWidget {
  final int cod_beneficiario;
  final String des_nome_instituicao;
  final String des_telefone;
  final String email;
  final String endCompleto;

  const TelaAgendarDoacao({
    required this.cod_beneficiario,
    required this.des_nome_instituicao,
    required this.des_telefone,
    required this.email,
    required this.endCompleto,
    Key? key,
  }) : super(key: key);

  @override
  State<TelaAgendarDoacao> createState() => _TelaAgendarDoacaoState(
      cod_beneficiario: cod_beneficiario,
      des_nome_instituicao: des_nome_instituicao,
      des_telefone: des_telefone,
      email: email,
      endCompleto: endCompleto);
}

class _TelaAgendarDoacaoState extends State<TelaAgendarDoacao> {

  final int cod_beneficiario;
  final String des_nome_instituicao;
  final String des_telefone;
  final String email;
  final String endCompleto;

  _TelaAgendarDoacaoState({
  required this.cod_beneficiario,
  required this.des_nome_instituicao,
  required this.des_telefone,
  required this.email,
  required this.endCompleto,});

  int cod_solictante = globalIdUser;
  //int cod_beneficiario  = 0;
  String des_endereco = "";
  String dat_dia = "";
  String des_hora = "";
  String des_status_atual_atendimento = "0";
  int num_pontos_doacao = 0;
  String des_status_atual_doacao = "0";

  int statusCode = 0;
  
  void criarAgendamento(
      int cod_solictante,
      int cod_beneficiario,
      String des_endereco,
      String dat_dia,
      String des_hora,
      String des_status_atual_atendimento,
      int num_pontos_doacao,
      String des_status_atual_doacao,
      ) async {
    try{
      http.Response response = await http.post(
          Uri.parse(kUrlDoacao+'doacao/'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "TOKEN $globalToken",
            "Content-Type": "application/json; charset=UTF-8"
          },

          body: jsonEncode(<String, dynamic>{
            "des_endereco": des_endereco,
            "dat_dia": dat_dia,
            "des_hora": des_hora,
            "bool_confirmado": false,
            "des_status_atual_atendimento": des_status_atual_atendimento,
            "des_obs_beneficiario": "",
            "num_pontos_doacao": num_pontos_doacao,
            "tipo_atendimento": false,
            "bool_confirmado_doacao": false,
            "des_status_atual_doacao": des_status_atual_doacao,
            "cod_solicitante": globalIdUser,
            "cod_beneficiario": cod_beneficiario
      }),
      );

      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context)=>TelaInicialUsuario()), (route) => false);
        Alert(
          context: context,
          title: "Solcitado",
          desc: "Você solicitou um agedamento",
          type: AlertType.success,
        ).show();
      }

      else{
        print('Não deu');
      }

    }
    catch (e){
      print('Algo deu errado');
    }
  }


  @override
  Widget build(BuildContext context) {
    //cod_beneficiario  = id;
    des_endereco = endCompleto;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Agendar Doação',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Text(
                    des_nome_instituicao,
                    style: kDadosDoPontoEscolhido,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text(
                    email,
                    style: kDadosDoPontoEscolhido,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text(
                    des_telefone,
                    style: kDadosDoPontoEscolhido,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Text(
                    endCompleto,
                    style: kDadosDoPontoEscolhido,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              /*Container(
                padding: EdgeInsets.all(8.0),
                child:  TextField(
                  //obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dia',
                    labelStyle: TextStyle(fontSize: 25),
                  ),
                  onChanged: (value){
                    setState(() {
                      dat_dia = value;
                      print(dat_dia);
                    });
                  },
                  /*onChanged: (text){

                  },*/
                ),
              ),*/
              /*Container(
                padding: EdgeInsets.all(8.0),
                child:  TextField(
                  //obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hora',
                      labelStyle: TextStyle(fontSize: 25)
                  ),
                  onChanged: (value){
                    setState(() {
                      des_hora = value;
                      print(des_hora);
                    });
                  }
                ),
              ),*/
              Container(
                padding: EdgeInsets.all(8.0),
                child: DateTimePicker(
                  dateMask: 'd-MM-yyyy',
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Data',
                  style: TextStyle(fontSize: 20.0),
                  onChanged: (val) {
                    dat_dia = val;
                    print(dat_dia);
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: DateTimePicker(
                  type: DateTimePickerType.time,
                  dateMask: 'd-MM-yyyy',
                  initialValue: '',
                  timeLabelText: 'Hora',
                  style: TextStyle(fontSize: 20.0),
                  onChanged: (val)  {
                    des_hora = val;
                    print(des_hora);
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  //print(globalIdUser);
                  //print("$cod_solictante, $cod_beneficiario $des_endereco, $dat_dia,$des_hora,$des_status_atual_atendimento,$num_pontos_doacao, $des_status_atual_doacao");
                  criarAgendamento(
                      cod_solictante,
                      cod_beneficiario,
                      des_endereco,
                      dat_dia,
                      des_hora,
                      des_status_atual_atendimento,
                      num_pontos_doacao,
                      des_status_atual_doacao
                  );
                  /*if (statusCode == 201) {
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaInicialUsuario()), (route) => false);
                    Alert(
                      context: context,
                      title: "Solcitado",
                      desc: "Você solicitou um agedamento",
                      type: AlertType.success,
                    ).show();
                  }

                  else{
                    print('Não deu');
                  }*/
                },

                child: Text('Solicitar', style: TextStyle(fontSize: 25.0),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
              ),
              GestureDetector(
                onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaBuscarPontoColeta()), (route) => false);
                },
                child: Text('Voltar',
                  style: kBotaoRetono,
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }
}
