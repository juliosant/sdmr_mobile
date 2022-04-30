import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdmr/modelos/MaterialReciclavel.dart';

typedef apagarForm();

class MaterialForm extends StatefulWidget {

  final MaterialReciclavel material;
  final _MaterialFormState estado = _MaterialFormState();
  final apagarForm apagar;

  MaterialForm({required this.material, required this.apagar});

  @override
  State<MaterialForm> createState() => estado;
}

class _MaterialFormState extends State<MaterialForm> {
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            AppBar(title: Text('Material'),)
          ],
        ),
      ),
    );
  }
}


