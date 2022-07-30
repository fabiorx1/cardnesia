import 'package:cardnesia/models/jogador.dart';
import 'package:cardnesia/pages/cartas.dart';
import 'package:cardnesia/pages/decks.dart';
import 'package:cardnesia/pages/partida.dart';
import 'package:cardnesia/styles/geral.dart';
import 'package:flutter/material.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardnésia'),
        centerTitle: true,
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _rota(
              context,
              Partida(
                j1: Jogador(nome: 'Jogador 1', sigla: 'J1'),
                j2: Jogador(nome: 'Jogador 2', sigla: 'J2'),
              ),
              'Novo Jogo'),
          _rota(context, const PaginaDeCartas(), 'Cartas'),
          _rota(context, const PaginaDeDecks(), 'Decks'),
        ],
      ),
    );
  }

  _rota(BuildContext context, final Widget pagina, final String label) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pagina,
            ),
          ),
          child: Text(label, style: estiloDeMenu),
        ),
      ),
    );
  }
}
