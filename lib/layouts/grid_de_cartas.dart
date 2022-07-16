import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/widgets/carta_grid_tile.dart';
import 'package:flutter/material.dart';

class GradeDeCartas extends StatelessWidget {
  final List<Carta> cartas;
  const GradeDeCartas({Key? key, required this.cartas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 639.0,
        mainAxisExtent: 328,
      ),
      itemCount: cartas.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CartaGridTile(cartas[index]),
        );
      },
    );
  }
}
