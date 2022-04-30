import 'package:flutter/material.dart';
import 'package:sdmr/modelos/Doacao.dart';
import 'package:http/http.dart' as http;
import 'package:sdmr/constantes/constantes.dart';
import 'dart:convert';

/*
void fetch_data() async{
  try{
    http.Response response = await http.get(Uri.parse(kUrlDoacao+'confirmar_doacao/'));
    var data = json.decode(response.body);
    data.forEach((agendamento){
      Doacao agendamentosAux = Doacao(
          id: agendamento['id'],
          cod_solicitante: agendamento['cod_solicitante'],
          nome_solicitante: agendamento['nome_solicitante'],
          sobrenome_solicitante: agendamento['sobrenome_solicitante'],
          cod_beneficiario: agendamento['cod_beneficiario'],
          des_email_solicitante: agendamento['des_email_solicitante'],
          des_telefone_solicitante: agendamento['des_telefone_solicitante'],
          dat_dia: agendamento['dat_dia'],
          des_hora: agendamento['des_hora'],
          bool_confirmado: agendamento['bool_confirmado'],
          des_status_atual_atendimento: agendamento['des_status_atual_atendimento'],
          des_status_atual_doacao: agendamento['des_status_atual_doacao']);
      agendamentosAConfirmar.add(agendamentosAux);
    });

    setState(() {
      carregando = false;
    });
    print(agendamentosAConfirmar.length);
    /*print(pontosColetaEncontrados.length);
      pontosColetaEncontrados.forEach((pontoColeta) {
        print('id: ' + pontoColeta.id.toString());
        print('Ponto de Coleta: ' + pontoColeta.des_nome_instituicao);
        print('Dados:' + pontoColeta.email +
            ' - ' + pontoColeta.des_telefone);

      });*/
  }
  catch (e){
    print('Erro $e');
  }
}*/