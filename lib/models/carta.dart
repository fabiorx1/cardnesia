class Carta {
  final String titulo;

  Carta({required this.titulo});

  factory Carta.fromMap(Map<String, dynamic> map) {
    return Carta(titulo: map['titulo']);
  }
}
