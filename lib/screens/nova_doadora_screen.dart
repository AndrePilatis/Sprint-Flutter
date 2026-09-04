import 'package:flutter/material.dart';

import '../model/doadora.dart';
import '../model/evento_jornada.dart';

class NovaDoadoraScreen extends StatefulWidget {
  final Doadora? doadora;

  const NovaDoadoraScreen({super.key, this.doadora});

  @override
  State<NovaDoadoraScreen> createState() => _NovaDoadoraScreenState();
}

class _NovaDoadoraScreenState extends State<NovaDoadoraScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _bebeNomeController = TextEditingController();
  final _bebeIdadeController = TextEditingController();
  final _tipoPartoController = TextEditingController();
  final _statusController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _scoreController = TextEditingController();

  bool get _isEditMode => widget.doadora != null;

  @override
  void initState() {
    super.initState();
    final doadora = widget.doadora;
    if (doadora == null) return;

    _nomeController.text = doadora.nome;
    _idadeController.text = doadora.idade.toString();
    _cidadeController.text = doadora.cidade;
    _bebeNomeController.text = doadora.bebeNome;
    _bebeIdadeController.text = doadora.bebeIdadeDias.toString();
    _tipoPartoController.text = doadora.tipoParto;
    _statusController.text = doadora.statusAmamentacao;
    _telefoneController.text = doadora.telefone;
    _scoreController.text = doadora.score.toString();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _cidadeController.dispose();
    _bebeNomeController.dispose();
    _bebeIdadeController.dispose();
    _tipoPartoController.dispose();
    _statusController.dispose();
    _telefoneController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final doadoraAtual = widget.doadora;
    final score = int.tryParse(_scoreController.text) ?? doadoraAtual?.score ?? 50;
    final doadoraSalva = Doadora(
      id: doadoraAtual?.id ?? 'd${DateTime.now().millisecondsSinceEpoch}',
      nome: _nomeController.text.trim(),
      idade: int.tryParse(_idadeController.text) ?? doadoraAtual?.idade ?? 0,
      cidade: _cidadeController.text.trim(),
      bebeNome: _bebeNomeController.text.trim(),
      bebeIdadeDias: int.tryParse(_bebeIdadeController.text) ??
          doadoraAtual?.bebeIdadeDias ??
          0,
      tipoParto: _tipoPartoController.text.trim().isNotEmpty
          ? _tipoPartoController.text.trim()
          : doadoraAtual?.tipoParto ?? 'Normal',
      risco: riscoParaScore(score),
      statusAmamentacao: _statusController.text.trim().isNotEmpty
          ? _statusController.text.trim()
          : doadoraAtual?.statusAmamentacao ?? 'Ativa no programa',
      score: score,
      diaJornada: doadoraAtual?.diaJornada ?? 1,
      telefone: _telefoneController.text.trim(),
      jornada: doadoraAtual?.jornada ??
          const [
            EventoJornada(
              dia: 1,
              titulo: 'Cadastro no programa',
              descricao: 'Nova doadora cadastrada no painel do BLH.',
            ),
          ],
    );

    Navigator.of(context).pop(doadoraSalva);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Editar doadora' : 'Nova doadora'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                _isEditMode
                  ? 'Atualize os dados da nutriz e mantenha o acompanhamento em dia.'
                  : 'Cadastre os dados da nutriz para ativar o acompanhamento no painel.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    (valor == null || valor.trim().isEmpty)
                        ? 'Informe o nome da doadora'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  prefixIcon: Icon(Icons.cake_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    (valor == null || valor.trim().isEmpty)
                        ? 'Informe a idade'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    (valor == null || valor.trim().isEmpty)
                        ? 'Informe a cidade'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bebeNomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do bebê',
                  prefixIcon: Icon(Icons.baby_changing_station_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    (valor == null || valor.trim().isEmpty)
                        ? 'Informe o nome do bebê'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bebeIdadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade do bebê (dias)',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    (valor == null || valor.trim().isEmpty)
                        ? 'Informe a idade do bebê'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tipoPartoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de parto',
                  hintText: 'Ex.: Cesárea ou Normal',
                  prefixIcon: Icon(Icons.medical_services_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status da amamentação',
                  prefixIcon: Icon(Icons.monitor_heart_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Score de engajamento (0 a 100)',
                  hintText: 'Ex.: 50',
                  prefixIcon: Icon(Icons.speed_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) =>
                    (valor == null || valor.trim().isEmpty)
                        ? 'Informe o telefone de contato'
                        : null,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.check),
                label: Text(_isEditMode ? 'Salvar alterações' : 'Salvar doadora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}