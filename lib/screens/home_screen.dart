import 'package:flutter/material.dart';
import '../data/coletas_mock.dart';
import '../data/doadoras_mock.dart';
import '../data/estoque_mock.dart';
import '../model/coleta.dart';
import '../model/doadora.dart';
import '../model/item_estoque.dart';
import '../components/coleta_card.dart';
import '../components/doadora_card.dart';
import '../components/estoque_card.dart';
import 'doadora_detail_screen.dart';
import 'nova_coleta_screen.dart';
import 'nova_doadora_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaAtual = 0;

  late final List<Coleta> _coletas = List.of(coletasMock);
  late final List<Doadora> _doadoras = List.of(doadorasMock);
  late final List<ItemEstoque> _estoque = List.of(estoqueMock);

  static const _titulos = ['Agenda', 'Estoque', 'Doadoras'];

  void _excluirColeta(String coletaId) {
    final coleta = _coletas.firstWhere((c) => c.id == coletaId);
    setState(() {
      _coletas.removeWhere((c) => c.id == coletaId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Coleta de ${coleta.doadoraNome} removida.')),
    );
  }

  Future<void> _concluirColeta(String coletaId) async {
    final coleta = _coletas.firstWhere((c) => c.id == coletaId);
    final volumeController = TextEditingController();

    final volumeInformado = await showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Concluir coleta'),
        content: TextField(
          controller: volumeController,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Volume coletado (ml)',
            hintText: 'Ex.: 250',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final volume = int.tryParse(volumeController.text);
              Navigator.of(dialogContext).pop(volume);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (volumeInformado == null || volumeInformado <= 0) return;

    setState(() {
      final index = _coletas.indexWhere((c) => c.id == coletaId);
      if (index != -1) {
        _coletas[index] = _coletas[index].copyWith(
          status: StatusColeta.concluida,
          volumeMl: volumeInformado,
        );
      }

      _estoque.insert(
        0,
        ItemEstoque(
          id: 'e${DateTime.now().millisecondsSinceEpoch}',
          tipo: TipoLeite.maduro,
          volumeMl: volumeInformado,
          validade: DateTime.now().add(const Duration(days: 180)),
          lote:
              'LT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
          status: StatusEstoque.pasteurizando,
          doadoraNome: coleta.doadoraNome,
        ),
      );
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Coleta concluída: $volumeInformado ml de ${coleta.doadoraNome} adicionados ao estoque.',
        ),
      ),
    );
  }

  void _excluirDoadora(String doadoraId) {
    final doadora = _doadoras.firstWhere((d) => d.id == doadoraId);
    setState(() {
      _doadoras.removeWhere((d) => d.id == doadoraId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Doadora ${doadora.nome} removida.')),
    );
  }

  Future<void> _abrirNovaDoadora() async {
    final novaDoadora = await Navigator.of(context).push<Doadora>(
      MaterialPageRoute(builder: (_) => const NovaDoadoraScreen()),
    );

    if (novaDoadora != null) {
      setState(() {
        _doadoras.insert(0, novaDoadora);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Doadora ${novaDoadora.nome} cadastrada com sucesso.')),
      );
    }
  }

  Future<void> _abrirDetalheDoadora(String doadoraId) async {
    final Doadora doadora = buscarDoadoraPorId(doadoraId);
    final novaColeta = await Navigator.of(context).push<Coleta>(
      MaterialPageRoute(
        builder: (_) => DoadoraDetailScreen(
          doadora: doadora,
          doadoras: _doadoras,
          onDoadoraAtualizada: (doadoraAtualizada) {
            setState(() {
              final index = _doadoras
                  .indexWhere((item) => item.id == doadoraAtualizada.id);
              if (index != -1) {
                _doadoras[index] = doadoraAtualizada;
              }
            });
          },
          onExcluir: () {
            _excluirDoadora(doadora.id);
          },
        ),
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
      MaterialPageRoute(builder: (_) => NovaColetaScreen(doadoras: _doadoras)),
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
            const Text('BLH'),
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
            _AgendaTab(
              coletas: _coletas,
              onTapColeta: _abrirDetalheDoadora,
              onExcluirColeta: _excluirColeta,
              onConcluirColeta: _concluirColeta,
            ),
            _EstoqueTab(itens: _estoque),
            _DoadorasTab(
              doadoras: _doadoras,
              onTapDoadora: _abrirDetalheDoadora,
              onNovaDoadora: _abrirNovaDoadora,
            ),
          ],
        ),
      ),
      floatingActionButton: _abaAtual == 0
          ? FloatingActionButton.extended(
              onPressed: _abrirNovaColeta,
              icon: const Icon(Icons.add),
              label: const Text('Nova coleta'),
            )
          : _abaAtual == 2
              ? FloatingActionButton.extended(
                  onPressed: _abrirNovaDoadora,
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Nova doadora'),
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
  final void Function(String coletaId) onExcluirColeta;
  final void Function(String coletaId) onConcluirColeta;

  const _AgendaTab({
    required this.coletas,
    required this.onTapColeta,
    required this.onExcluirColeta,
    required this.onConcluirColeta,
  });

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
          'Deslize uma coleta para a esquerda pra excluir.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        for (final coleta in coletas)
          ColetaCard(
            coleta: coleta,
            onTap: () => onTapColeta(coleta.doadoraId),
            onExcluir: () => onExcluirColeta(coleta.id),
            onConcluir: () => onConcluirColeta(coleta.id),
          ),
      ],
    );
  }
}

class _EstoqueTab extends StatelessWidget {
  final List<ItemEstoque> itens;

  const _EstoqueTab({required this.itens});

  @override
  Widget build(BuildContext context) {
    final volumeTotal = itens.fold<int>(0, (soma, item) => soma + item.volumeMl);
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
                  '$volumeTotal ml',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final item in itens) EstoqueCard(item: item),
      ],
    );
  }
}

class _DoadorasTab extends StatelessWidget {
  final List<Doadora> doadoras;
  final void Function(String doadoraId) onTapDoadora;
  final VoidCallback onNovaDoadora;

  const _DoadorasTab({
    required this.doadoras,
    required this.onTapDoadora,
    required this.onNovaDoadora,
  });

  @override
  Widget build(BuildContext context) {
    final listaOrdenada = List.of(doadoras)
      ..sort((a, b) => a.score.compareTo(b.score));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${listaOrdenada.length} nutrizes conectadas pela LARA',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton.icon(
              onPressed: onNovaDoadora,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: const Text('Nova doadora'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        for (final doadora in listaOrdenada)
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
