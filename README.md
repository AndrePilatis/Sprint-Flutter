# Lactare - Painel do Gestor de BLH

Projeto: **Lactare**
Equipe: **LARA**
Challenge FIAP 2026 x Eurofarma - Desafio 1: Conecta BLH

## Integrantes

- Julia Sawaia - RM555438
- Maria Eduarda Oliveira - RM558970
- Guilherme Garcia - RM558102
- André Pilatis - RM55897

## Sobre o app

O Lactare conecta nutrizes recém-mães a Bancos de Leite Humano (BLH) por meio de
uma jornada no WhatsApp conduzida por um bot (LARA), do acolhimento até o
agendamento da doação de leite excedente.

Este repositório é o app mobile do gestor do BLH: a pessoa que recebe as
coletas agendadas pela LARA, controla o estoque de leite pasteurizado e
acompanha o risco de abandono das nutrizes conectadas.

## Telas

[Painel do Gestor](docs/screenshots/Painel_do_Gestor.png)

[Agenda de Coletas](docs/screenshots/Agenda_de_Coletas.png)

[Volume em Estoque](docs/screenshots/Volume_em_Estoque.png)

[Doadoras Cadastradas](docs/screenshots/Doadoras_Cadastradas.png)

[Exemplo de Doadora](docs/screenshots/Exemplo_de_Doadora.png)

[Nova Coleta](docs/screenshots/Nova_Coleta.png)

[Nova Doadora](docs/screenshots/Nova_Doadora.png)

## Vídeo de demonstração

https://youtu.be/5hfUEmnaTS8

## Funcionalidades

**Agenda**
- Visualizar as coletas do dia, com horário, tipo (domiciliar ou presencial) e status
- Agendar uma nova coleta, escolhendo doadora, tipo e horário
- Marcar uma coleta como concluída, informando o volume coletado
- Excluir uma coleta deslizando o card para o lado

**Doadoras**
- Visualizar a lista de nutrizes conectadas, ordenadas por score de engajamento
- Cadastrar uma nova doadora, com dados pessoais, do bebê e score inicial
- Abrir o perfil de uma doadora, com score, progresso da jornada e linha do tempo de eventos
- Editar os dados de uma doadora existente
- Excluir uma doadora do painel
- Registrar uma nova coleta diretamente pelo perfil da doadora

**Estoque**
- Visualizar os lotes de leite armazenados, com tipo, volume, lote, validade e status
- Volume total em estoque atualizado automaticamente sempre que uma coleta é concluída (o volume informado vira um novo lote em pasteurização)

**Score e risco**
- Score de engajamento sobe ao concluir uma coleta e cai se uma coleta da doadora for excluída
- Nível de risco (baixo, médio ou alto) recalculado automaticamente a partir do score, sem precisar de ajuste manual