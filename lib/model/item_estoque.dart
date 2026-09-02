enum TipoLeite { colostro, maduro }

enum StatusEstoque { disponivel, pasteurizando, reservado }

class ItemEstoque {
  final String id;
  final TipoLeite tipo;
  final int volumeMl;
  final DateTime validade;
  final String lote;
  final StatusEstoque status;
  final String doadoraNome;

  const ItemEstoque({
    required this.id,
    required this.tipo,
    required this.volumeMl,
    required this.validade,
    required this.lote,
    required this.status,
    required this.doadoraNome,
  });

  String get tipoLabel => tipo == TipoLeite.colostro ? 'Colostro' : 'Leite maduro';

  String get statusLabel {
    switch (status) {
      case StatusEstoque.disponivel:
        return 'Disponível';
      case StatusEstoque.pasteurizando:
        return 'Em pasteurização';
      case StatusEstoque.reservado:
        return 'Reservado';
    }
  }
}
