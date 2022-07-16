import 'package:cardnesia/job/leitor_de_descricao.dart';
import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/main.dart';
import 'package:cardnesia/styles/dominios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CartaGridTile extends StatelessWidget {
  final Carta carta;
  const CartaGridTile(this.carta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: InkWell(
        onTap: () => Leitor.lerDescricao(carta.descricao),
        child: GridTile(
          header: GridTileBar(
            title: Text(
              toFirstUpper(carta.dominio.name),
              style: estiloDoDominio(carta.dominio),
              textAlign: TextAlign.center,
            ),
          ),
          footer: GridTileBar(
            leading: Text(
              '${carta.custo}',
              style: estiloDoCusto(carta.dominio),
            ),
            title: Center(
              child: Text(
                carta.titulo,
                style: blackBold,
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  carta.descricao,
                  style: black,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          child: const Center(child: Icon(PhosphorIcons.moon_light)),
        ),
      ),
    );
  }
}
