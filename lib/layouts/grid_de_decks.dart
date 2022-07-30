import 'package:cardnesia/models/deck.dart';
import 'package:cardnesia/widgets/grid_tile_deck.dart';

import 'package:flutter/material.dart';

class GradeDeDecks extends StatelessWidget {
  final List<Deck> decks;
  const GradeDeDecks({Key? key, required this.decks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 639.0,
        mainAxisExtent: 328,
      ),
      itemCount: decks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DeckGridTile(decks[index]),
        );
      },
    );
  }
}
