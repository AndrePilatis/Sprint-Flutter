import 'package:flutter/material.dart';
import '../model/coleta.dart';
import '../model/doadora.dart';

class NovaColetaScreen extends StatefulWidget {
  final List<Doadora> doadoras;
  final Doadora? doadoraPreSelecionada;

  const NovaColetaScreen({
    super.key,
    required this.doadoras,
    this.doadoraPreSelecionada,
  });

  @override
  State<NovaColetaScreen> createState() => _NovaColetaScreenState();
}

class _NovaColetaScreenState extends State<NovaColetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _horaController = TextEditingController();

  Doadora? _doadoraSelecionada;
  TipoColeta _tipoSelecionado = TipoColeta.domiciliar;

  @override
  void initState() {
    super.initState();
    _doadoraSelecionada = widget.doadoraPreSelecionada;
  }

  @override
  void dispose() {
    _horaController.dispose();
    super.dispose();
  }

  Future<void> _selecionarHorario() async {
    final horario = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (horario != null) {
      setState(() {
        _horaController.text = horario.format(context);
      });
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate() || _doadoraSelecionada == null) {
      if (_doadoraSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione a doadora responsável.')),
        );
      }
      return;
    }

    final novaColeta = Coleta(
      id: 'c${DateTime.now().millisecondsSinceEpoch}',
      data: DateTime.now(),
      hora: _horaController.text,
      tipo: _tipoSelecionado,
      doadoraId: _doadoraSelecionada!.id,
      doadoraNome: _doadoraSelecionada!.nome,
      status: StatusColeta.agendada,
    );

    Navigator.of(context).pop(novaColeta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova coleta')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Preencha os dados para agendar uma nova coleta de leite.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<Doadora>(
                initialValue: _doadoraSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Doadora',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final doadora in widget.doadoras)
                    DropdownMenuItem(
                      value: doadora,
                      child: Text(doadora.nome),
                    ),
                ],
                onChanged: (valor) {
                  setState(() => _doadoraSelecionada = valor);
                },
                validator: (valor) =>
                    valor == null ? 'Selecione uma doadora' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TipoColeta>(
                initialValue: _tipoSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Tipo de coleta',
                  prefixIcon: Icon(Icons.category_outlined),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: TipoColeta.domiciliar,
                    child: Text('Coleta domiciliar'),
                  ),
                  DropdownMenuItem(
                    value: TipoColeta.presencial,
                    child: Text('Coleta presencial'),
                  ),
                ],
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() => _tipoSelecionado = valor);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _horaController,
                readOnly: true,
                onTap: _selecionarHorario,
                decoration: const InputDecoration(
                  labelText: 'Horário',
                  hintText: 'Toque para escolher',
                  prefixIcon: Icon(Icons.schedule_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) => (valor == null || valor.isEmpty)
                    ? 'Escolha um horário'
                    : null,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.check),
                label: const Text('Confirmar agendamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
