import 'package:cardnesia/models/carta.dart';
import 'package:cardnesia/widgets/grid_tile_carta.dart';
import 'package:flutter/material.dart';

class GradeDeCartas extends StatelessWidget {
  final List<Carta> cartas;
  final bool mostrarNaoColecionaveis;
  const GradeDeCartas(
      {Key? key, required this.cartas, this.mostrarNaoColecionaveis = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colecionaveis = cartas
        .where((carta) => mostrarNaoColecionaveis || carta.colecionavel)
        .toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320.0,
        mainAxisExtent: 328,
      ),
      itemCount: colecionaveis.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CartaGridTile(colecionaveis[index]),
        );
      },
    );
  }
}
