import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_confirmar_agend_doacao.dart';

import 'package:sdmr/constantes/constantes.dart';

class CartaoAgendamentos extends StatelessWidget {
  final int id;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;


  const CartaoAgendamentos({
    required this.id,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context)=>TelaConfirmarAgendDoacao(
          id: id,
          nome_solicitante: nome_solicitante,
          periodo: periodo,
          des_email_solicitante: des_email_solicitante,
          des_telefone_solicitante: des_telefone_solicitante,
        )), (route) => false);
      },
      /*
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> TelaConfirmarAgendDoacao(
              id: id,
              nome_solicitante: nome_solicitante,
              periodo: periodo,
              des_email_solicitante: des_email_solicitante,
              des_telefone_solicitante: des_telefone_solicitante,
            )));
      },*/
      child: Card(
        color: Colors.greenAccent,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('ID: '+ id.toString(), style: kTituloCardBusca,),
              Text('Doador: '+nome_solicitante, style: kConteudoCardBusca,),
              Text('Período: '+periodo, style: kConteudoCardBusca,)
            ],
          ),
        ),
      ),
    );
  }
}