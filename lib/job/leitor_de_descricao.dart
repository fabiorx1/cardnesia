class Leitor {
  static final palavraChave = RegExp(r'\*(\D+)\*');
  static final evento = RegExp(r'_(\D+)_');

  static lerDescricao(String descricao) {
    final palavras = [
      for (final x in palavraChave.allMatches(descricao)) x.group(1)
    ];
    final eventos = [for (final x in evento.allMatches(descricao)) x.group(1)];
    print('palavras: $palavras');
    print('eventos: $eventos');
  }
}
