import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_usuarios/ponto_coleta/tela_inicial_ponto_coleta.dart';
import 'package:sdmr/components/CartaoDoacaoAgendada.dart';
import 'package:sdmr/constantes/constantes.dart';
import 'package:sdmr/main.dart';
import 'package:sdmr/modelos/Doacao.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sdmr/tela_inicial_usuario.dart';

class TelaListaDoacoesAgendadas extends StatefulWidget {
  const TelaListaDoacoesAgendadas({Key? key}) : super(key: key);

  @override
  State<TelaListaDoacoesAgendadas> createState() => _TelaListaDoacoesAgendadasState();
}

class _TelaListaDoacoesAgendadasState extends State<TelaListaDoacoesAgendadas> {
  bool carregando = true;

  List<Doacao> agendados = [];

  void fetch_data() async{
    try{
      http.Response response = await http.get(
          Uri.parse(kUrlDoacao+'confirmar_doacao/'),
          headers: {
            HttpHeaders.authorizationHeader: "TOKEN $globalToken",
          }
      );
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
            des_status_atual_doacao: agendamento['des_status_atual_doacao'],
            materiais: agendamento['materiais']
        );
        agendados.add(agendamentosAux);
      });

      setState(() {
        carregando = false;
      });
      print(agendados.length);
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
          child: Text(
            'Agendamentos',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context)=>TelaInicialPontoColeta()), (route) => false);
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Voltar',
                    style: kBotaoRetono,
                  ),
                ),
              ),
            ),
            carregando ? Text('Sem doações agendadas no momento')
                : Column(
              children: agendados.map((e) {
                if (e.cod_beneficiario == globalIdUser && e.des_status_atual_atendimento == '1' && e.des_status_atual_doacao == '4') {
                  return CartaoDoacaoAgendada(
                    id: e.id,
                    nome_solicitante: e.nome_solicitante +' '+ e.sobrenome_solicitante,
                    periodo: e.dat_dia +' '+ e.des_hora,
                    des_email_solicitante: e.des_email_solicitante,
                    des_telefone_solicitante: e.des_telefone_solicitante,

                  );
                }
                else{
                  return SizedBox(height: 0,);
                }

              }).toList(),
            ),
          ],
        ),
      ),
    );;
  }
}
