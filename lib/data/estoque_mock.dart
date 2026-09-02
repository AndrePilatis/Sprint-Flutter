import '../model/item_estoque.dart';

final List<ItemEstoque> estoqueMock = [
  ItemEstoque(
    id: 'e01',
    tipo: TipoLeite.maduro,
    volumeMl: 420,
    validade: DateTime(2026, 8, 30),
    lote: 'LT-0512A',
    status: StatusEstoque.disponivel,
    doadoraNome: 'Carla Mendes',
  ),
  ItemEstoque(
    id: 'e02',
    tipo: TipoLeite.colostro,
    volumeMl: 90,
    validade: DateTime(2026, 8, 20),
    lote: 'LT-0512B',
    status: StatusEstoque.pasteurizando,
    doadoraNome: 'Patrícia Rocha',
  ),
  ItemEstoque(
    id: 'e03',
    tipo: TipoLeite.maduro,
    volumeMl: 310,
    validade: DateTime(2026, 8, 25),
    lote: 'LT-0510C',
    status: StatusEstoque.reservado,
    doadoraNome: 'Renata Oliveira',
  ),
  ItemEstoque(
    id: 'e04',
    tipo: TipoLeite.maduro,
    volumeMl: 260,
    validade: DateTime(2026, 8, 18),
    lote: 'LT-0509D',
    status: StatusEstoque.disponivel,
    doadoraNome: 'Carla Mendes',
  ),
  ItemEstoque(
    id: 'e05',
    tipo: TipoLeite.colostro,
    volumeMl: 60,
    validade: DateTime(2026, 8, 15),
    lote: 'LT-0508E',
    status: StatusEstoque.disponivel,
    doadoraNome: 'Beatriz Lima',
  ),
];
