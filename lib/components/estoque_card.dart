import 'package:flutter/material.dart';
import '../model/item_estoque.dart';
import 'status_badge.dart';

class EstoqueCard extends StatelessWidget {
  final ItemEstoque item;

  const EstoqueCard({super.key, required this.item});

  Color get _corStatus {
    switch (item.status) {
      case StatusEstoque.disponivel:
        return Colors.green;
      case StatusEstoque.pasteurizando:
        return Colors.orange;
      case StatusEstoque.reservado:
        return Colors.blueGrey;
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.water_drop_outlined, color: _corStatus, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.tipoLabel} · ${item.volumeMl} ml',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lote ${item.lote} · Doadora: ${item.doadoraNome}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Validade: ${_formatarData(item.validade)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            StatusBadge(texto: item.statusLabel, cor: _corStatus),
          ],
        ),
      ),
    );
  }
}
