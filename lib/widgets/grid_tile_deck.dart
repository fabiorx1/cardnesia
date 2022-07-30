import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/models/deck.dart';
import 'package:cardnesia/pages/deck.dart';
import 'package:cardnesia/styles/geral.dart';
import 'package:flutter/material.dart';

class DeckGridTile extends StatelessWidget {
  final Deck deck;
  const DeckGridTile(this.deck, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaDeUmDeck(deck: deck),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
          child: GridTile(
            header: GridTileBar(
              title: Text(
                toFirstUpper(deck.nome),
                style: estiloDeDeck,
                textAlign: TextAlign.center,
              ),
            ),
            footer: GridTileBar(leading: _contadorDeCartas()),
            child: const Icon(Icons.collections),
          ),
        ),
      ),
    );
  }

  Text _contadorDeCartas() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${deck.cartas.length}\n',
            style: estiloDeDeck,
          ),
          TextSpan(
            text: 'Cartas',
            style: estiloDeDeck.copyWith(fontSize: 14),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
