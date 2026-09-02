import 'package:flutter/material.dart';
import '../model/doadora.dart';
import 'status_badge.dart';

class DoadoraCard extends StatelessWidget {
  final Doadora doadora;
  final VoidCallback onTap;

  const DoadoraCard({super.key, required this.doadora, required this.onTap});

  Color get _corRisco {
    switch (doadora.risco) {
      case NivelRisco.baixo:
        return Colors.green;
      case NivelRisco.medio:
        return Colors.orange;
      case NivelRisco.alto:
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
              CircleAvatar(
                radius: 24,
                backgroundColor: _corRisco.withValues(alpha: 0.15),
                child: Text(
                  doadora.nome.trim().isNotEmpty
                      ? doadora.nome.trim()[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: _corRisco,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doadora.nome,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dia ${doadora.diaJornada}/30 · ${doadora.cidade}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Score ${doadora.score}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  StatusBadge(texto: doadora.riscoLabel, cor: _corRisco),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
