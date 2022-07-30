import 'package:cardnesia/models/jogador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class Hud2 extends StatelessWidget {
  final Jogador j;
  final bool doOponente;
  const Hud2(
    this.j, {
    this.doOponente = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 64),
      child: ListView(
        shrinkWrap: true,
        children: [
          status(
            icon: Icon(
              Icons.health_and_safety,
              color: Colors.green.shade400,
              size: 32,
            ),
            color: Colors.green.shade400,
            info: '${j.vida}',
          ),
          status(
            icon: Icon(
              PhosphorIcons.circle_fill,
              color: Colors.blue.shade800,
              size: 32,
            ),
            color: Colors.blue.shade800,
            info: '${j.mana}',
          ),
          status(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  PhosphorIcons.circle_fill,
                  color: Colors.amber.shade800,
                  size: 32,
                ),
                const Icon(
                  PhosphorIcons.star,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
            color: Colors.amber.shade800,
            info: '${j.devocao}',
          ),
          status(
              icon: const Icon(
                Icons.person,
                color: Colors.black45,
                size: 32,
              ),
              color: Colors.black45,
              info: '${doOponente ? 'Oponente' : 'Você'}\n${j.sigla}',
              pequeno: true),
        ],
      ),
    );
  }

  Widget status(
      {required final Color color,
      required String info,
      required final Widget icon,
      final bool pequeno = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pequeno ? 4 : 8.0),
      child: Column(
        children: [
          icon,
          Center(
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: pequeno ? 12 : 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
