import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sdmr/ciclo_usuarios/doador/tela_inicial_doador.dart';
import 'dart:convert';

import 'package:sdmr/constantes/constantes.dart';

import 'package:sdmr/components/CartaoBusca.dart';
import 'package:sdmr/main.dart';
import 'package:sdmr/modelos/PontoColeta.dart';
import 'package:sdmr/tela_inicial_usuario.dart';

import 'package:material_tag_editor/tag_editor.dart';
import 'package:material_tag_editor/tag_editor_layout_delegate.dart';
import 'package:material_tag_editor/tag_layout.dart';
import 'package:material_tag_editor/tag_render_layout_box.dart';

class TelaBuscarPontoColeta extends StatefulWidget {
  
  @override
  State<TelaBuscarPontoColeta> createState() => _TelaBuscarPontoColetaState();
}

class _TelaBuscarPontoColetaState extends State<TelaBuscarPontoColeta> {
  bool carregando = true;
  
  List<PontoColeta> pontosColetaEncontrados = [];

  List<String> tipo_materiais = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  _onDelete(index) {
    setState(() {
      tipo_materiais.removeAt(index);
    });
  }


  void fetch_data() async{
    try{
      http.Response response = await http.get(
        Uri.parse(kUrlUsuarios+'pontoColeta/'),
        headers: {
          HttpHeaders.authorizationHeader: "TOKEN $globalToken"
        }
      );
      var data = json.decode(response.body);
      print(data);
      data.forEach((pontoColeta){
        PontoColeta pontoColetaAux = PontoColeta(
            /*id: pontoColeta['id'],
            des_telefone: pontoColeta['des_telefone'],
            des_nome_instituicao: pontoColeta['des_nome_instituicao'],
            email: pontoColeta['email'],
            des_tipo_perfi: pontoColeta['des_tipo_perfi'],
            des_sobre_mim: pontoColeta['des_sobre_mim'],*/
            id: pontoColeta['id'],
            des_telefone: pontoColeta['des_telefone'],
            des_tipo_perfi: pontoColeta['des_tipo_perfi'],
            des_sobre_mim: pontoColeta['des_sobre_mim'],
            des_nome_instituicao: pontoColeta['des_nome_instituicao'],
            email: pontoColeta['email'],
            des_nome_local: pontoColeta['des_nome_local'],
            des_nome_rua_av: pontoColeta['des_nome_rua_av'],
            des_numero: pontoColeta['des_numero'],
            des_bairro: pontoColeta['des_bairro'],
            des_cidade: pontoColeta['des_cidade'],
            des_estado: pontoColeta['des_estado'],
            des_complemento: pontoColeta['des_complemento'],
        );
        pontosColetaEncontrados.add(pontoColetaAux);
      });
      setState(() {
        carregando = false;
      });

      print(pontosColetaEncontrados.length);
      pontosColetaEncontrados.forEach((pontoColeta) {
        print('id: ' + pontoColeta.id.toString());
        print('Ponto de Coleta: ' + pontoColeta.des_nome_instituicao);
        print('Dados:' + pontoColeta.email +
            ' - ' + pontoColeta.des_telefone);

      });
    }
    catch (e){
      print('Erro $e');
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
            'Buscar Ponto de Coleta',
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all( color: Colors.teal),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: TagEditor(
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
                        hintStyle: TextStyle(color: Colors.teal, fontSize: 25),
                      ),
                      onTagChanged: (newValue) {
                        setState(() {
                          tipo_materiais.add(newValue);
                        });
                      },
                      tagBuilder: (context, index) => _Chip(
                        index: index,
                        label: tipo_materiais[index],
                        onDeleted: _onDelete,
                      ),
                      // InputFormatters example, this disallow \ and /
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                      ],
                    ),
                    /*TextField(
                      onSubmitted: (String text){
                          print(text);
                        },
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Buscar Ponto de Coleta',
                          labelStyle: TextStyle(fontSize: 25)
                      ),
                    ),*/
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      print(tipo_materiais);
                      /*Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => TelaAgendamento(),
                          ),
                      );*/
                    },
                    child: Text('Buscar', style: TextStyle(fontSize: 25.0),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context)=>TelaInicialDoador()), (route) => false);
                    },
                    child: Text(
                      'Voltar',
                      style: kBotaoRetono,

                    ),
                  ),
                ),
              ],
            ),
            carregando ? Text('Sem dados')
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
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.teal,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label, style: TextStyle(color: Colors.white, fontSize: 25),),
      deleteIcon: Icon(
        Icons.close,
        size: 20,
        color: Colors.white,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}



/*CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),
                CartaoResultadoBusca(),
                SizedBox(height: 10,),*/
