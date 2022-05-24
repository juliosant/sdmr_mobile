import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:sdmr/ciclo_doacao/doador/tela_lista_doacoes_materiais.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_lista_doacoes_agendadas.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_lista_doacoes_aguardando_conf_ag.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import 'package:sdmr/main.dart';
import '../../ciclo_doacao/doador/tela_buscar_ponto_coleta.dart';
import 'package:sdmr/constantes/constantes.dart';

/*class TelaInicialPontoColeta extends StatelessWidget {
  const TelaInicialPontoColeta({Key? key}) : super(key: key);

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
                  'Bem-vindo, ponto coleta',
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
                /*Row(
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
                              '80 pts:',
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
                            'Doações Pend.:',
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
                ),*/
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
                              'Doações:',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              'Concluídas:',
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
                                  'Doações',
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
                                context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesAguardandoConfAgend()), (route) => false);
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
                /*ElevatedButton(
                  child: Text(
                    'Agendar Doação',
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
                ),*/
                ElevatedButton(
                  child: Text(
                    'Confirmar Agend. Doacao',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
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
                ),
                ElevatedButton(
                  child: Text(
                    'Doações Agendadas',
                    style: kTextoBotao,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
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
                ),
                /*ElevatedButton(
                  child: Text(
                    'Confirmar Doação',
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
                ),*/
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

bool atualizar_dados_ponto_coleta = true;

class TelaInicialPontoColeta extends StatefulWidget {
  const TelaInicialPontoColeta({Key? key}) : super(key: key);

  @override
  State<TelaInicialPontoColeta> createState() => _TelaInicialPontoColetaState();
}

class _TelaInicialPontoColetaState extends State<TelaInicialPontoColeta> {
  int pendentes = 0;
  int concluidas = 0;

  void fetch_data() async{
    try{
      http.Response response = await http.get(Uri.parse(
          kUrlUsuarios+'dados_doacao_pontocoleta/$globalIdUser'),
          headers: {
            HttpHeaders.authorizationHeader: "TOKEN $globalToken",
          }
      );
      var data = json.decode(response.body);
      print(response.body);
      setState(() {
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
    // TODO: implement initState
    fetch_data();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (atualizar_dados_ponto_coleta == true) {
      fetch_data();
      setState(() {
        atualizar_dados_ponto_coleta = false;
      });
    }
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
                    'Bem-vindo, ponto coleta',
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
                                'Doações:',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20.0
                                ),
                              ),
                              Text(
                                'Concluídas:',
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
                                    'Doações',
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
                          (pendentes <= 0)
                          ? SizedBox()
                          : GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesAguardandoConfAgend()), (route) => false);
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
                  /*ElevatedButton(
                    child: Text(
                      'Agendar Doação',
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
                  ),*/
                  /*
                  ElevatedButton(
                    child: Text(
                      'Confirmar Agend. Doacao',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
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
                  ),
                  ElevatedButton(
                    child: Text(
                      'Doações Agendadas',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
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
                  ),
                  */
                  /*ElevatedButton(
                    child: Text(
                      'Confirmar Doação',
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
                  ),*/
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
      ),
    );
  }
}
