import 'package:cardnesia/models/carta.dart';
import 'package:flutter/material.dart';

class DialogoCarta extends StatelessWidget {
  const DialogoCarta({
    Key? key,
    required this.carta,
  }) : super(key: key);

  final Carta carta;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Text(carta.descricao),
      ),
    );
  }
}
