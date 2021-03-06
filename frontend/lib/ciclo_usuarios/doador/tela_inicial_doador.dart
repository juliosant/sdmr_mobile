import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sdmr/ciclo_cupom/doador/tela_geral_cupons.dart';
import 'package:sdmr/ciclo_usuarios/doador/tela_ranking.dart';
import 'dart:convert';

import 'package:sdmr/main.dart';
import 'package:sdmr/ciclo_doacao/doador/tela_lista_doacoes_materiais.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import '../../ciclo_doacao/doador/tela_buscar_ponto_coleta.dart';
import 'package:sdmr/constantes/constantes.dart';


/*class TelaInicialDoador extends StatelessWidget {
  const TelaInicialDoador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pts = 0;
    int pendentes = 0;
    int concluidas = 0;

    void fetch_data() async{
      try{
        http.Response response = await http.get(Uri.parse(
            kUrlUsuarios+'dados_doacao_doador/$globalIdUser'),
            headers: {
              HttpHeaders.authorizationHeader: "TOKEN $globalToken",
            }
        );
        var data = json.decode(response.body);
        print(response.body);
        pts = jsonDecode(response.body)['num_pontos_gerais'];

      }
      catch (e){
        print('Erro $e');
      }
    }
    fetch_data();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Recycle',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),

      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '',
                ),
                Text(
                  'Bem-vindo, doador',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Column(
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.teal,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Pontos:',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 30.0
                              ),
                            ),
                            Text(
                              pts.toString()+' pts:',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 45.0
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Container(
                      child: Column(
                        children: [
                          Text(
                            'Doa????es Pend.:',
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 20.0
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                            },
                            child: Text(
                              'Verificar',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 5,
                      shadowColor: Colors.teal,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              'Doa????es:',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              'Conclu??das:',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              '25',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30.0
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 5,
                          shadowColor: Colors.teal,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Doa????es',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 20.0
                                  ),
                                ),
                                Text(
                                  'Pendentes',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 20.0
                                  ),
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                          },
                          child: Text(
                            'Verificar',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  child: Text(
                    'Agendar Doa????o',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaBuscarPontoColeta()), (route) => false);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaBuscarPontoColeta()
                      ),);*/
                  },
                ),
                /*ElevatedButton(
                  child: Text(
                    'Confirmar Agend. Doacao',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesAguardandoConfAgend()), (route) => false);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaListaDoacoesAguardandoConfAgend()
                      ),);*/
                  },
                ),*/
                /*ElevatedButton(
                  child: Text(
                    'Doa????es Agendadas',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesAgendadas()), (route) => false);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaListaDoacoesAgendadas()
                      ),);*/
                  },
                ),*/
                ElevatedButton(
                  child: Text(
                    'Confirmar Doa????o',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaListaDoacoesMateriais()
                      ),);*/
                  },
                ),
                ElevatedButton(
                  child: Text(
                    'Cupons',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  onPressed: (){}/*
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaListaDoacoesMateriais()
                      ),);*/
                  },*/
                ),
                ElevatedButton(
                  child: Text(
                    'Sair',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: (){
                    globalIdUser = 0;
                    globalToken = '';
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaLogin()), (route) => false);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaListaDoacoesAguardandoConfAgend()
                      ),);*/
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
        ],
      ),
    );
  }
}*/



bool atualizar_dados_doador = true;

class TelaInicialDoador extends StatefulWidget {
  const TelaInicialDoador({Key? key}) : super(key: key);

  @override
  State<TelaInicialDoador> createState() => _TelaInicialDoadorState();
}

class _TelaInicialDoadorState extends State<TelaInicialDoador> {
  double pts = 0;
  int pendentes = 0;
  int concluidas = 0;
  double pts_ranking = 0;

  void fetch_data() async{
    try{
      http.Response response = await http.get(Uri.parse(
          kUrlUsuarios+'dados_doacao_doador/$globalIdUser'),
          headers: {
            HttpHeaders.authorizationHeader: "TOKEN $globalToken",
          }
      );
      var data = json.decode(response.body);
      //print(response.body);
      setState(() {
        pts = jsonDecode(response.body)['num_pontos_gerais'];
        pts_ranking  = jsonDecode(response.body)['num_pontos_ranking'];
        concluidas = jsonDecode(response.body)['doacoes_concluidas'];
        pendentes = jsonDecode(response.body)['doacoes_pendentes'];
      });


    }
    catch (e){
      print('Erro $e');
    }
  }

  @override
  void initState() {
    print('inicializou');
    fetch_data();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Recycle',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                  ),
                  Text(
                    'Bem-vindo, doador',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.teal,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Pontos:',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 30.0
                                ),
                              ),
                              Text(
                                pts.toString()+' pts',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 45.0
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: Colors.teal,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                          child: Column(
                            children: [
                              Text(
                                'Doa????es:',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20.0
                                ),
                              ),
                              Text(
                                'Conclu??das:',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20.0
                                ),
                              ),
                              Text(
                                concluidas.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 30.0
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 5,
                            shadowColor: Colors.teal,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Doa????es',
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  Text(
                                    'Pendentes',
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  Text(
                                    pendentes.toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          (pendentes <= 0) ? SizedBox() :
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                            },
                            child: Text(
                              'Verificar',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Agendar Doa????o',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaBuscarPontoColeta()), (route) => false);
                    },
                  ),
                  /*
                  ElevatedButton(
                    child: Text(
                      'Confirmar Doa????o',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesMateriais()), (route) => false);
                    },
                  ),
                  */
                  ElevatedButton(
                    child: Text(
                      'Ranking',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                    onPressed: (){
                      if(pts_ranking > 0){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context)=>TelaRanking()), (route) => false);
                      }
                      else{
                        Alert(
                          style: AlertStyle(
                            isCloseButton: true,
                            backgroundColor: Colors.white,
                          ),
                          onWillPopActive: false,
                          context: context,
                          type: AlertType.error,
                          //image: Image.asset("img/icon_alert_sucesso.png"),
                          title: "N??o ?? poss??vel acessar",
                          desc: "Voc?? precisa fazer uma doa????o nesta semana",
                          buttons: [
                            DialogButton(
                              color: Colors.teal,
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: ()  => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                    },
                  ),
                  ElevatedButton(
                      child: Text(
                        'Cupons',
                        style: kTextoBotao,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      onPressed: (){

                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaGeralCupons()), (route) => false);
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaListaDoacoesMateriais()
                        ),);*/
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      'Sair',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: (){
                      globalIdUser = 0;
                      globalToken = '';
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaLogin()), (route) => false);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
