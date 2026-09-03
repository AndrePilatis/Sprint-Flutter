import 'package:flutter/material.dart';
import '../model/coleta.dart';
import 'status_badge.dart';

class ColetaCard extends StatelessWidget {
  final Coleta coleta;
  final VoidCallback onTap;
  final VoidCallback onExcluir;

  const ColetaCard({
    super.key,
    required this.coleta,
    required this.onTap,
    required this.onExcluir,
  });

  Color get _corStatus {
    switch (coleta.status) {
      case StatusColeta.agendada:
        return Colors.blue;
      case StatusColeta.concluida:
        return Colors.green;
      case StatusColeta.cancelada:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(coleta.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text('Excluir coleta'),
                content: Text(
                  'Deseja remover a coleta de ${coleta.doadoraNome} às ${coleta.hora}?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    child: const Text('Excluir'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => onExcluir(),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      coleta.hora,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      coleta.tipo.name == 'domiciliar'
                          ? Icons.home_outlined
                          : Icons.local_hospital_outlined,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coleta.doadoraNome,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coleta.tipoLabel,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                StatusBadge(texto: coleta.statusLabel, cor: _corStatus),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
