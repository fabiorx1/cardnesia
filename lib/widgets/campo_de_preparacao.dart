import 'package:cardnesia/models/jogador.dart';
import 'package:flutter/material.dart';

class CampoDePreparo extends StatefulWidget {
  final Jogador j;
  const CampoDePreparo(this.j, {Key? key}) : super(key: key);

  @override
  State<CampoDePreparo> createState() => _CampoDePreparoState();
}

class _CampoDePreparoState extends State<CampoDePreparo> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Campo de Preparo'));
  }
}
