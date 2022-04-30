import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_doacao/doador/tela_agendar_doacao.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:sdmr/modelos/PontoColeta.dart';
import 'dart:convert';

class CartaoResultadoBusca extends StatelessWidget {
  final int id;
  final String des_nome_instituicao;
  final String des_telefone;
  final String email;
  final String endCompleto;

  const CartaoResultadoBusca({
    required this.id,
    required this.des_nome_instituicao,
    required this.des_telefone,
    required this.email,
    required this.endCompleto,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      //padding: EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=>TelaAgendarDoacao(
                id: id,
                des_nome_instituicao: des_nome_instituicao,
                des_telefone: des_telefone,
                email: email,
                endCompleto: endCompleto

            )), (route) => false);
            /*Navigator.push(context,
                MaterialPageRoute(builder: (context)=> TelaAgendarDoacao(
                    id: id,
                    des_nome_instituicao: des_nome_instituicao,
                    des_telefone: des_telefone,
                    email: email,
                    endCompleto: endCompleto)));*/

          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  des_nome_instituicao,
                  style: kTituloCardBusca,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      email,
                      style: kConteudoCardBusca,
                    ),
                    Text(
                      des_telefone,
                      style: kConteudoCardBusca,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}