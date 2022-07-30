import 'package:cardnesia/layouts/grid_de_cartas.dart';
import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/models/deck.dart';
import 'package:cardnesia/utils/loading.dart';
import 'package:flutter/material.dart';

class PaginaDeUmDeck extends StatelessWidget {
  const PaginaDeUmDeck({required this.deck, Key? key}) : super(key: key);
  final Deck deck;
  Future<List<Carta>> _cartas() async {
    final List<Carta> cartas = [];
    for (final c in deck.cartas) {
      final map = (await c['carta'].get()).data();
      cartas.add(Carta.fromMap(map)..quantidade = c['quantidade']);
    }
    return cartas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(deck.nome), centerTitle: true),
      body: FutureBuilder<List<Carta>>(
        future: _cartas(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Loading(message: 'Carregando Cartas...');
            case ConnectionState.active:
            case ConnectionState.done:
              return GradeDeCartas(cartas: snapshot.data!);
          }
        },
      ),
    );
  }
}
