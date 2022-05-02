import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_doacao/doador/tela_lista_doacoes_materiais.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_lista_doacoes_agendadas.dart';
import 'package:sdmr/ciclo_doacao/ponto_coleta/tela_lista_doacoes_aguardando_conf_ag.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import 'package:sdmr/main.dart';
import 'ciclo_doacao/doador/tela_buscar_ponto_coleta.dart';
import 'constantes/constantes.dart';

class TelaInicialUsuario extends StatelessWidget {
  const TelaInicialUsuario({Key? key}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Tela inicial do usuário',
                  style: kDesTituloPagina,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
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
                  ),
                  ElevatedButton(
                    child: Text(
                      'Confirmar Agend. Doacao',
                      style: kTextoBotao,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
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
                      backgroundColor: MaterialStateProperty.all(Colors.green),
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
                  ElevatedButton(
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
                  ),
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
          ),
        ],
      ),
    );
  }
}