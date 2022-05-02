import 'package:flutter/material.dart';
import 'package:sdmr/ciclo_usuarios/tela_login.dart';
import 'package:sdmr/constantes/constantes.dart';

class TelaErroLogin extends StatelessWidget {
  const TelaErroLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'Erro no Login',
            style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Usuário ou senha incorretos. Tente novamente',
                style: kDesTituloPagina,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context)=>TelaLogin()), (route) => false);
                  },
                  child: Text(
                    'Tentar novmente',
                    style: kTextoBotao,
                  ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
