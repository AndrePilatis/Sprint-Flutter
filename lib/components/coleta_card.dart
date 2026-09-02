import 'package:flutter/material.dart';
import '../model/coleta.dart';
import 'status_badge.dart';

class ColetaCard extends StatelessWidget {
  final Coleta coleta;
  final VoidCallback onTap;

  const ColetaCard({super.key, required this.coleta, required this.onTap});

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
    return Card(
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
    );
  }
}
