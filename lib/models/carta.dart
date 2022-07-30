import 'package:cardnesia/models/enums.dart';

class Carta {
  final int custo;
  final int poder;
  final int vida;
  final String titulo;
  final String descricao;
  final Dominios dominio;
  final Raridade raridade;
  final bool colecionavel;
  int? quantidade;

  Carta({
    required this.custo,
    required this.vida,
    required this.poder,
    required this.titulo,
    required this.dominio,
    required this.raridade,
    required this.descricao,
    required this.colecionavel,
    this.quantidade,
  });

  factory Carta.fromMap(Map<String, dynamic> map) {
    return Carta(
      titulo: map[Tradutor.titulo] ?? 'Carta sem Título',
      custo: map['custo'] ?? 1,
      poder: map['poder'] ?? 1,
      vida: map['vida'] ?? 1,
      descricao: map[Tradutor.descricao] ?? 'Sem Descrição',
      dominio: _lerDominio(map[Tradutor.dominio]),
      raridade: _lerRaridade(map['raridade']),
      colecionavel: map[Tradutor.colecionavel] ?? true,
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

Raridade _lerRaridade(String valor) {
  for (final raridade in Raridade.values) {
    if (valor == raridade.name) {
      return raridade;
    }
  }
  return Raridade.devoto;
}

class Tradutor {
  static const dominio = 'domínio';
  static const descricao = 'descrição';
  static const titulo = 'título';
  static const colecionavel = 'colecionável';
  static const referencia = 'referência';
}

String toFirstUpper(final String text) =>
    text[0].toUpperCase() + text.substring(1);
