import 'package:flutter/material.dart';
import '../data/coletas_mock.dart';
import '../data/doadoras_mock.dart';
import '../data/estoque_mock.dart';
import '../model/coleta.dart';
import '../model/doadora.dart';
import '../components/coleta_card.dart';
import '../components/doadora_card.dart';
import '../components/estoque_card.dart';
import 'doadora_detail_screen.dart';
import 'nova_coleta_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaAtual = 0;

  late final List<Coleta> _coletas = List.of(coletasMock);

  static const _titulos = ['Agenda', 'Estoque', 'Doadoras'];

  Future<void> _abrirDetalheDoadora(String doadoraId) async {
    final Doadora doadora = buscarDoadoraPorId(doadoraId);
    final novaColeta = await Navigator.of(context).push<Coleta>(
      MaterialPageRoute(
        builder: (_) => DoadoraDetailScreen(doadora: doadora),
      ),
    );

    if (novaColeta != null) {
      setState(() {
        _coletas.insert(0, novaColeta);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Coleta com ${novaColeta.doadoraNome} agendada para '
            '${novaColeta.hora}.',
          ),
        ),
      );
    }
  }

  Future<void> _abrirNovaColeta() async {
    final novaColeta = await Navigator.of(context).push<Coleta>(
      MaterialPageRoute(builder: (_) => const NovaColetaScreen()),
    );

    if (novaColeta != null) {
      setState(() {
        _coletas.insert(0, novaColeta);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Coleta com ${novaColeta.doadoraNome} agendada para '
            '${novaColeta.hora}.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('BLH Atibaia'),
            Text(
              _titulos[_abaAtual],
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _abaAtual,
          children: [
            _AgendaTab(coletas: _coletas, onTapColeta: _abrirDetalheDoadora),
            const _EstoqueTab(),
            _DoadorasTab(onTapDoadora: _abrirDetalheDoadora),
          ],
        ),
      ),
      floatingActionButton: _abaAtual == 0
          ? FloatingActionButton.extended(
              onPressed: _abrirNovaColeta,
              icon: const Icon(Icons.add),
              label: const Text('Nova coleta'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _abaAtual,
        onDestinationSelected: (index) => setState(() => _abaAtual = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Estoque',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt),
            label: 'Doadoras',
          ),
        ],
      ),
    );
  }
}

class _AgendaTab extends StatelessWidget {
  final List<Coleta> coletas;
  final void Function(String doadoraId) onTapColeta;

  const _AgendaTab({required this.coletas, required this.onTapColeta});

  @override
  Widget build(BuildContext context) {
    if (coletas.isEmpty) {
      return const _EstadoVazio(
        icone: Icons.event_busy_outlined,
        mensagem: 'Nenhuma coleta agendada para hoje.',
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Text(
          'Quarta-feira · 13 Mai · ${coletas.length} coletas',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        for (final coleta in coletas)
          ColetaCard(
            coleta: coleta,
            onTap: () => onTapColeta(coleta.doadoraId),
          ),
      ],
    );
  }
}

class _EstoqueTab extends StatelessWidget {
  const _EstoqueTab();

  @override
  Widget build(BuildContext context) {
    final disponiveis =
        estoqueMock.fold<int>(0, (soma, item) => soma + item.volumeMl);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Volume total em estoque',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '$disponiveis ml',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final item in estoqueMock) EstoqueCard(item: item),
      ],
    );
  }
}

class _DoadorasTab extends StatelessWidget {
  final void Function(String doadoraId) onTapDoadora;

  const _DoadorasTab({required this.onTapDoadora});

  @override
  Widget build(BuildContext context) {
    final doadoras = List.of(doadorasMock)
      ..sort((a, b) => a.score.compareTo(b.score));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(
          '${doadoras.length} nutrizes conectadas pela LARA',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        for (final doadora in doadoras)
          DoadoraCard(
            doadora: doadora,
            onTap: () => onTapDoadora(doadora.id),
          ),
      ],
    );
  }
}

class _EstadoVazio extends StatelessWidget {
  final IconData icone;
  final String mensagem;

  const _EstadoVazio({required this.icone, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
