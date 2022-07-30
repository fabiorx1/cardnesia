import 'package:cardnesia/models/jogador.dart';
import 'package:flutter/material.dart';

class CampoDeBatalha extends StatefulWidget {
  final Jogador j;
  const CampoDeBatalha(this.j, {Key? key}) : super(key: key);

  @override
  State<CampoDeBatalha> createState() => _CampoDeBatalhaState();
}

class _CampoDeBatalhaState extends State<CampoDeBatalha> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Campo de Batalha'));
  }
}
