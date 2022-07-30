import 'package:cardnesia/styles/geral.dart';
import 'package:flutter/material.dart';

class BotaoLigaDesliga extends StatelessWidget {
  final String tituloOn;
  final String tituloOff;
  final bool ligado;
  final void Function()? onTap;
  const BotaoLigaDesliga(
      {this.tituloOn = 'Ligado',
      this.tituloOff = 'Desligado',
      this.ligado = false,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const br18 = BorderRadius.all(Radius.circular(18));
    return Material(
      borderRadius: br18,
      elevation: ligado ? 2 : 8,
      color: ligado ? Colors.black12 : Colors.white60,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ligado ? tituloOn : tituloOff,
            style: normal16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
