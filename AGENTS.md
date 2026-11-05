# Diretrizes Organizacionais para Agentes de IA - Sinergia Fisioterapia

Este documento estabelece as regras e padrões de engenharia de software e deploy válidos para todos os repositórios da organização `sinergia-fisioterapia` (`sinergia-api`, `sinergia-web` e complementares).
Qualquer agente de IA (Antigravity, Cursor, GitHub Copilot, Claude Code, Windsurf, etc.) DEVE seguir rigorosamente este fluxo.

---

## 1. Padrão de Branching e GitFlow

- **Proibido commit direto**: Nunca faça commits diretamente nas branches `master` ou `develop`.
- **Criação de branches**: Toda tarefa começa ramificando a partir da `develop` mais recente:
  ```bash
  git checkout develop
  git pull origin develop
  git checkout -b <tipo>/<nome-curto>
  ```
- **Nomenclatura de branches**:
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

## 3. Ambientes e Pipelines de Deploy

1. **Homologação**:
   - Merge na branch `develop` realiza o deploy automático em Homologação.
   - API: `https://api-hml-sinergia.yegear.dev`
   - Web: `https://app-hml.sinergiahealth.com.br`
2. **Produção**:
   - Promoção exige PR de `develop` para `master`.
   - Atualização do `CHANGELOG.md` e criação de Tag Git SemVer (`vX.Y.Z`).
   - Aprovação obrigatória do Tech Lead Wallas (`WallasAR`).
   - API: `https://api-sinergia.yegear.dev`
   - Web: `https://app.sinergiahealth.com.br`

---

## 4. Guia Oficial da Equipe

O guia detalhado para desenvolvedores e equipe de engenharia está disponível em:
[Guia Oficial de Contribuição e Deploy da Equipe](https://github.com/sinergia-fisioterapia/.github/blob/main/docs/GUIA_DE_CONTRIBUICAO_E_DEPLOY_EQUIPE.md)
