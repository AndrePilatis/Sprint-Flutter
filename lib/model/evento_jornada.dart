class EventoJornada {
  final int dia;
  final String titulo;
  final String descricao;
  final bool concluido;

  const EventoJornada({
    required this.dia,
    required this.titulo,
    required this.descricao,
    this.concluido = true,
  });
}
