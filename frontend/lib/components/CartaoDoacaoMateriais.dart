import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_doacao/doador/tela_confirmar_doacao.dart';

import 'package:sdmr/constantes/constantes.dart';

class CartaoDoacaoMateriais extends StatelessWidget {
  final int id;
  final int cod_solicitante;
  final String nome_solicitante;
  final String periodo;
  final String des_email_solicitante;
  final String des_telefone_solicitante;
  final List<dynamic> materiais;

  const CartaoDoacaoMateriais({
    required this.id,
    required this.cod_solicitante,
    required this.nome_solicitante,
    required this.periodo,
    required this.des_email_solicitante,
    required this.des_telefone_solicitante,
    required this.materiais,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context)=>TelaConfirmarDoacao(
          id: id,
          cod_solicitante: cod_solicitante,
          nome_solicitante: nome_solicitante,
          periodo: periodo,
          des_email_solicitante: des_email_solicitante,
          des_telefone_solicitante: des_telefone_solicitante,
          materiais: materiais,
        )), (route) => false);

        /*Navigator.push(context,
            MaterialPageRoute(builder: (context)=> TelaConfirmarDoacao(
              id: id,
              cod_solicitante: cod_solicitante,
              nome_solicitante: nome_solicitante,
              periodo: periodo,
              des_email_solicitante: des_email_solicitante,
              des_telefone_solicitante: des_telefone_solicitante,
              materiais: materiais,
            )));*/
      },
      child: Card(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('ID: '+ id.toString(), style: kCTituloCardPendente1,),
              Text('Doador: '+nome_solicitante, style: kConteudoCardPendente1,),
              Text('Período: '+periodo, style: kConteudoCardPendente1,)
            ],
          ),
        ),
      ),
    );
  }
}