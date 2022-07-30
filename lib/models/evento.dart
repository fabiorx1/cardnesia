enum TipoDeEvento { aoMorrer }

class Evento {
  const Evento(
    this.tipoDeEvento,
    this.descricao,
  );
  final TipoDeEvento tipoDeEvento;
  final String descricao;
}
