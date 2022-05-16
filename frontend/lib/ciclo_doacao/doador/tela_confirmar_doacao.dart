import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_doacao/doador/tela_lista_doacoes_materiais.dart';
import 'package:sdmr/ciclo_usuarios/doador/tela_inicial_doador.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:sdmr/tela_inicial_usuario.dart';
import 'package:select_form_field/select_form_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../main.dart';

class TelaConfirmarDoacao extends StatefulWidget {

  final int id;
  final int cod_solicitante;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;
  final List<dynamic> materiais;

  const TelaConfirmarDoacao({
    required this.id,
    required this.cod_solicitante,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
    required this.materiais,
    Key? key}) : super(key: key);


  @override
  State<TelaConfirmarDoacao> createState() =>
      _TelaConfirmarDoacaoState(
        id: id,
        cod_solicitante: cod_solicitante,
        nome_solicitante: nome_solicitante,
        periodo: periodo,
        des_email_solicitante: des_email_solicitante,
        des_telefone_solicitante: des_telefone_solicitante,
        materiais: materiais
      );
}

class _TelaConfirmarDoacaoState extends State<TelaConfirmarDoacao> {
  String confirmado = '';
  double pontosDoacao = 0;
  
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'sim',
      'label': 'Sim',
      'icon': Icon(Icons.check),
    },
    {
      'value': 'nao',
      'label': 'Não',
      'icon': Icon(Icons.close),
    },
    {
      'value': 'revisar',
      'label': 'Precisa Revisar',
      'icon': Icon(Icons.question_answer),
    },
  ];
  final int id;
  final int cod_solicitante;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;
  final List<dynamic> materiais;

  _TelaConfirmarDoacaoState({
    required this.id,
    required this.cod_solicitante,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
    required this.materiais
  });

  void atualizarPontosDoador({required double pontos}) async{
    http.Response response = await http.get(Uri.parse(kUrlUsuarios+'doador/$cod_solicitante'),
      headers: {
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
      }
    );
    var data = json.decode(response.body);

    data['num_pontos_gerais'] += pontos;

    response = await http.put(
      Uri.parse(kUrlUsuarios+'doador/$cod_solicitante'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, dynamic>
        {
          "num_pontos_gerais": data['num_pontos_gerais']
        },
      ),
    );
    if (response.statusCode == 200){
      print('ok-pontos');
    }
    else {
      print('Não deu');
    }
  }

  void confirmarDoacao({
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

    print("id " +data['id'].toString());
    print("cod_solicitante "+ data['cod_solicitante'].toString());
    print("cod_beneficiario "+ data['cod_beneficiario'].toString());
    print("dat_dia "+ data['dat_dia']);
    print("des_hora: " +data['des_hora']);
    print('bool_confirmado: ' +data['bool_confirmado'].toString());
    print(des_status_atual_atendimento);
    print(des_status_atual_doacao);
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
        "bool_confirmado": data['bool_confirmado'],
        "des_status_atual_atendimento": des_status_atual_atendimento,
        "des_status_atual_doacao": des_status_atual_doacao
      },
      ),
    );
    if (response.statusCode == 200){
      print('ok-confirmado_doacao');
      setState(() {
        atualizar_dados_doador = true;
      });
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context)=>TelaInicialDoador()), (route) => false);
    }
    else {
      print('Não deu');
    }
  }

  Widget mostrarMateriaisDoados(int indice){
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            color: Colors.teal,
            child: Text('Material',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'Material:              '+materiais[indice]['des_nome_material'],
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20.0
            ),
          ),
          Text(
            'Tipo:                     '+materiais[indice]['des_tipo_material'],
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20.0
            ),
          ),
          Text(
            'Qtde (KG):           '+materiais[indice]['num_quantidade_kg'].toString(),
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20.0
            ),
          ),
          Text(
            'Pontos:                '+materiais[indice]['num_pontos'].toString(),
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20.0
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Confirmar Doação',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              child: Column(
                children: [
                  Card(
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
                          SizedBox(height: 25.0,),
                          Text('Materais', style: kTituloCardBusca,),
                          Column (
                            children: materiais.map((e) =>
                                mostrarMateriaisDoados(materiais.indexOf(e)),
                            ).toList() ,
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
                                if (val.toLowerCase() == 'sim'){
                                  setState(() {
                                    confirmado = 'sim';
                                  });

                                  print(confirmado);
                                  print(materiais);
                                }
                                if (val.toLowerCase() == 'nao'){
                                  setState(() {
                                    confirmado = 'nao';
                                  });
                                  print(confirmado);
                                }
                                if (val.toLowerCase() == 'revisar'){
                                  setState(() {
                                    confirmado = 'revisar';
                                  });
                                  print(confirmado);
                                }
                              });},
                              onSaved: (val) => print(val),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed:(){

                        if (confirmado == 'sim'){
                          confirmarDoacao(
                              des_status_atual_atendimento: '4',
                              des_status_atual_doacao: '1');

                          setState(() {
                            materiais.map((e) {
                              pontosDoacao += e['num_pontos'];
                            },
                            ).toList();
                          });

                          atualizarPontosDoador(pontos: pontosDoacao);

                          print(confirmado);

                        }
                        if (confirmado == 'nao'){
                          confirmarDoacao(
                              des_status_atual_atendimento: '3',
                              des_status_atual_doacao: '3');

                          print(confirmado);
                        }
                        if (confirmado == 'revisar'){
                          confirmarDoacao(
                              des_status_atual_atendimento: '2',
                              des_status_atual_doacao: '2');

                          print(confirmado);
                        }

                        //Navigator.pushAndRemoveUntil(
                        //    context, MaterialPageRoute(builder: (context)=>TelaInicialDoador()), (route) => false);
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
                          context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                    },
                    child: Container(
                      child: Center(
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
          ],
        ),
      ),
    );
  }
}
