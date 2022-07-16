import 'package:cardnesia/models/dominios.dart';

enum TipoDeEvento { aoMorrer }

class Evento {
  const Evento(
    this.tipoDeEvento,
    this.descricao,
  );
  final TipoDeEvento tipoDeEvento;
  final String descricao;
}

class Carta {
  final int custo;
  final String titulo;
  final String descricao;
  final Dominios dominio;

  Carta({
    required this.custo,
    required this.titulo,
    required this.dominio,
    required this.descricao,
  });

  factory Carta.fromMap(Map<String, dynamic> map) {
    return Carta(
      titulo: map[Tradutor.titulo],
      custo: map['custo'],
      descricao: map[Tradutor.descricao],
      dominio: _lerDominio(map[Tradutor.dominio]),
    );
  }
}

Dominios _lerDominio(String valor) {
  for (final dom in Dominios.values) {
    if (valor == dom.name) {
      return dom;
    }
  }
  return Dominios.indefinido;
}

class Tradutor {
  static const dominio = 'domínio';
  static const descricao = 'descrição';
  static const titulo = 'título';
}

String toFirstUpper(final String text) =>
    text[0].toUpperCase() + text.substring(1);
