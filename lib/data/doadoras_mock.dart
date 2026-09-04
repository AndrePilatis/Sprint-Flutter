import '../model/doadora.dart';
import '../model/evento_jornada.dart';

final List<Doadora> doadorasMock = [
  const Doadora(
    id: 'd01',
    nome: 'Mariana Silva',
    idade: 32,
    cidade: 'Atibaia - SP',
    bebeNome: 'Nicole',
    bebeIdadeDias: 14,
    tipoParto: 'Cesárea (Maternidade SP)',
    risco: NivelRisco.medio,
    statusAmamentacao: 'Pega ok · produção boa',
    score: 47,
    diaJornada: 12,
    telefone: '(11) 99876-5432',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Conversa inicial com a LARA sobre a chegada da Nicole.'),
      EventoJornada(
          dia: 5,
          titulo: 'Engajamento',
          descricao: 'Trocou 5 mensagens sobre pega e sono.'),
      EventoJornada(
          dia: 10,
          titulo: 'Convite à doação',
          descricao: 'Aceitou o convite após ouvir o áudio da Ana.'),
      EventoJornada(
          dia: 12,
          titulo: 'Cancelamento',
          descricao: 'Cancelou o agendamento: "tá complicado, sem tempo".'),
    ],
  ),
  const Doadora(
    id: 'd02',
    nome: 'Camila Ramos',
    idade: 27,
    cidade: 'São Paulo - SP',
    bebeNome: 'Théo',
    bebeIdadeDias: 21,
    tipoParto: 'Normal',
    risco: NivelRisco.alto,
    statusAmamentacao: 'Demonstrou hesitação',
    score: 22,
    diaJornada: 9,
    telefone: '(11) 98211-4407',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Primeiro contato realizado com sucesso.'),
      EventoJornada(
          dia: 6,
          titulo: 'Sem resposta',
          descricao: 'Não respondeu às últimas 2 mensagens da LARA.'),
      EventoJornada(
          dia: 9,
          titulo: 'Hesitação',
          descricao: 'Demonstrou insegurança sobre doar leite excedente.'),
    ],
  ),
  const Doadora(
    id: 'd03',
    nome: 'Beatriz Lima',
    idade: 24,
    cidade: 'São Paulo - SP',
    bebeNome: 'Miguel',
    bebeIdadeDias: 40,
    tipoParto: 'Cesárea',
    risco: NivelRisco.alto,
    statusAmamentacao: 'Bebê em UTI neonatal',
    score: 25,
    diaJornada: 15,
    telefone: '(11) 97650-2231',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Relatou rotina intensa entre casa e hospital.'),
      EventoJornada(
          dia: 8,
          titulo: 'Pausa solicitada',
          descricao: 'Pediu para pausar mensagens: bebê em UTI.'),
      EventoJornada(
          dia: 15,
          titulo: 'Reengajamento',
          descricao: 'LARA retomou contato com tom mais leve.'),
    ],
  ),
  const Doadora(
    id: 'd04',
    nome: 'Letícia Prado',
    idade: 30,
    cidade: 'São Paulo - SP',
    bebeNome: 'Sofia',
    bebeIdadeDias: 18,
    tipoParto: 'Normal',
    risco: NivelRisco.alto,
    statusAmamentacao: 'Respostas curtas, tom triste',
    score: 28,
    diaJornada: 11,
    telefone: '(11) 96530-8871',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Conversa inicial tranquila.'),
      EventoJornada(
          dia: 7,
          titulo: 'Sinal de alerta',
          descricao: 'Respostas curtas e tom emocional mais baixo.'),
      EventoJornada(
          dia: 11,
          titulo: 'Encaminhamento sugerido',
          descricao: 'LARA sugeriu transferir para atendimento humano.'),
    ],
  ),
  const Doadora(
    id: 'd05',
    nome: 'Maria Eduarda Oliveira',
    idade: 35,
    cidade: 'Jundiaí - SP',
    bebeNome: 'Yuri Alberto',
    bebeIdadeDias: 25,
    tipoParto: 'Cesárea',
    risco: NivelRisco.medio,
    statusAmamentacao: 'Histórico de abandono anterior',
    score: 31,
    diaJornada: 14,
    telefone: '(11) 95412-9903',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Segunda participação no programa Lactare.'),
      EventoJornada(
          dia: 10,
          titulo: 'Convite à doação',
          descricao: 'Recebeu convite, ainda sem resposta definitiva.'),
      EventoJornada(
          dia: 14,
          titulo: '1ª coleta agendada',
          descricao: 'Agendou primeira coleta presencial no BLH.'),
    ],
  ),
  const Doadora(
    id: 'd06',
    nome: 'Carla Mendes',
    idade: 29,
    cidade: 'São Paulo - SP',
    bebeNome: 'Helena',
    bebeIdadeDias: 33,
    tipoParto: 'Normal',
    risco: NivelRisco.baixo,
    statusAmamentacao: 'Produção estável, doadora ativa',
    score: 78,
    diaJornada: 20,
    telefone: '(11) 94123-7765',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Já conhecia o BLH por indicação de amiga.'),
      EventoJornada(
          dia: 8,
          titulo: 'Convertida',
          descricao: 'Aceitou doar e agendou coleta presencial.'),
      EventoJornada(
          dia: 20,
          titulo: 'Doadora frequente',
          descricao: 'Já realizou 3 coletas presenciais no BLH.'),
    ],
  ),
  const Doadora(
    id: 'd07',
    nome: 'Patrícia Rocha',
    idade: 26,
    cidade: 'São Paulo - SP',
    bebeNome: 'Enzo',
    bebeIdadeDias: 10,
    tipoParto: 'Cesárea',
    risco: NivelRisco.baixo,
    statusAmamentacao: 'Pega ok · produção em ajuste',
    score: 66,
    diaJornada: 8,
    telefone: '(11) 93087-1120',
    jornada: [
      EventoJornada(
          dia: 2,
          titulo: 'Acolhimento',
          descricao: 'Boa receptividade ao primeiro contato.'),
      EventoJornada(
          dia: 5,
          titulo: 'Educação personalizada',
          descricao: 'Recebeu conteúdo sobre excesso de produção.'),
      EventoJornada(
          dia: 8,
          titulo: 'Primeira coleta',
          descricao: 'Agendou coleta domiciliar pela primeira vez.'),
    ],
  ),
];

Doadora buscarDoadoraPorId(String id) {
  return doadorasMock.firstWhere((d) => d.id == id);
}
