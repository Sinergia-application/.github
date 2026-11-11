# Diretrizes Organizacionais para Agentes de IA - Sinergia Fisioterapia

Este documento estabelece as regras e padrões de engenharia de software, documentação e deploy válidos para todos os repositórios da organização `sinergia-fisioterapia` (`sinergia-api`, `sinergia-web` e `.github`).
Qualquer agente de IA (Antigravity, Cursor, GitHub Copilot, Claude Code, Windsurf, etc.) deve seguir rigorosamente este fluxo.

---

## 1. Padrão de Branching e GitFlow

- **Proibido commit direto:** Nunca faça commits diretamente nas branches `master` ou `develop`.
- **Criação de branches:** Toda tarefa começa ramificando a partir da `develop` mais recente (ou `main` no repositório `.github`):
  ```bash
  git checkout develop
  git pull origin develop
  git checkout -b <tipo>/<nome-curto>
  ```
- **Nomenclatura de branches:**
  - `feat/<nome>`: Novas funcionalidades
  - `fix/<nome>`: Correções de bugs
  - `refactor/<nome>`: Refatorações sem alteração funcional
  - `chore/<nome>`: Manutenção de pacotes, dependências ou scripts
  - `docs/<nome>`: Documentação
  - `hotfix/<nome>`: Correções emergenciais em produção (ramifica de `master`)

---

## 2. Padrão de Commits (Conventional Commits)

- Estrutura: `<tipo>(<escopo>): <mensagem no imperativo>`
- Tipos aceitos: `feat`, `fix`, `refactor`, `test`, `style`, `docs`, `chore`, `perf`, `ci`.

---

## 3. Padrão de Redação de Documentação

- Toda documentação técnica, clínica ou arquitetural deve ser redigida de forma natural, clara, objetiva e harmônica em português.
- Não utilize emojis em documentos técnicos, guias, changelogs ou especificações.
- Centralize documentações transversais (arquitetura, fluxos de negócio ponta a ponta, especificações clínicas e LGPD) neste repositório `.github`, respeitando a estrutura de diretórios descrita na Seção 5.

---

## 4. Ambientes e Pipelines de Deploy

1. **Homologação:**
   - Merge na branch `develop` realiza o deploy automático em Homologação.
   - API: `https://api-hml-sinergia.yegear.dev`
   - Web: `https://app-hml.sinergiahealth.com.br`
2. **Produção:**
   - Promoção exige PR de `develop` para `master`.
   - Atualização do `CHANGELOG.md` e criação de Tag Git SemVer (`vX.Y.Z`).
   - Aprovação obrigatória do Tech Lead Wallas (`WallasAR`).
   - API: `https://api-sinergia.yegear.dev`
   - Web: `https://app.sinergiahealth.com.br`

---

## 5. Mapa da Documentação Central (`.github/docs/`)

- [Índice Completo da Documentação](docs/README.md)
- [Guia Oficial de Contribuição e Deploy da Equipe](https://github.com/sinergia-fisioterapia/.github/blob/main/docs/GUIA_DE_CONTRIBUICAO_E_DEPLOY_EQUIPE.md)
- `docs/01-arquitetura-e-infra/`: Visão geral do sistema, diagramas, pipelines CI/CD e arquitetura do motor de movimento.
- `docs/02-fluxos-do-sistema/`: Documentação detalhada dos fluxos de autenticação/onboarding, gestão de clínicas/auditoria, catálogo/instâncias/TTS, roteiros/sessão/análise, agenda/mensageria e aderência/retenção/relatórios.
- `docs/03-clinico-e-biomecanica/`: Plano de implementação por sprints das reuniões clínicas e especificações da Escala de Berg.
- `docs/04-seguranca-e-lgpd/`: Consentimento, retenção de vídeos e proteção de dados sensíveis.
- `docs/05-institucional-e-historico/`: Documentos de fomento, relatórios de progresso e artigo acadêmico.
