import 'package:flutter/material.dart';
import '../model/evento_jornada.dart';

class JornadaTimeline extends StatelessWidget {
  final List<EventoJornada> eventos;

  const JornadaTimeline({super.key, required this.eventos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(eventos.length, (index) {
        final evento = eventos[index];
        final ultimo = index == eventos.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!ultimo)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.25),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: ultimo ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dia ${evento.dia} · ${evento.titulo}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        evento.descricao,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
