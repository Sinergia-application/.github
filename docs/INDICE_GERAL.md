# Sinergia Fisioterapia — Portal Central de Documentação e Governança

Este repositório centraliza a documentação arquitetural, o mapeamento dos fluxos de negócio, as especificações clínicas e as diretrizes de engenharia de software da organização **Sinergia Fisioterapia**. Ele atua como fonte única de verdade transversal para desenvolvedores, equipe clínica e agentes de inteligência artificial que operam nos repositórios da plataforma.

---

## 1. Repositórios Ativos do Ecossistema

| Repositório | Tecnologias Principais | Responsabilidade |
|---|---|---|
| **`sinergia-web`** | Angular, TypeScript, Tailwind CSS, MediaPipe Pose, Cloudflare Workers / Pages | Aplicação web progressiva (PWA) utilizada por pacientes, fisioterapeutas, recepcionistas e administradores. Executa a inferência de pose corporal e o motor biomecânico em tempo real ou offline no navegador. |
| **`sinergia-api`** | Java 21, Spring Boot 3, Spring Security (JWT), JPA/Hibernate, MariaDB, Flyway | API REST central. Gerencia autenticação RBAC, multi-tenancy de clínicas, prescrição de roteiros, armazenamento de mídia, reprocessamento de landmarks, integração com Google Gemini e ElevenLabs TTS, agendamentos, notificações e auditoria. |
| **`.github`** | Markdown, Mermaid, GitHub Templates | Hub central de documentação de arquitetura, fluxos do sistema, especificações fisioterapêuticas, conformidade LGPD e padrões de contribuição e deploy. |

---

## 2. Ambientes Oficiais

| Ambiente | Branch de Origem | Frontend Web (PWA) | Backend API REST | Health Check da API |
|---|---|---|---|---|
| **Homologação** | `develop` | `https://app-hml.sinergiahealth.com.br` | `https://api-hml-sinergia.yegear.dev` | `https://api-hml-sinergia.yegear.dev/api/v1/health` |
| **Produção** | `master` | `https://app.sinergiahealth.com.br` | `https://api-sinergia.yegear.dev` | `https://api-sinergia.yegear.dev/api/v1/health` |

---

## 3. Mapa Geral da Documentação

Toda a documentação está organizada por domínio dentro do diretório [`docs/`](docs/README.md):

### Guias de Engenharia e Contribuição
- [Diretrizes Organizacionais para Agentes de IA (`AGENTS.md`)](AGENTS.md) — Regras obrigatórias de GitFlow, nomenclatura de branches, Conventional Commits e validação local.
- [Guia Oficial de Contribuição e Deploy da Equipe](docs/GUIA_DE_CONTRIBUICAO_E_DEPLOY_EQUIPE.md) — Procedimento completo de desenvolvimento diário, Pull Requests, homologação e promoção para produção.

### 01. Arquitetura e Infraestrutura (`docs/01-arquitetura-e-infra/`)
- [Visão Geral do Sistema e Arquitetura Técnica](docs/01-arquitetura-e-infra/visao-geral-e-arquitetura.md) — Topologia dos componentes, integrações externas, modelo de domínio (DER) e isolamento de ambientes.
- [CI/CD, Ambientes, Governança e Monitoramento](docs/01-arquitetura-e-infra/ci-cd-ambientes-e-monitoramento.md) — Pipelines de entrega contínua no GitHub Actions e Cloudflare, containers Docker e proxy Nginx.
- [Motor de Análise de Movimento e Escalas Clínicas](docs/01-arquitetura-e-infra/motor-analise-movimento-e-escalas.md) — Arquitetura dos motores de pose, desacoplamento de HUDs e estratégias de avaliação biomecânica.

### 02. Fluxos do Sistema e Regras de Negócio (`docs/02-fluxos-do-sistema/`)
- [Autenticação, Perfis de Acesso e Onboarding de Usuários](docs/02-fluxos-do-sistema/autenticacao-perfis-e-onboarding.md) — Controle de acesso RBAC (`ADMIN_SISTEMA`, `PROFISSIONAL_SAUDE`, `RECEPCIONISTA`, `PACIENTE`), convites, código público (`@codigo`) e fluxo de primeiro acesso.
- [Gestão Multi-tenant de Clínicas, Equipe e Auditoria](docs/02-fluxos-do-sistema/gestao-clinicas-equipe-e-auditoria.md) — Administração de empresas, vínculo de profissionais e recepcionistas, painel gerencial da clínica e trilha de auditoria (`AuditLog`).
- [Catálogo de Exercícios, Instâncias Personalizadas e Síntese de Voz (TTS)](docs/02-fluxos-do-sistema/catalogo-exercicios-instancias-e-tts.md) — Estrutura dos seeds oficiais, validação de regras JSON, visibilidade por clínica, áudio ElevenLabs por flag de erro e instâncias customizadas por fisioterapeuta.
- [Prescrição de Roteiros, Execução de Sessão e Processamento de Análise](docs/02-fluxos-do-sistema/roteiros-sessao-e-processamento-analise.md) — Ciclo completo da prescrição à captura com câmera, qualidade de captura, upload resiliente, resumos via Gemini, materialização e reprocessamento de landmarks.
- [Agenda Clínica Compartilhada e Mensageria Contextualizada](docs/02-fluxos-do-sistema/agenda-clinica-e-mensageria.md) — Agendamentos presenciais e teleconsultas, operação pela recepção e chat interno com cartões de referência para sessões e exercícios.
- [Aderência, Retenção, Notificações Automáticas e Exportação de Relatórios](docs/02-fluxos-do-sistema/aderencia-retencao-notificacoes-e-relatorios.md) — Cálculo de adesão de 14 dias, detecção de alertas clínicos, régua idempotente de lembretes (In-App, Web Push VAPID e e-mail) e exportação em PDF e CSV.

### 03. Especificações Clínicas e Biomecânica (`docs/03-clinico-e-biomecanica/`)
- [Plano de Implementação Técnica — Reuniões Clínicas (Sprints 1 a 4)](docs/03-clinico-e-biomecanica/plano-implementacao-reunioes-clinicas.md) — Especificação detalhada de calibração por repetições, política de bips sonoros, sugestões de intervenção clínica, questionário do acompanhante, cuidadores, exercícios manuais e anamnese.
- [Análise Técnica e Biomecânica da Escala de Equilíbrio de Berg](docs/03-clinico-e-biomecanica/analise-escala-de-berg.md) — Mapeamento dos itens da Escala de Berg e viabilidade de automação por visão computacional.
- [Especificação do Exercício Berg 03 — Permanecer Sentado sem Apoio](docs/03-clinico-e-biomecanica/especificacao-berg-03-sentado.md) — Regras angulares, calibração postural e critérios de avaliação do item 3 da Escala de Berg.
- [Referência Oficial — Escala de Equilíbrio de Berg (PDF)](docs/03-clinico-e-biomecanica/referencias/escala-de-equilibrio-de-berg.pdf) — Documento clínico de referência.

### 04. Segurança da Informação e LGPD (`docs/04-seguranca-e-lgpd/`)
- [Conformidade LGPD, Consentimento, Retenção de Mídia e Menores](docs/04-seguranca-e-lgpd/lgpd-consentimento-e-menores.md) — Finalidades de consentimento, telemetria opcional de câmera, expurgo automático de vídeos em 15 dias e diretrizes jurídicas.

### 05. Documentos Institucionais, Fomento e Histórico (`docs/05-institucional-e-historico/`)
- [Apresentação Inicial do Projeto Sinergia](docs/05-institucional-e-historico/apresentacao-inicial-projeto.md)
- [Documento de Fomento — Programa Centelha (Março/2026)](docs/05-institucional-e-historico/fomento-centelha-2026.md)
- [Relatório de Progresso Técnico (Abril/2026)](docs/05-institucional-e-historico/relatorio-progresso-2026-04.md)
- [Histórico de Evolução das Branches do Motor Realtime](docs/05-institucional-e-historico/historico-branches-realtime.md)
- [Artigo Acadêmico do Projeto](docs/05-institucional-e-historico/artigo-academico/artigo_projeto_com_imagens.md)
