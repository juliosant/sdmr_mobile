import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import  'package:intl/intl.dart';


import 'package:sdmr/constantes/constantes.dart';

import 'package:sdmr/ciclo_usuarios/doador/tela_inicial_doador.dart';
import 'package:sdmr/main.dart';

class TelaGeralCupons extends StatefulWidget {
  const TelaGeralCupons({Key? key}) : super(key: key);

  @override
  State<TelaGeralCupons> createState() => _TelaGeralCuponsState();
}

class _TelaGeralCuponsState extends State<TelaGeralCupons> {
  int valor = 0;
  String chave = 'CHAVEGERADA';
  String dia = '';
  String hora = '';

  void criar_cupom()async{
    setState(() {
      hora = DateFormat("hh:mm:ss").format(DateTime.now());
      dia = DateFormat('yyyy-MM-dd').format(
          DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day+3)).toString();
    });

    http.Response response = await http.post(
      Uri.parse(
          kUrlCupons+'cupom/'),

      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(
          <String, dynamic>{
            "num_valor": valor,
            "des_chave": chave,
            "bool_usado": false,
            "dat_expiracao": '$dia $hora',
            "des_status": "A",
            "cod_doador": globalIdUser
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Cupons',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        //padding: mediaQueryData.viewInsets,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Saldo:',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25
                      ),
                    ),
                    Text(
                      '50000',
                        style: TextStyle(
                          color: Colors.green,
                            fontSize: 45
                        ),
                    )
                  ],
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Cupons disponíveis:',
                    style: TextStyle(
                      fontSize: 25.0
                    ),
                  )
                ),
                Container(
                    child: Text(
                      'Cupons vencidos:',
                      style: TextStyle(
                          fontSize: 25.0
                      ),
                    )
                ),
                Container(
                    child: Text(
                      'Cupons usados:',
                      style: TextStyle(
                          fontSize: 25.0
                      ),
                    )
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context){
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets/5,
                              //height: MediaQuery.of(context).size.height/2,
                              child: Container(
                                height: 400,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                //color: Colors.pink[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    //Text('Digite seu valor'),
                                    SizedBox(height: 50,),
                                    TextField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        labelText: "Valor",
                                        labelStyle: TextStyle(fontSize: 25, color: Colors.teal)
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                                      ),
                                      child: Text(
                                        'Criar',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                      /*String hora = DateFormat("hh:mm:ss").format(DateTime.now());
                      String dia = DateFormat('yyyy-MM-dd').format(
                          DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day+3)).toString();
                      print('$dia $hora');*/

                    },
                    child: Text('Novo cupom', style: kTextoBotao,),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaInicialDoador()), (route) => false);
                    },
                    child: Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),

                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
