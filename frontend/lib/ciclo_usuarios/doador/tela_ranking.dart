import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdmr/ciclo_usuarios/doador/tela_inicial_doador.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:sdmr/main.dart';
import 'package:sdmr/modelos/Doador.dart';

class TelaRanking extends StatefulWidget {
  const TelaRanking({Key? key}) : super(key: key);

  @override
  State<TelaRanking> createState() => _TelaRankingState();
}

class _TelaRankingState extends State<TelaRanking> {
  bool doou = false;
  List<Doador> ranking_lista = [];
  void doador_semana() async{

  }
  void fetch_data() async {
    try{
      http.Response response = await http.get(
          Uri.parse(kUrlUsuarios + 'ranking/'),
          headers: {HttpHeaders.authorizationHeader: "TOKEN $globalToken"});

      var data = json.decode(response.body);
      data.forEach((doador) {
        Doador doadorAux = Doador(
            id: doador['id'],
            first_name: doador['first_name'],
            last_name: doador['last_name'],
            pontos_ranking: doador['num_pontos_ranking']
        );
        ranking_lista.add(doadorAux);
      });
      setState(() {

      });
      print(ranking_lista.length);
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    fetch_data();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Ranking',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      //print(tipo_materiais);
                      /*Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => TelaAgendamento(),
                          ),
                      );*/
                    },
                    child: Text('Atualizar', style: TextStyle(fontSize: 25.0),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                  ),
                ),
                */
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaInicialDoador()), (route) => false);
                    },
                    child: Text(
                      'Voltar',
                      style: kBotaoRetono,
                      textAlign: TextAlign.end,
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'RANKING',
                      style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),

                    ),
                  ),
                ),
                Column(
                  children: ranking_lista.map((e)
                    {
                      if(globalIdUser == e.id){
                        return Card(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${ranking_lista.indexOf(e)+1}º Você',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text('${e.pontos_ranking} pts',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      else{
                        return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${ranking_lista.indexOf(e)+1}º ${e.first_name}',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text('${e.pontos_ranking} pts',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                      }
                    },
                  ).toList(),
                ),
              ],
            ),
            /*carregando ? Text('Sem dados')
                : Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: pontosColetaEncontrados.map((e){
                return CartaoResultadoBusca(
                  cod_beneficiario: e.id,
                  des_nome_instituicao: e.des_nome_instituicao,
                  des_telefone: e.des_telefone,
                  email: e.email,
                  endCompleto: e.des_nome_rua_av + ' '+
                      e.des_numero+' '+e.des_bairro+' '+e.des_cidade+' '+e.des_estado,

                );
              }).toList(),
            ),*/
          ],
        ),
      ),
    );
  }
}
