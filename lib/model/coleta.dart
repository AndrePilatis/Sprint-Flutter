enum TipoColeta { domiciliar, presencial }

enum StatusColeta { agendada, concluida, cancelada }

class Coleta {
  final String id;
  final DateTime data;
  final String hora;
  final TipoColeta tipo;
  final String doadoraId;
  final String doadoraNome;
  final StatusColeta status;
  final int? volumeMl;

  const Coleta({
    required this.id,
    required this.data,
    required this.hora,
    required this.tipo,
    required this.doadoraId,
    required this.doadoraNome,
    this.status = StatusColeta.agendada,
    this.volumeMl,
  });

  String get tipoLabel =>
      tipo == TipoColeta.domiciliar ? 'Coleta domiciliar' : 'Coleta presencial';

  String get statusLabel {
    switch (status) {
      case StatusColeta.agendada:
        return 'Agendada';
      case StatusColeta.concluida:
        return 'Concluída';
      case StatusColeta.cancelada:
        return 'Cancelada';
    }
  }

  Coleta copyWith({StatusColeta? status, int? volumeMl}) {
    return Coleta(
      id: id,
      data: data,
      hora: hora,
      tipo: tipo,
      doadoraId: doadoraId,
      doadoraNome: doadoraNome,
      status: status ?? this.status,
      volumeMl: volumeMl ?? this.volumeMl,
    );
  }
}
