# Histórico de Evolução Documental e Governança (`.github`)

Este arquivo registra as principais atualizações estruturais realizadas no repositório central de documentação e governança da organização Sinergia Fisioterapia.

---

## [2026-11-11] — Reorganização Completa do Hub Central e Documentação de Fluxos

### Adicionado
- Criação do portal navegável na raiz (`README.md`) e do índice detalhado em `docs/README.md`.
- Criação da documentação completa dos seis grandes fluxos operacionais constatados no código de `sinergia-api` e `sinergia-web` em `docs/02-fluxos-do-sistema/`:
  - `autenticacao-perfis-e-onboarding.md`
  - `gestao-clinicas-equipe-e-auditoria.md`
  - `catalogo-exercicios-instancias-e-tts.md`
  - `roteiros-sessao-e-processamento-analise.md`
  - `agenda-clinica-e-mensageria.md`
  - `aderencia-retencao-notificacoes-e-relatorios.md`
- Inclusão e categorização das especificações clínicas e biomecânicas em `docs/03-clinico-e-biomecanica/`:
  - `plano-implementacao-reunioes-clinicas.md` (consolidação técnica das reuniões de setembro e outubro de 2026 em 4 sprints).
  - `analise-escala-de-berg.md`, `especificacao-berg-03-sentado.md` e PDF de referência da Escala de Berg.
- Promoção da documentação de privacidade e proteção de dados para `docs/04-seguranca-e-lgpd/lgpd-consentimento-e-menores.md`.

### Alterado
- Reestruturação do diretório `docs/` em cinco pastas numeradas por domínio (`01-arquitetura-e-infra`, `02-fluxos-do-sistema`, `03-clinico-e-biomecanica`, `04-seguranca-e-lgpd` e `05-institucional-e-historico`), preservando `docs/GUIA_DE_CONTRIBUICAO_E_DEPLOY_EQUIPE.md` na raiz de `docs/` para manter compatibilidade com links existentes.
- Atualização de `docs/01-arquitetura-e-infra/visao-geral-e-arquitetura.md` para refletir a arquitetura vigente (processamento de pose no navegador via MediaPipe, reprocessamento em Java via `LandmarksReplayer`, enriquecimento assíncrono via Google Gemini e cache materializado).
- Padronização editorial em linguagem técnica natural e remoção de emojis nos documentos de governança e arquitetura.
