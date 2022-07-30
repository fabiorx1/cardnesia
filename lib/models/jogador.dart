import 'package:cardnesia/models/deck.dart';

class Jogador {
  final String nome;
  final String sigla;
  int vida;
  int mana;
  int devocao;
  Deck? deck;
  Jogador({
    this.nome = 'jogador X',
    this.sigla = 'JX',
    this.vida = 40,
    this.mana = 0,
    this.devocao = 0,
    this.deck,
  });
}
