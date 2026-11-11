# Índice da Documentação Técnica e Clínica — Sinergia

Este diretório concentra toda a documentação oficial da plataforma Sinergia, estruturada em cinco categorias temáticas além do guia operacional de engenharia.

---

## Guia Operacional da Equipe

- **[Guia Oficial de Contribuição e Deploy da Equipe](GUIA_DE_CONTRIBUICAO_E_DEPLOY_EQUIPE.md)**  
  Fluxo GitFlow obrigatório (`develop` e `master`), padrão de nomenclatura de branches e commits, validação local de testes e procedimento de promoção para Homologação e Produção.

---

## 01. Arquitetura e Infraestrutura (`01-arquitetura-e-infra/`)

Documentação da topologia técnica, motores de visão computacional e infraestrutura de deploy contínuo:

1. **[Visão Geral do Sistema e Arquitetura Técnica](01-arquitetura-e-infra/visao-geral-e-arquitetura.md)**  
   Arquitetura integrada entre `sinergia-web` e `sinergia-api`, diagrama de contexto, modelo de dados relacional (MariaDB) e isolamento entre Homologação e Produção.
2. **[CI/CD, Ambientes, Governança e Monitoramento](01-arquitetura-e-infra/ci-cd-ambientes-e-monitoramento.md)**  
   Especificação das pipelines do GitHub Actions e Cloudflare, containers Docker, configuração de Nginx/SSL e governança de releases.
3. **[Motor de Análise de Movimento e Escalas Clínicas](01-arquitetura-e-infra/motor-analise-movimento-e-escalas.md)**  
   Arquitetura dos motores de avaliação biomecânica (`RepetitionEngine`, `StaticPostureEngine`, `DisplacementReachEngine`) e componentes de HUD polimórficos.

---

## 02. Fluxos do Sistema e Regras de Negócio (`02-fluxos-do-sistema/`)

Documentação ponta a ponta (Frontend Angular + Backend Spring Boot) dos fluxos operacionais implementados na plataforma:

1. **[Autenticação, Perfis de Acesso e Onboarding de Usuários](02-fluxos-do-sistema/autenticacao-perfis-e-onboarding.md)**  
   Papéis de usuário (`ADMIN_SISTEMA`, `PROFISSIONAL_SAUDE`, `RECEPCIONISTA`, `PACIENTE`), pré-cadastro, ativação por código de e-mail, convites, vínculo por código público e recuperação de senha.
2. **[Gestão Multi-tenant de Clínicas, Equipe e Auditoria](02-fluxos-do-sistema/gestao-clinicas-equipe-e-auditoria.md)**  
   Ciclo de vida de empresas (clínicas), atuação do profissional gestor, cadastro de recepcionistas, parametrização de alertas por clínica e trilha de auditoria (`AuditLog`).
3. **[Catálogo de Exercícios, Instâncias Personalizadas e Síntese de Voz (TTS)](02-fluxos-do-sistema/catalogo-exercicios-instancias-e-tts.md)**  
   Estrutura dos seeds JSON, validadores por modalidade de exercício, visibilidade por clínica, geração de áudios via ElevenLabs e personalização de regras por fisioterapeuta (`ExercicioInstancia`).
4. **[Prescrição de Roteiros, Execução de Sessão e Processamento de Análise](02-fluxos-do-sistema/roteiros-sessao-e-processamento-analise.md)**  
   Prescrição de roteiros por dias da semana, avaliação de qualidade de captura, execução em tempo real ou offline, pós-processamento com Google Gemini, cache materializado e reprocessamento determinístico de landmarks.
5. **[Agenda Clínica Compartilhada e Mensageria Contextualizada](02-fluxos-do-sistema/agenda-clinica-e-mensageria.md)**  
   Gestão de consultas presenciais e online entre profissional, recepcionista e paciente, lembretes de agenda e chat interno com cartões de referência clínica.
6. **[Aderência, Retenção, Notificações Automáticas e Exportação de Relatórios](02-fluxos-do-sistema/aderencia-retencao-notificacoes-e-relatorios.md)**  
   Cálculo da taxa de adesão em janela de 14 dias, alertas clínicos automáticos (queda de pontuação e erro recorrente), notificações In-App / Web Push (VAPID) / e-mail e geração de relatórios em PDF e CSV.

---

## 03. Especificações Clínicas e Biomecânica (`03-clinico-e-biomecanica/`)

Planos de evolução clínica originados nas reuniões com fisioterapeutas consultores e especificações funcionais de testes padronizados:

1. **[Plano de Implementação Técnica — Demandas Clínicas e Produto (Sprints 1 a 4)](03-clinico-e-biomecanica/plano-implementacao-reunioes-clinicas.md)**  
   Especificação detalhada de banco de dados (migrations `V40` a `V43`), backend e frontend para calibração de repetições, política de bips, sugestões de intervenção, questionário do acompanhante, cuidadores, exercícios manuais e anamnese com comparativo Pré/Pós.
2. **[Análise Técnica e Biomecânica da Escala de Equilíbrio de Berg](03-clinico-e-biomecanica/analise-escala-de-berg.md)**  
   Categorização e parâmetros técnicos dos 14 exercícios da Escala de Berg.
3. **[Especificação do Exercício Berg 03 — Permanecer Sentado sem Apoio](03-clinico-e-biomecanica/especificacao-berg-03-sentado.md)**  
   Detalhamento de regras e estados para avaliação da postura sentada isométrica.
4. **[Documento de Referência — Escala de Equilíbrio de Berg (PDF)](03-clinico-e-biomecanica/referencias/escala-de-equilibrio-de-berg.pdf)**

---

## 04. Segurança da Informação e LGPD (`04-seguranca-e-lgpd/`)

1. **[Conformidade LGPD, Consentimento, Retenção de Mídia e Menores](04-seguranca-e-lgpd/lgpd-consentimento-e-menores.md)**  
   Arquitetura de consentimentos obrigatórios e opcionais, retenção de vídeos por 15 dias, telemetria de câmera e diretrizes jurídicas de proteção de dados sensíveis.

---

## 05. Documentos Institucionais, Fomento e Histórico (`05-institucional-e-historico/`)

1. **[Apresentação Inicial do Projeto Sinergia](05-institucional-e-historico/apresentacao-inicial-projeto.md)**
2. **[Documento de Fomento — Programa Centelha (Março/2026)](05-institucional-e-historico/fomento-centelha-2026.md)**
3. **[Relatório de Progresso Técnico (Abril/2026)](05-institucional-e-historico/relatorio-progresso-2026-04.md)**
4. **[Histórico de Evolução das Branches do Motor Realtime](05-institucional-e-historico/historico-branches-realtime.md)**
5. **[Artigo Acadêmico do Projeto](05-institucional-e-historico/artigo-academico/artigo_projeto_com_imagens.md)**
