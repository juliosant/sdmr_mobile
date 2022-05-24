import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_add_materiais.dart';
import 'package:sdmr/constantes/constantes.dart';


class CartaoDoacaoAgendada extends StatelessWidget {
  final int id;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;


  const CartaoDoacaoAgendada({
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
            context, MaterialPageRoute(builder: (context)=>TelaAdicionarMateriais(
          id: id,
          nome_solicitante: nome_solicitante,
          periodo: periodo,
          des_email_solicitante: des_email_solicitante,
          des_telefone_solicitante: des_telefone_solicitante,
        )), (route) => false);

        /*Navigator.push(context,
            MaterialPageRoute(builder: (context)=> TelaAdicionarMateriais(
              id: id,
              nome_solicitante: nome_solicitante,
              periodo: periodo,
              des_email_solicitante: des_email_solicitante,
              des_telefone_solicitante: des_telefone_solicitante,
            )));*/
      },
      child: Card(
        color: Colors.lightGreen,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('ID: '+ id.toString(), style:kCTituloCardPendente1),
              Text('Doador: '+nome_solicitante, style: kConteudoCardPendente1,),
              Text('Período: '+periodo, style: kConteudoCardPendente1,)
            ],
          ),
        ),
      ),
    );
  }
}
