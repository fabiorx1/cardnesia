import 'package:cardnesia/models/carta.dart';

class Deck {
  final List cartas;
  final String nome;
  Deck({required this.cartas, required this.nome});
  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      nome: map['nome'] ?? 'Deck sem Nome',
      cartas: map['cartas'],
    );
  }
}
