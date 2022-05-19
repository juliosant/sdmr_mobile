import 'package:flutter/material.dart';

class TagMaterial extends StatelessWidget {
  const TagMaterial({
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