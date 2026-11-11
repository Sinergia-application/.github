# Changelog — Sinergia Documentação e Governança (`.github`)

Todas as alterações notáveis na documentação arquitetural, fluxos do sistema, especificações clínicas e diretrizes de engenharia são documentadas neste arquivo.
O formato é baseado no [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e este repositório segue o [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [1.0.0] - 2026-11-11

### Adicionado
- **Portal Institucional e Vitrine da Organização (`README.md` e `profile/README.md`)**:
  - Apresentação visual da plataforma Sinergia com identidade gráfica oficial, demonstração da interface de captura biomecânica em tempo real, mapeamento anatômico e atalhos diretos para ambientes e documentações.
  - Preservação do índice técnico completo em `docs/README.md` e `docs/INDICE_GERAL.md`, e do documento de logística inicial em `docs/05-institucional-e-historico/planejamento-logistica-inicial.md`.
- **Automação de Releases de Documentação (`.github/workflows/release-docs.yml`)**:
  - Workflow acionado por tags SemVer (`v*.*.*`) que extrai automaticamente as notas da versão a partir do `CHANGELOG.md` e publica a GitHub Release oficial, alinhado ao padrão de `sinergia-api` e `sinergia-web`.
- **Documentação Ponta a Ponta dos Fluxos do Sistema (`docs/02-fluxos-do-sistema/`)**:
  - `autenticacao-perfis-e-onboarding.md`: controle de acesso RBAC (`ADMIN_SISTEMA`, `PROFISSIONAL_SAUDE`, `RECEPCIONISTA`, `PACIENTE`), pré-cadastro, ativação com código por e-mail (SHA-256), convites e vínculo por código público.
  - `gestao-clinicas-equipe-e-auditoria.md`: modelo multi-tenant de empresas/clínicas, gestor da clínica, recepcionistas, parametrizações de alertas e trilha de auditoria (`AuditLog`).
  - `catalogo-exercicios-instancias-e-tts.md`: seeds do catálogo, validadores de regras JSON por modalidade, visibilidade por clínica, geração de áudios via ElevenLabs TTS e instâncias personalizadas (`ExercicioInstancia`).
  - `roteiros-sessao-e-processamento-analise.md`: prescrição de roteiros por dias da semana, avaliação de qualidade de captura, execução realtime e offline no navegador, pós-processamento com Google Gemini, cache materializado e reprocessamento determinístico de landmarks.
  - `agenda-clinica-e-mensageria.md`: agenda compartilhada presencial e online e chat interno com cartões de referência para sessões, análises e exercícios.
  - `aderencia-retencao-notificacoes-e-relatorios.md`: cálculo de adesão de 14 dias, alertas clínicos automáticos, tarefas agendadas idempotentes, Web Push VAPID, cockpit de retenção e exportação PDF/CSV.
- **Especificações Clínicas e Biomecânica (`docs/03-clinico-e-biomecanica/`)**:
  - `plano-implementacao-reunioes-clinicas.md`: plano técnico detalhado das Sprints 1 a 4 derivado das reuniões clínicas de setembro e outubro de 2026.
  - `analise-escala-de-berg.md`, `especificacao-berg-03-sentado.md` e referência oficial em PDF da Escala de Equilíbrio de Berg.
- **Segurança da Informação e LGPD (`docs/04-seguranca-e-lgpd/`)**:
  - `lgpd-consentimento-e-menores.md`: arquitetura de consentimentos obrigatórios e opcionais, telemetria de câmera, expurgo automático de vídeos em 15 dias e diretrizes jurídicas.

### Alterado
- **Reorganização Taxonômica de `docs/`**:
  - Estruturação em cinco diretórios temáticos numerados (`01-arquitetura-e-infra`, `02-fluxos-do-sistema`, `03-clinico-e-biomecanica`, `04-seguranca-e-lgpd` e `05-institucional-e-historico`), mantendo `docs/GUIA_DE_CONTRIBUICAO_E_DEPLOY_EQUIPE.md` no caminho raiz para compatibilidade de links.
- **Atualização Arquitetural (`docs/01-arquitetura-e-infra/visao-geral-e-arquitetura.md`)**:
  - Documentação alinhada à arquitetura vigente com processamento de pose no cliente via MediaPipe e reprocessamento em Java (`LandmarksReplayer`).
- **Padronização de Templates de Pull Request e Redação Técnica**:
  - Simplificação do `.github/pull_request_template.md` com foco em Changelog, Contexto e Notas Técnicas, e adoção de redação técnica natural sem emojis.
