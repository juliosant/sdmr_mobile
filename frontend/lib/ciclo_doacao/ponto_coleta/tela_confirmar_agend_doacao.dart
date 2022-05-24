import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_lista_doacoes_aguardando_conf_ag.dart';
import 'package:sdmr/ciclo_usuarios/ponto_coleta/tela_inicial_ponto_coleta.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:select_form_field/select_form_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../main.dart';

class TelaConfirmarAgendDoacao extends StatefulWidget {

  final int id;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;

  const TelaConfirmarAgendDoacao({
    required this.id,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
    Key? key}) : super(key: key);



  @override
  State<TelaConfirmarAgendDoacao> createState() =>
      _TelaConfirmarAgendDoacaoState(
          id: id,
          nome_solicitante: nome_solicitante,
          periodo: periodo,
          des_email_solicitante: des_email_solicitante,
          des_telefone_solicitante: des_telefone_solicitante,
      );
}

class _TelaConfirmarAgendDoacaoState extends State<TelaConfirmarAgendDoacao> {
  bool confirmado = false;
  final List<Map<String, dynamic>> _items = [
    {
      'value': true,
      'label': 'Sim',
      'icon': Icon(Icons.check),
    },
    {
      'value': false,
      'label': 'Não',
      'icon': Icon(Icons.close),
    },
  ];
  final int id;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;

  _TelaConfirmarAgendDoacaoState({
    required this.id,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
  });

  void confirmarAgendamento({
    required bool bool_confirmado,
    required String des_status_atual_atendimento,
    required String des_status_atual_doacao
  }) async{
    http.Response response = await http.get(
        Uri.parse(kUrlDoacao+'confirmar_doacao/$id'),
        headers: {
          HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        },
    );
    var data = json.decode(response.body);

    //print("id " +data['id'].toString());
    //print("cod_solicitante "+ data['cod_solicitante'].toString());
    //print("cod_beneficiario "+ data['cod_beneficiario'].toString());
    //print("dat_dia "+ data['dat_dia']);
    //print("des_hora: " +data['des_hora']);
    //print(bool_confirmado);
    //print(des_status_atual_atendimento);
    //print(des_status_atual_doacao);
    //print(data['cod_beneficiario'].runtimeType);

    response = await http.put(
      Uri.parse(kUrlDoacao+'confirmar_doacao/$id'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        "Content-Type": "application/json; charset=UTF-8"
      },

      body: jsonEncode(<String, dynamic>{
        "id": data['id'],
        "cod_solicitante": data['cod_solicitante'],
        "cod_beneficiario": data['cod_beneficiario'],
        "dat_dia": data['dat_dia'],
        "des_hora": data['des_hora'],
        "bool_confirmado": bool_confirmado,
        "des_status_atual_atendimento": des_status_atual_atendimento,
        "des_status_atual_doacao": des_status_atual_doacao
      },
      ),
    );
    if (response.statusCode == 200){
      if (des_status_atual_atendimento == '1'){
        Alert(
          style: AlertStyle(
            isCloseButton: false,
            backgroundColor: Colors.white,
          ),
          onWillPopActive: true,
          context: context,
          //type: AlertType.success,
          image: Image.asset("img/icon_alert_sucesso.png"),
          title: "Agendado",
          desc: "Você confirmou o Agendamento",
          buttons: [
            DialogButton(
              color: Colors.teal,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context)=>TelaInicialPontoColeta()), (route) => false),
              width: 120,
            )
          ],
        ).show();
      }
      if (des_status_atual_atendimento == '3'){
        Alert(
          style: AlertStyle(
            isCloseButton: false,
            backgroundColor: Colors.white,
          ),
          onWillPopActive: true,
          context: context,
          type: AlertType.info,
          //image: Image.asset("img/icon_alert_sucesso.png"),
          title: "Agendado",
          desc: "Você cancelou o Agendamento",
          buttons: [
            DialogButton(
              color: Colors.teal,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context)=>TelaInicialPontoColeta()), (route) => false),
              width: 120,
            )
          ],
        ).show();
      }
      print('ok');
    }
    else {
      print('Não deu');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Confirmar Agendamento',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          /*Expanded(
            flex: 0,
            child: Container(
              padding: EdgeInsets.only(top: 32.0),
              child: Center(
                child: Text(
                  'Dados doador',
                  style: kDesTituloPagina,
                ),
              ),
            ),
          ),*/
          Expanded(
            flex: 2,
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        nome_solicitante,
                        style: kTituloCardBusca,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            des_email_solicitante,
                            style: kConteudoCardBusca,
                          ),
                          Text(
                            des_telefone_solicitante,
                            style: kConteudoCardBusca,
                          ),
                          Row(
                            children: [
                              Text(
                                'Dia: '+ periodo.substring(0,10),
                                style: kConteudoCardBusca,
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                'Hora: '+periodo.substring(11,16),
                                style: kConteudoCardBusca,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: SelectFormField(
                          type: SelectFormFieldType.dropdown, // or can be dialog
                          initialValue: 'circle',
                          //icon: Icon(Icons.format_shapes),
                          labelText: 'Confirmar Agendamento',
                          items: _items,
                          onChanged: (val) { setState(() {
                            print(val.runtimeType);
                            if (val.toLowerCase() == 'true'){
                              setState(() {
                                confirmado = true;
                              });

                              print(confirmado);
                            }
                            if (val.toLowerCase() == 'false'){
                              setState(() {
                                confirmado = false;
                              });
                              print(confirmado);
                            }
                          });},
                          onSaved: (val) => print(val),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          onPressed:(){
                            confirmado ?
                            confirmarAgendamento(
                                bool_confirmado: true,
                                des_status_atual_atendimento: '1',
                                des_status_atual_doacao: '4')
                            :confirmarAgendamento(
                              bool_confirmado: false,
                              des_status_atual_atendimento: '3',
                              des_status_atual_doacao: '3');
                            //Navigator.pop(context);
                            //Navigator.pushAndRemoveUntil(
                            //    context, MaterialPageRoute(builder: (context)=>TelaInicialPontoColeta()), (route) => false);
                            //Navigator.pop(context);


                          },
                          child: Text('Confirmar', style: kTextoBotao,),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.teal),
                          ),

                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesAguardandoConfAgend()), (route) => false);
                        },
                        child: Center(
                          child: Container(
                            child: Text(
                              'Voltar',
                              style: kBotaoRetono,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
