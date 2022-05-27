import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import  'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


import 'package:sdmr/constantes/constantes.dart';

import 'package:sdmr/ciclo_usuarios/doador/tela_inicial_doador.dart';
import 'package:sdmr/main.dart';
import 'package:sdmr/modelos/Cupom.dart';

class TelaGeralCupons extends StatefulWidget {
  const TelaGeralCupons({Key? key}) : super(key: key);

  @override
  State<TelaGeralCupons> createState() => _TelaGeralCuponsState();
}

class _TelaGeralCuponsState extends State<TelaGeralCupons> {
  double valor = 0;
  String chave = '';
  String dia = '';
  String hora = '';

  String nome = '';
  String sobrebome = '';
  int concluidas = 0;
  int pendentes = 0;
  double pts = 0;
  double pts_usados = 0;

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  List<Cupom> cupons = [];
  bool carregando = true;

  final _controller = TextEditingController(text: '');
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Não pode ser vazio';
    }
    if (double.parse(text) * 5 > pts) {
      return 'Valor maior que sua pontuação';
    }
    // return null if the text is valid
    return null;
  }

  void fetch_data() async{
    // Dados doador
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
        nome = jsonDecode(response.body)['first_name'];
        sobrebome = jsonDecode(response.body)['last_name'];
        concluidas = jsonDecode(response.body)['doacoes_concluidas'];
        pendentes = jsonDecode(response.body)['doacoes_pendentes'];
      });

    }
    catch (e){
      print('Erro $e');
    }

    // Cupons
    try{
      http.Response response = await http.get(
        Uri.parse(kUrlCupons+'cupom/'),
        headers: {
          HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        },
      );
      var data = json.decode(response.body);
      data.forEach((cupom){
          Cupom cupomAux = Cupom(
              id: cupom['id'],
              num_valor: double.parse(cupom['num_valor']),
              des_chave: cupom['des_chave'],
              bool_usado: cupom['bool_usado'],
              dat_expiracao: cupom['dat_expiracao'],
              des_status: cupom['des_status'],
              dat_criacao: cupom['dat_criacao'],
              cod_doador: cupom['cod_doador']
          );
          cupons.add(cupomAux);
        },
      );
      print(cupons.length);
    }catch(e){
      print(e);
    }
    setState(() {
      carregando = false;
    });
  }

  void substrair_pontos()async{
    http.Response response = await http.put(
      Uri.parse(kUrlUsuarios+'dados_doacao_doador/$globalIdUser'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(
          <String, dynamic>{
            "first_name": nome,
            "last_name": sobrebome,
            "num_pontos_gerais": pts-pts_usados,
            "doacoes_concluidas": concluidas,
            "doacoes_pendentes": pendentes
          }
      ),
    );
    if(response.statusCode == 200){
      print('oksubtracao');
      Alert(
        style: AlertStyle(
          //isCloseButton: false,
          backgroundColor: Colors.white,
        ),
        onWillPopActive: true,
        context: context,
        //type: AlertType.success,
        image: Image.asset("img/icon_alert_sucesso.png"),
        title: "Cupom Criado",
        desc: "Valor de $valor",
        buttons: [
          DialogButton(
            color: Colors.teal,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: ()=> Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>TelaGeralCupons()), (route) => false),
            width: 120,
          )
        ],
      ).show();
    }
    else{
      print('Deu ruim '+ response.statusCode.toString());
    }
  }

  String obterStringRandomica(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void criar_cupom()async{
    if(pts_usados <= pts && pts_usados > 0){
      setState(() {
        //hora =  DateFormat("HH:mm:ss").format(DateTime.now());
        //--------------------------------------------
        hora = DateFormat("HH:mm:ss").format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour+3,
            DateTime.now().minute,
            DateTime.now().second+30
        ));
        print(DateFormat("HH:mm:ss").format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour+3,
            DateTime.now().minute+1,
            DateTime.now().second
        )));
        //--------------------------------------------
        dia = DateFormat('yyyy-MM-dd').format(
            DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day)).toString();
                //DateTime.now().day+3)).toString();
        chave = obterStringRandomica(10);
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
      if (response.statusCode == 201){
        print('subtrair pontos');
        substrair_pontos();
      }
      else{
        print('deu errado');
      }
    }
  }

  void adicionar_pontos(double valor_ressarcido)async{
    http.Response response = await http.put(
      Uri.parse(kUrlUsuarios+'dados_doacao_doador/$globalIdUser'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(
          <String, dynamic>{
            "first_name": nome,
            "last_name": sobrebome,
            "num_pontos_gerais": pts + (valor_ressarcido*5),
            "doacoes_concluidas": concluidas,
            "doacoes_pendentes": pendentes
          }
      ),
    );
    if(response.statusCode == 200){
      print('oksubtracao');
      Alert(
        style: AlertStyle(
          isCloseButton: false,
          backgroundColor: Colors.white,
        ),
        onWillPopActive: true,
        context: context,
        //type: AlertType.success,
        image: Image.asset("img/icon_alert_sucesso.png"),
        title: "Cupom Removido",
        desc: "${valor_ressarcido*5} pontos recuperados",
        buttons: [
          DialogButton(
            color: Colors.teal,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>TelaGeralCupons()), (route) => false),
            width: 120,
          )
        ],
      ).show();
    }
    else{
      print('Deu ruim '+ response.statusCode.toString());
    }
  }
  void excluir_cupom(int cod_cupom, double valor_ressarcido)async{

    http.Response response = await http.delete(
      Uri.parse(
          kUrlCupons+'cupom/$cod_cupom'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        "Content-Type": "application/json; charset=UTF-8"
      },
    );
    if (response.statusCode == 204){
      print('add pontos');
      adicionar_pontos(valor_ressarcido);
    }
    else{
      print('deu errado apagar');
    }
  }

  String alterar_fuso(String hora){
    List<String> componentes = hora.split(":");
    componentes[0] = (int.parse(componentes[0])-3).toString();
    String horario_novo = componentes.join(":");
    return horario_novo;
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetch_data();
    super.initState();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
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
                        pts.toString(),
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
                    child: Column(
                      children: [
                        Text(
                          'Cupons disponíveis:',
                          style: TextStyle(
                            fontSize: 25.0
                          ),
                        ),
                        Wrap(
                          //alignment: WrapAlignment.end,
                          children: cupons.map((e)
                            {
                              if( e.des_status == 'A' && e.cod_doador == globalIdUser){
                                return Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:25, vertical: 8),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            Text(
                                              'Cupom',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 55,),

                                            GestureDetector(
                                              onTap: (){
                                                print('Apagar ${e.id}?');
                                                excluir_cupom(e.id, e.num_valor);
                                              },
                                              child: Icon(
                                                Icons.highlight_remove,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          'R\$ ${e.num_valor}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            print('Verificar ${e.id}?');
                                            Alert(
                                              context: context,
                                              //type: AlertType.error,
                                              title: e.des_chave,
                                              desc: 'Expira em: \n ${DateFormat("dd/mm/yyyy").format(DateTime.parse(e.dat_expiracao)) } às ${alterar_fuso(DateFormat("HH:mm a").format(DateTime.parse(e.dat_expiracao)))}',
                                              style: AlertStyle(
                                                titleStyle: TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.green
                                                ),
                                                descStyle: TextStyle(color: Colors.red),
                                                descTextAlign: TextAlign.end
                                              ),
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Voltar",
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  width: 120,
                                                  color: Colors.teal,
                                                )
                                              ],
                                            ).show();
                                          },
                                          child: Text(
                                            '> Código de Uso <',
                                            style: TextStyle(
                                                backgroundColor: Colors.green.shade700,
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              );
                              }else
                                {
                                  return SizedBox();
                                }
                            },
                          ).toList(),
                        )
                      ],
                    )
                  ),
                  Container(
                      child: Column(
                        children: [
                          Text(
                            'Cupons vencidos:',
                            style: TextStyle(
                                fontSize: 25.0
                            ),
                          ),
                          Wrap(
                            children: cupons.map((e)
                            {
                            if( e.des_status == 'E' && e.cod_doador == globalIdUser){
                              return Card(
                                color: Colors.deepOrangeAccent.shade700,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:25, vertical: 8),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'Cupom',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 55,),

                                          GestureDetector(
                                            onTap: (){
                                              print('Apagar ${e.id}?');
                                              excluir_cupom(e.id, e.num_valor);
                                            },
                                            child: Icon(
                                              Icons.highlight_remove,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'R\$ ${e.num_valor}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          print('Verificar ${e.id}?');
                                        },
                                        child: Text(
                                          '> Regerar <',
                                          style: TextStyle(
                                            backgroundColor: Colors.deepOrange,
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );}
                            else{
                              return SizedBox();
                            }
                            },
                            ).toList(),
                          )
                        ],
                      )
                  ),
                  Container(
                      child: Column(
                        children: [
                          Text(
                            'Cupons usados:',
                            style: TextStyle(
                                fontSize: 25.0
                            ),
                          ),
                          Wrap(
                            children: cupons.map((e)
                            {
                            if( e.des_status == 'U' && e.cod_doador == globalIdUser){
                              return Card(
                                color: Colors.blueGrey,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:25, vertical: 8),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'Cupom',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 55,),

                                          Icon(
                                            Icons.highlight_remove,
                                            color: Colors.blueGrey,
                                            size: 25,
                                          )
                                        ],
                                      ),
                                      Text(
                                        'R\$ ${e.num_valor}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                          backgroundColor: Colors.grey.shade700,
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );}
                            else{
                              return SizedBox();
                            }
                            },
                            ).toList(),
                          )
                        ],
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
                        setState(() {
                          valor = 0;
                          pts_usados = 0;
                        });

                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            isDismissible: true,
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

                                      SizedBox(height: 10,),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _controller,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          errorText: _errorText,
                                          labelText: "Valor",
                                          labelStyle: TextStyle(
                                              fontSize: 25,
                                              color: Colors.teal)
                                        ),
                                        onChanged: (val){
                                          setState(() {
                                            if (val == ''){
                                              valor = 0;
                                              pts_usados=0;
                                            }
                                            else{
                                              valor = double.parse(val);
                                              pts_usados = valor*5;
                                            }
                                          });

                                          //print(pts_usados);
                                        },
                                      ),
                                      /*Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(""),
                                          Text("Pontos Gerais: $pts",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal
                                            ),)
                                        ],
                                      ),*/
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(""),
                                          Text("Pontos usados: ${pts_usados}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red
                                            ),

                                          )
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.teal),
                                        ),
                                        child: Text(
                                          'Criar',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          criar_cupom();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        ).then((value) {
                          setState(() {
                            _controller.text = '';
                          });
                          //Navigator.pushAndRemoveUntil(
                          //    context, MaterialPageRoute(builder: (context)=>TelaGeralCupons()), (route) => false);
                        });
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
      ),
    );
  }
}
