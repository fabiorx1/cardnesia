import 'package:cardnesia/job/leitor_de_descricao.dart';
import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/models/enums.dart';
import 'package:cardnesia/styles/dominios.dart';
import 'package:cardnesia/styles/geral.dart';
import 'package:cardnesia/widgets/dialogo_carta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CartaGridTile extends StatelessWidget {
  final Carta carta;

  const CartaGridTile(this.carta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      child: InkWell(
        onTap: () {
          Leitor.lerDescricao(carta.descricao);
          showDialog(
              context: context, builder: (_) => DialogoCarta(carta: carta));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
          child: v2(),
        ),
      ),
    );
  }

  Widget v2() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              Text(
                toFirstUpper(carta.dominio.name),
                style: estiloDoDominio(carta.dominio),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  carta.titulo,
                  style: blackBold,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child: Center(child: icone(carta.raridade))),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: SizedBox(
                      height: 64,
                      child: Center(
                        child: Text(
                          carta.descricao,
                          style: black,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _info('Custo: ${carta.custo}'),
                      _info('Vida: ${carta.vida}'),
                      _info('Poder: ${carta.poder}'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0, top: 2),
          child: Text(
            toFirstUpper(carta.raridade.name),
            style: blackItalic,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Material _info(final String info) {
    const br8 = BorderRadius.all(Radius.circular(8));
    return Material(
      borderRadius: br8,
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(), borderRadius: br8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
          child: Text(
            info,
            style: normal16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  GridTile v1() {
    return GridTile(
      header: GridTileBar(
        leading: _vida(),
        trailing: _poder(),
        title: Text(
          toFirstUpper(carta.dominio.name),
          style: estiloDoDominio(carta.dominio),
          textAlign: TextAlign.center,
        ),
      ),
      footer: GridTileBar(
        leading: _custo(),
        trailing: carta.quantidade != null ? _quantidade() : null,
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
      child: icone(carta.raridade),
    );
  }

  Widget icone(final Raridade raridade) {
    switch (raridade) {
      case Raridade.criatura:
        return const Icon(PhosphorIcons.dog_bold, size: 64);

      case Raridade.semideus:
        return const Icon(PhosphorIcons.bird_bold, size: 64);

      case Raridade.devoto:
        return const Icon(PhosphorIcons.person_bold, size: 64);
    }
  }

  Text _custo() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${carta.custo}\n',
            style: estiloDoCusto(carta.dominio),
          ),
          TextSpan(
            text: 'Custo',
            style: estiloDoCusto(carta.dominio).copyWith(fontSize: 14),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _quantidade() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${carta.quantidade}\n',
            style: estiloDePoder,
          ),
          TextSpan(
            text: 'Cópias',
            style: estiloDePoder.copyWith(fontSize: 14),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _poder() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${carta.poder}\n',
            style: estiloDePoder,
          ),
          TextSpan(
            text: 'Poder\n',
            style: estiloDePoder.copyWith(fontSize: 14),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _vida() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${carta.vida}\n',
            style: estiloDeVida,
          ),
          TextSpan(
            text: 'Vida\n',
            style: estiloDeVida.copyWith(fontSize: 14),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
