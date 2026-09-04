import 'evento_jornada.dart';

enum NivelRisco { baixo, medio, alto }

NivelRisco riscoParaScore(int score) {
  if (score >= 60) return NivelRisco.baixo;
  if (score >= 30) return NivelRisco.medio;
  return NivelRisco.alto;
}

class Doadora {
  final String id;
  final String nome;
  final int idade;
  final String cidade;
  final String bebeNome;
  final int bebeIdadeDias;
  final String tipoParto;
  final NivelRisco risco;
  final String statusAmamentacao;
  final int score;
  final int diaJornada;
  final String telefone;
  final List<EventoJornada> jornada;

  const Doadora({
    required this.id,
    required this.nome,
    required this.idade,
    required this.cidade,
    required this.bebeNome,
    required this.bebeIdadeDias,
    required this.tipoParto,
    required this.risco,
    required this.statusAmamentacao,
    required this.score,
    required this.diaJornada,
    required this.telefone,
    required this.jornada,
  });

  String get riscoLabel {
    switch (risco) {
      case NivelRisco.baixo:
        return 'Baixo risco';
      case NivelRisco.medio:
        return 'Risco médio';
      case NivelRisco.alto:
        return 'Risco de abandono';
    }
  }

  double get progressoJornada => (diaJornada / 30).clamp(0, 1).toDouble();

  Doadora copyWith({int? score, NivelRisco? risco}) {
    return Doadora(
      id: id,
      nome: nome,
      idade: idade,
      cidade: cidade,
      bebeNome: bebeNome,
      bebeIdadeDias: bebeIdadeDias,
      tipoParto: tipoParto,
      risco: risco ?? this.risco,
      statusAmamentacao: statusAmamentacao,
      score: score ?? this.score,
      diaJornada: diaJornada,
      telefone: telefone,
      jornada: jornada,
    );
  }
}
