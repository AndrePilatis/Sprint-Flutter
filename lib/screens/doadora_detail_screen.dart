import 'package:flutter/material.dart';
import '../model/coleta.dart';
import '../model/doadora.dart';
import '../components/jornada_timeline.dart';
import '../components/status_badge.dart';
import 'nova_coleta_screen.dart';

class DoadoraDetailScreen extends StatelessWidget {
  final Doadora doadora;

  const DoadoraDetailScreen({super.key, required this.doadora});

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

  Widget _infoLinha(BuildContext context, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 2),
          Text(valor, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doadora.nome)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Score de engajamento',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        StatusBadge(texto: doadora.riscoLabel, cor: _corRisco),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${doadora.score}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _corRisco,
                              ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: doadora.progressoJornada,
                        minHeight: 8,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Dia ${doadora.diaJornada} de 30 na jornada Lactare',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Perfil da nutriz',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoLinha(context, 'Idade / Cidade',
                        '${doadora.idade} anos · ${doadora.cidade}'),
                    _infoLinha(context, 'Bebê',
                        '${doadora.bebeNome} · ${doadora.bebeIdadeDias} dias'),
                    _infoLinha(context, 'Parto', doadora.tipoParto),
                    _infoLinha(
                        context, 'Amamentação', doadora.statusAmamentacao),
                    _infoLinha(context, 'Telefone', doadora.telefone),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Resumo da jornada',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: JornadaTimeline(eventos: doadora.jornada),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                final novaColeta = await Navigator.of(context).push<Coleta>(
                  MaterialPageRoute(
                    builder: (_) =>
                        NovaColetaScreen(doadoraPreSelecionada: doadora),
                  ),
                );
                if (novaColeta != null && context.mounted) {
                  Navigator.of(context).pop(novaColeta);
                }
              },
              icon: const Icon(Icons.event_available_outlined),
              label: const Text('Registrar nova coleta'),
            ),
          ],
        ),
      ),
    );
  }
}
