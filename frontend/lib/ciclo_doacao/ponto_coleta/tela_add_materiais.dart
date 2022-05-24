import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_lista_doacoes_agendadas.dart';
import 'package:sdmr/ciclo_usuarios/ponto_coleta/tela_inicial_ponto_coleta.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdmr/tela_inicial_usuario.dart';

import '../../main.dart';

Map<String, Card> mapFormulariosMateriais = {};
List<Widget> listaFormulariosMaterial = [];
Map<String, Map> mapValoresMateriaisReciclaveis = {};
int codigo = 0;
class TelaAdicionarMateriais extends StatefulWidget {

  final int id;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;

  const TelaAdicionarMateriais({
    required this.id,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
    Key? key}) : super(key: key);

  @override
  State<TelaAdicionarMateriais> createState() => _TelaAdicionarMateriaisState(
    id: id,
    nome_solicitante: nome_solicitante,
    periodo: periodo,
    des_email_solicitante: des_email_solicitante,
    des_telefone_solicitante: des_telefone_solicitante,
  );
}

class _TelaAdicionarMateriaisState extends State<TelaAdicionarMateriais> {

  final int id;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;

  int _statusCode = 0;

  _TelaAdicionarMateriaisState({
    required this.id,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
  });

  void atualizarStatusDoacao() async{
    http.Response response = await http.get(
        Uri.parse(kUrlDoacao+'confirmar_doacao/$id'),
        headers: {
          HttpHeaders.authorizationHeader: "TOKEN $globalToken",
        },
    );
    var data = json.decode(response.body);

    /*print("id " +data['id'].toString());
    print("cod_solicitante "+ data['cod_solicitante'].toString());
    print("cod_beneficiario "+ data['cod_beneficiario'].toString());
    print("dat_dia "+ data['dat_dia']);
    print("des_hora: " +data['des_hora']);
    print(data['bool_confirmado']);
    print(data['des_status_atual_atendimento']);
    print(data['des_status_atual_doacao']);
    //print(data['cod_beneficiario'].runtimeType);*/

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
        "des_status_atual_atendimento": '2',
        "des_status_atual_doacao": '4'
      },
      ),
    );
    if (response.statusCode == 200){
      print('ok-atualizou_status');
      setState(() {
        atualizar_dados_ponto_coleta = true;
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
        title: "Materiais cadastrados",
        desc: "Doador irá confirmar doação",
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
      //Navigator.pushAndRemoveUntil(
      //    context, MaterialPageRoute(builder: (context)=>TelaInicialPontoColeta()), (route) => false);
    }
    else {
      print('Não deu');
    }
  }

  void cadastrarMateriais({
    required String nome,
    required String tipo,
    required double qtde,
    required double pontos,
    required int index,
    required int total_materiais
}) async{
    try{
      http.Response response = await http.post(Uri.parse(kUrlDoacao+'material/'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "TOKEN $globalToken",
            "Content-Type": "application/json; charset=UTF-8"
          },

          body: jsonEncode(<String, dynamic>{
            "des_nome_material": nome,
            "des_tipo_material": tipo,
            "num_quantidade_kg": qtde,
            "num_pontos": pontos,
            "cod_doacao": id

          }),
      );
      if (response.statusCode == 201){
        print('ok-cadastro_materiais');
        print(index);
        if(index+1 == total_materiais){
          atualizarStatusDoacao();
        }
      }
      else {
        print('Não deu');
      }
    }
    catch (e){
      print('Erro'+e.toString());
    }
    //atualizarStatusDoacao();
  }


  void adicionarFormulario(){
    int identificacao = codigo;
    String nome = '';
    String tipo = '';
    double qtde = 0;
    double pontos = 0;

    Map<String, dynamic> mapaValores = new Map();
    mapaValores['nome'] =nome;
    mapaValores['tipo'] =tipo;
    mapaValores['qtde'] =qtde;
    mapaValores['pontos'] =pontos;
    mapaValores['_controller'] = TextEditingController(text: '');

    mapFormulariosMateriais[identificacao.toString()] =
        Card(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.teal,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Material: '+(identificacao+1).toString(),
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white),
                      ),
                      GestureDetector(
                          onTap: (){
                            mapFormulariosMateriais.remove(identificacao.toString());
                            mapValoresMateriaisReciclaveis.remove(identificacao.toString());
                            listaFormulariosMaterial = [];
                            mapFormulariosMateriais.forEach((key, value) => listaFormulariosMaterial.add(value));
                            setState(() {
                            });

                          },
                          child: Icon(Icons.delete, color: Colors.white,)),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Nome',
                    ),
                    controller: TextEditingController()..text = nome,
                    onChanged: (val) => setState(() {
                      nome = val;
                      mapaValores['nome'] = nome;
                      mapValoresMateriaisReciclaveis[identificacao.toString()] = mapaValores;
                    }),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Tipo'
                    ),
                    controller: TextEditingController()..text = tipo,
                    onChanged: (val) => setState(() {
                      tipo = val;
                      mapaValores['tipo'] = tipo;
                      mapValoresMateriaisReciclaveis[identificacao.toString()] = mapaValores;
                    }),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Qtd(KG)'
                    ),
                    controller: TextEditingController()..text = qtde.toString(),
                    onChanged: (val) => setState(() {
                      qtde = double.parse(val);
                      mapaValores['qtde'] = qtde;
                      mapValoresMateriaisReciclaveis[identificacao.toString()] = mapaValores;
                    }),
                  ),
                  TextField(
                    controller: mapaValores['_controller']..text = (qtde*10).toString(),//pontos.toString(),
                    onTap: (){
                      setState(() {
                        mapaValores['_controller'].text = (qtde*5).toString();
                      });
                    },
                    onChanged: (val) => setState(() {
                      //val = (qtde * 10).toString();
                      //print(val);
                      //print(pontos);
                      pontos = double.parse(val);
                      mapaValores['pontos'] = pontos;
                      mapValoresMateriaisReciclaveis[identificacao.toString()] = mapaValores;
                    }),
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Pontos'
                    ),
                  ),
                ],
              )
            ],
          ),
        );
    setState(() {
      mapValoresMateriaisReciclaveis[identificacao.toString()] = mapaValores;
      listaFormulariosMaterial = [];
      mapFormulariosMateriais.forEach((key, value) => listaFormulariosMaterial.add(value));
      codigo++;
    });
    print(mapaValores);
    print(mapValoresMateriaisReciclaveis[identificacao.toString()]);
    print(mapValoresMateriaisReciclaveis);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Cadastrar Materiais',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Column(
          children: [

            Container(
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
                      /*Container(
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
                      ),*/
                      /*Container(
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        child: ElevatedButton(
                          onPressed:(){
                            confirmado ?
                            confirmarAgendamento(
                                bool_confirmado: true,
                                des_status_atual_atendimento: '1',
                                des_status_atual_doacao: '1')
                                :confirmarAgendamento(
                                bool_confirmado: false,
                                des_status_atual_atendimento: '3',
                                des_status_atual_doacao: '3');
                            //Navigator.pop(context);
                            Navigator.pop(context);


                          },
                          child: Text('Confirmar', style: kTextoBotao,),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.teal),
                          ),

                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: listaFormulariosMaterial,
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 48,),
                  child: ElevatedButton(
                    onPressed:(){
                      var listaAuxiliar = [];
                      setState(() {
                        mapValoresMateriaisReciclaveis.forEach((key, value) => listaAuxiliar.add(value));
                      });
                      listaAuxiliar.forEach((e) {
                        print(e);
                        cadastrarMateriais(
                          nome: e['nome'],
                          tipo: e['tipo'],
                          qtde: e['qtde'],
                          pontos: e['qtde'] * 5,
                          index: listaAuxiliar.indexOf(e),
                          total_materiais: listaAuxiliar.length
                        );
                      });
                      /*listaAuxiliar.map((e) => {
                        print(e),
                        cadastrarMateriais(
                          nome: e['nome'],
                          tipo: e['tipo'],
                          qtde: e['qtde'],
                          pontos: e['qtde'] * 5
                        ),
                      });*/
                      setState(() {
                        mapFormulariosMateriais = {};
                        listaFormulariosMaterial = [];
                        mapValoresMateriaisReciclaveis = {};
                        codigo = 0;
                      });
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 48,),
                  child: ElevatedButton(
                    onPressed:(){
                      setState(() {
                        mapFormulariosMateriais = {};
                        listaFormulariosMaterial = [];
                        mapValoresMateriaisReciclaveis = {};
                        codigo = 0;
                      });
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaListaDoacoesAgendadas()), (route) => false);
                      //Navigator.pop(context);
                    },
                    child: Text('Cancelar', style: kTextoBotao,),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: adicionarFormulario,
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
      ),
    );
  }
}


/*class MaterialFormWidget extends StatelessWidget {
  final int codigo;
  const MaterialFormWidget({
    required this.codigo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.teal,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Material: '+codigo.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: (){
                      mapFormulariosMateriais.remove(codigo);
                    },
                      child: Icon(Icons.delete, color: Colors.white,)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Nome'
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Tipo'
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Qtd(KG)'
                ),
              ),
              TextField(
                controller: TextEditingController()..text = 'Valor inicial',
                onChanged: (text) => {},
                readOnly: true,
                decoration: InputDecoration(
                    labelText: 'Pontos'
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}*/

/*class MaterialFormWidget extends StatefulWidget {
  final int codigo;
  const MaterialFormWidget({
    required this.codigo,
    Key? key}) : super(key: key);

  @override
  State<MaterialFormWidget> createState() => _MaterialFormWidgetState(codigo: codigo);
}

class _MaterialFormWidgetState extends State<MaterialFormWidget> {
  final int codigo;
  _MaterialFormWidgetState({
    required this.codigo,
});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.teal,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Material: '+codigo.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  GestureDetector(
                      onTap:(){
                        setState(() {
                          formularios.remove(codigo);
                          print(formularios.length);
                        });

                      },
                      child: Icon(Icons.delete, color: Colors.white,)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Nome'
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Tipo'
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Qtd(KG)'
                ),
              ),
              TextField(
                controller: TextEditingController()..text = 'Valor inicial',
                onChanged: (text) => {},
                readOnly: true,
                decoration: InputDecoration(
                    labelText: 'Pontos'
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
*/