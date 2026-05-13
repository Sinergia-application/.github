# Sistema de Notificações — Sinergia Web / API

**Data:** maio de 2026
**Escopo:** Fase 1 do sistema de notificações — **histórico in-app** (sininho com badge + listagem) e **Web Push** (notificação nativa via PWA com VAPID), valendo tanto para paciente quanto para profissional. A camada cobre infraestrutura, fluxo e os primeiros pontos de injeção automática (análise concluída, vínculo, roteiro, agenda).

---

## 1. Visão geral

```
┌──────────────────────────────────────────────────────────────────────────┐
│  Eventos de negócio                                                      │
│  • Análise concluída/erro     • Vínculo paciente↔profissional aprovado   │
│  • Roteiro atribuído/substituído                                         │
│  • Agendamento criado / remarcado / cancelado                            │
└──────────────────────────────┬───────────────────────────────────────────┘
                               │  notificacaoService.publicar(...)
                               ▼
                  ┌──────────────────────────┐
                  │   NotificacaoService     │
                  │  (sinergia-api)          │
                  └────────┬─────────────────┘
                           │
            ┌──────────────┼───────────────────────────────┐
            ▼                                               ▼
 ┌─────────────────────────┐                  ┌──────────────────────────┐
 │ Tabela `notificacao`    │                  │  WebPushService          │
 │  histórico in-app       │                  │  (assina VAPID + envia)  │
 │  (fonte da verdade)     │                  └────────┬─────────────────┘
 └──────────┬──────────────┘                           │
            │                                          ▼
            │                          ┌──────────────────────────┐
            │                          │  Endpoints do navegador  │
            │                          │  (Push servers FCM/etc.) │
            │                          └────────┬─────────────────┘
            ▼                                          │
 ┌──────────────────────────┐                          ▼
 │  NotificationBell        │ ◄────────  Service Worker (ngsw-worker.js)
 │  (sino + dropdown)       │            • Notificação nativa em background
 │  + página /notificacoes  │            • Mensagem para abas abertas
 │  + toast in-app          │
 └──────────────────────────┘
```

> Princípio central: a **persistência in-app é a fonte da verdade**. O Web Push é entrega oportunista — se as chaves VAPID não estiverem configuradas, ou se o navegador não suportar push, o usuário ainda recebe tudo pelo sino.

---

## 2. Modelo de dados

### 2.1 `notificacao` (V12)

| Coluna       | Tipo          | Observações                                       |
| ------------ | ------------- | ------------------------------------------------- |
| `id`         | CHAR(36) PK   | UUID gerado pelo Hibernate                        |
| `usuario_id` | CHAR(36) FK   | `usuario(id) ON DELETE CASCADE`                   |
| `tipo`       | VARCHAR(32)   | Enum `TipoNotificacao` (string)                   |
| `titulo`     | VARCHAR(160)  | Até 160 chars                                     |
| `mensagem`   | VARCHAR(1000) | Texto curto, exibido no sino e nas notificações   |
| `link_acao`  | VARCHAR(512)  | Rota relativa para abrir ao clicar (opcional)     |
| `lida`       | BOOLEAN       | `false` por padrão                                |
| `lida_em`    | TIMESTAMP     | Preenchido ao marcar como lida                    |
| `criado_em`  | TIMESTAMP     | Default `CURRENT_TIMESTAMP`                       |

Índices: `(usuario_id, lida)` e `(usuario_id, criado_em)`.

### 2.2 `inscricao_push` (V12)

Cada usuário pode ter múltiplas inscrições (multi-device).

| Coluna          | Tipo         | Observações                                                |
| --------------- | ------------ | ---------------------------------------------------------- |
| `id`            | CHAR(36) PK  |                                                            |
| `usuario_id`    | CHAR(36) FK  | `usuario(id) ON DELETE CASCADE`                            |
| `endpoint`      | VARCHAR(512) | **Único globalmente**; usado pra upsert                    |
| `p256dh`        | VARCHAR(255) | Chave pública do client (base64url)                        |
| `auth`          | VARCHAR(255) | Segredo de autenticação do client (base64url)              |
| `user_agent`    | VARCHAR(512) | Para debug/inspeção dos dispositivos do usuário            |
| `criado_em`     | TIMESTAMP    |                                                            |
| `ultimo_uso_em` | TIMESTAMP    | Atualizado após cada envio bem-sucedido                    |

### 2.3 Enum `TipoNotificacao`

| Valor             | Significado clínico/UX                                     |
| ----------------- | ---------------------------------------------------------- |
| `SISTEMA`         | Avisos da plataforma (vínculo, falhas, manutenção)         |
| `MENSAGEM`        | Comunicação direta profissional ↔ paciente *(futuro)*      |
| `ALERTA_CLINICO`  | Análise concluída, sessões, indicadores clínicos           |
| `AGENDA`          | Roteiro novo/substituído, agendamento criado/remarcado     |

---

## 3. Backend (`sinergia-api`)

### 3.1 Pacotes / arquivos novos

```
com.sinergia.api
├── domain/
│   ├── Notificacao.java               # entidade
│   ├── InscricaoPush.java             # entidade
│   └── TipoNotificacao.java           # enum
├── repository/
│   ├── NotificacaoRepository.java
│   └── InscricaoPushRepository.java
├── service/
│   ├── NotificacaoService.java        # orquestra criação + publicação
│   └── WebPushService.java            # assina VAPID e envia (async)
├── web/
│   ├── controller/NotificacaoController.java
│   └── dto/
│       ├── NotificacaoResponse.java
│       ├── NotificacaoListResponse.java
│       ├── PushSubscriptionRequest.java
│       └── VapidPublicKeyResponse.java
└── tools/
    └── VapidKeyGenerator.java         # CLI para gerar par de chaves VAPID
```

Outras alterações:
- `SinergiaApiApplication` recebeu `@EnableAsync` para o envio em background.
- `pom.xml` adicionou `nl.martijndwars:web-push:5.1.1` + `bcprov-jdk18on:1.78.1` (criptografia ECDH/VAPID).
- `application.yml` ganhou o bloco:

```yaml
app:
  push:
    vapid:
      public-key: ${VAPID_PUBLIC_KEY:}
      private-key: ${VAPID_PRIVATE_KEY:}
      subject: ${VAPID_SUBJECT:mailto:contato@sinergia.app}
```

### 3.2 Endpoints REST (prefixo `/api/v1`)

Todos sob JWT (Bearer). O backend identifica o usuário pelo token; não há `pacienteId` na rota — o sino é o mesmo para qualquer perfil.

| Método | Caminho                                          | Resposta                                | Descrição                                       |
| ------ | ------------------------------------------------ | --------------------------------------- | ----------------------------------------------- |
| GET    | `/notificacoes?page&size`                        | `NotificacaoListResponse`               | Lista paginada (mais recentes primeiro)         |
| GET    | `/notificacoes/nao-lidas/contagem`               | `{ naoLidas: number }`                  | Apenas o número para o badge                    |
| PATCH  | `/notificacoes/{id}/lida`                        | `NotificacaoResponse`                   | Marca **uma** como lida                         |
| PATCH  | `/notificacoes/lidas`                            | `{ atualizadas: number }`               | Marca **todas** como lidas                      |
| GET    | `/notificacoes/push/vapid-key`                   | `{ publicKey: string }`                 | Chave pública (fallback do front)               |
| POST   | `/notificacoes/push/subscribe`                   | `204 No Content`                        | Cria/atualiza inscrição (upsert por `endpoint`) |
| DELETE | `/notificacoes/push/subscribe?endpoint=...`      | `204 No Content`                        | Remove inscrição                                |

#### Payload de `NotificacaoResponse`

```json
{
  "id": "0c98...",
  "tipo": "ALERTA_CLINICO",
  "titulo": "Análise concluída",
  "mensagem": "Sua análise de Agachamento está disponível.",
  "linkAcao": "/analises/0c98.../resultado",
  "lida": false,
  "lidaEm": null,
  "criadoEm": "2026-05-12T22:10:15Z"
}
```

#### Payload de `PushSubscriptionRequest`

```json
{
  "endpoint": "https://fcm.googleapis.com/fcm/send/abc123",
  "p256dh": "BAcD...",
  "auth": "xQz4...",
  "userAgent": "Mozilla/5.0 ..."
}
```

### 3.3 Como notificar dentro do backend

Qualquer service pode publicar via `NotificacaoService.publicar(...)`. **Não** é necessário tocar em transação ou em controller — a chamada é segura mesmo dentro de transações ativas.

```java
notificacaoService.publicar(
        paciente.getId(),
        TipoNotificacao.AGENDA,
        "Novo agendamento",
        "Você tem uma sessão marcada para 13/05 às 14:30.",
        "/paciente/inicio"
);
```

A função é **idempotente em si própria** (cada chamada gera um registro novo); a responsabilidade de evitar duplicação fica com o caller — ver, por exemplo, `AnaliseVideoService.updateFromWorker()`, que dispara somente na **transição** para `CONCLUIDO`/`ERRO`.

> Se `Usuario.notificacoesHabilitadas == false`, o registro **ainda é gravado** (histórico/auditoria) mas o push é suprimido. Isso preserva contexto clínico.

### 3.4 Pontos de injeção atuais

| Evento                                                           | Quem recebe                       | Tipo              |
| ---------------------------------------------------------------- | --------------------------------- | ----------------- |
| `AnaliseVideo` transita para `CONCLUIDO`                         | Paciente + Profissional vinculado | `ALERTA_CLINICO`  |
| `AnaliseVideo` transita para `ERRO`                              | Paciente                          | `SISTEMA`         |
| Profissional vincula paciente (`vincularPacientePorCodigoPublico`) | Paciente                        | `SISTEMA`         |
| `ProfissionalRoteiroService.atribuir()` (roteiro ativo)          | Paciente                          | `AGENDA`          |
| `ProfissionalRoteiroService.substituir()`                        | Paciente                          | `AGENDA`          |
| `ProfissionalAgendaService.criar()`                              | Paciente                          | `AGENDA`          |
| `ProfissionalAgendaService.atualizar()` (data/horário mudou)     | Paciente                          | `AGENDA`          |
| `ProfissionalAgendaService.excluir()`                            | Paciente                          | `AGENDA`          |

### 3.5 Comportamento do envio Web Push (`WebPushService`)

- Inicializa BouncyCastle, monta o `PushService` (web-push) com as chaves VAPID.
- Se as chaves estiverem vazias: registra `WARN` no boot e fica em **modo no-op** (não envia, mas não derruba a aplicação).
- Envio assíncrono (`@Async`) — não bloqueia a thread HTTP que originou a notificação.
- **404 / 410** → remove a inscrição (endpoint expirado).
- Outras falhas viram `WARN` com o endpoint truncado, sem stacktrace ruidoso.
- Payload é serializado no **formato padrão do Angular Service Worker**:

```jsonc
{
  "notification": {
    "title": "Análise concluída",
    "body": "Sua análise de Agachamento está disponível.",
    "icon": "/assets/icons/icon-192x192.png",
    "badge": "/assets/icons/badge.png",
    "tag": "<uuid da notificação>",
    "data": {
      "id": "<uuid>",
      "tipo": "ALERTA_CLINICO",
      "linkAcao": "/analises/<id>/resultado",
      "criadoEm": "2026-05-12T22:10:15Z",
      "onActionClick": {
        "default": {
          "operation": "navigateLastFocusedOrOpen",
          "url": "/analises/<id>/resultado"
        }
      }
    }
  }
}
```

Com isso, o navegador exibe a notificação **automaticamente** quando a aba está em background (sem código extra no SW) e a aba aberta recebe o objeto via `swPush.messages` para mostrar um toast.

---

## 4. Frontend (`sinergia-web`)

### 4.1 Arquivos novos / alterados

```
src/app/core/
├── api/notification-api.service.ts      # wrapper HTTP dos endpoints
├── models/notificacao.types.ts          # tipos espelho do backend
└── notifications/
    ├── web-push.service.ts              # SwPush + integração VAPID
    └── notification-hub.service.ts      # toast in-app + clicks em push

src/app/shared/
└── notification-bell/
    └── notification-bell.component.ts   # sino + dropdown

src/app/features/shared/pages/
└── notificacoes-page/
    └── notificacoes-page.component.ts   # listagem completa com filtros
```

Outras mudanças:
- `app.config.ts`: `provideAppInitializer` agora dispara `NotificationHubService.start()`.
- `ngsw-config.json`: criado (faltava — o `provideServiceWorker` apontava pra ele, mas o arquivo não existia, o que quebrava builds production).
- `environment.ts` e `environment.prod.ts`: ganharam `vapidPublicKey`.
- Sino plugado nos cabeçalhos dos **dashboards** e **perfis** (paciente + profissional), substituindo botões estáticos.
- Toggle "Notificação" no perfil agora chama `WebPushService.syncWithPreference(checked)` (inscreve quando ON, desinscreve quando OFF — além de salvar no backend).

### 4.2 Rotas

| Rota                          | Componente                  | Quem acessa                            |
| ----------------------------- | --------------------------- | -------------------------------------- |
| `/paciente/notificacoes`      | `NotificacoesPageComponent` | Paciente (`roleGuard: ['PACIENTE']`)    |
| `/profissional/notificacoes`  | `NotificacoesPageComponent` | Profissional (`roleGuard: ['PROFISSIONAL']`) |

O dropdown do sino tem um botão "Ver todas as notificações" que detecta o tipo de usuário via `AuthService` e roteia para a URL certa.

### 4.3 `NotificationBellComponent`

Botão de sino com badge, polling de contagem a cada 30 s, integração com `swPush.messages` para atualizar em tempo real e ativador de push (chama `WebPushService.requestSubscription()`).

**Comportamento responsivo** (decisão importante de UX):

| Viewport          | Click no sino                                    |
| ----------------- | ------------------------------------------------ |
| ≥ 1024px (`lg`)   | Abre **dropdown** com até 20 itens.              |
| < 1024px (mobile) | **Navega direto** para `/<paciente\|profissional>/notificacoes`. |

Em telas menores o popover ficava apertado e propenso a ser cortado por cabeçalhos com `overflow-hidden` — a página dedicada usa a tela inteira, então a experiência fica melhor. A detecção usa `window.matchMedia('(min-width: 1024px)')` reativo (escuta `change`) e fecha o dropdown automaticamente se o usuário redimensionar a janela de desktop para mobile com ele aberto.

Decisões de UX do dropdown:

- **Badge zera localmente** ao marcar como lida (resposta otimista).
- **Marcar todas como lidas** só aparece quando há não lidas.
- Click em item:
  1. Marca como lida (otimista + chamada PATCH).
  2. Navega via `Router.navigateByUrl(linkAcao)` se houver.
- Footer mostra o estado do push:
  - `default` → botão "Ativar notificações push".
  - `denied` → "Push bloqueado pelo navegador" (não tenta de novo).
  - `granted` → "Push ativado neste dispositivo".
  - Sem suporte do navegador → "Push indisponível neste navegador".

### 4.4 `WebPushService`

Encapsula `SwPush` do Angular. API:

| Método                            | O que faz                                                            |
| --------------------------------- | -------------------------------------------------------------------- |
| `isAvailable()`                   | Verifica suporte do navegador + service worker registrado.            |
| `permission()`                    | `Notification.permission` (com guarda SSR).                           |
| `requestSubscription()`           | Pede permissão + registra subscription no backend.                    |
| `unsubscribe()`                   | Remove inscrição local e no backend.                                  |
| `syncWithPreference(enabled)`     | Chamado pelo toggle do perfil — reconcilia estado.                    |
| `messages$` / `notificationClicks$` | Streams diretos do SwPush.                                          |

Resolução da VAPID pública:

1. Usa `environment.vapidPublicKey` se preenchido.
2. Caso vazio, faz `GET /notificacoes/push/vapid-key` (fallback útil pra evitar rebuild só pra trocar a chave).

### 4.5 `NotificationHubService`

Registrado no `app.config.ts` via `provideAppInitializer`. Inicia listeners globais:

- `swPush.messages` → dispara `ToastService.show(...)` com o `title`/`body` do payload (o badge é atualizado pelo próprio sininho).
- `swPush.notificationClicks` → navega para `linkAcao` quando o usuário clica numa notificação nativa.

### 4.6 Página `/notificacoes`

Componente único compartilhado entre paciente e profissional (em `features/shared/pages/notificacoes-page/`). Recursos:

- Chips de filtro: `Todos`, `Não lidas`, `Clínico`, `Agenda`, `Mensagens`, `Sistema`.
- Paginação por "Carregar mais" (30 por página) com dedup por id.
- Datas amigáveis: `Hoje 14:32`, `Ontem 09:10`, `12/05 14:32`.
- Empty state contextual via `EmptyStateComponent` (subtítulo muda conforme o filtro ativo).
- Click numa notificação marca como lida e navega para `linkAcao` (se houver).

### 4.7 Toggle "Notificação" no perfil

```ts
onNotificacaoChange(checked: boolean): void {
  this.notificacoes.set(checked);
  this.api.patchPerfil({ notificacoesHabilitadas: checked }).subscribe({
    next: () => {
      this.auth.refreshMe().subscribe({ error: () => undefined });
      void this.webPush.syncWithPreference(checked);   // ← inscreve/desinscreve
    },
    error: (e) => { /* rollback + toast */ },
  });
}
```

---

## 5. Configuração de produção (passo a passo)

### 5.1 Gerar as chaves VAPID (uma única vez na vida do produto)

```bash
cd sinergia-api
./mvnw -q compile '-Dexec.mainClass=com.sinergia.api.tools.VapidKeyGenerator' exec:java
```

Saída (exemplo):

```
# === Web Push (VAPID) — gerado em 2026-05-13T01:46:39Z ===
VAPID_PUBLIC_KEY=BPOLNqOkDKIPlVVnjckcRzRFC2DY1phEHrVxnG7Y2c1n87WcscNGPEcXfzkDuKnmfedVgHqqhhC9wOrsUc5wPHw
VAPID_PRIVATE_KEY=mkR02YmTF8q_hWhQq-nQGCVWSiPveHq25zw4yfZo9ng
VAPID_SUBJECT=mailto:contato@sinergia.app
```

> Alternativa via Node: `npx web-push generate-vapid-keys --json`.

### 5.2 Configurar o backend

Adicione no `.env` (ou variáveis de ambiente do compose/k8s):

```
VAPID_PUBLIC_KEY=...
VAPID_PRIVATE_KEY=...
VAPID_SUBJECT=mailto:contato@sinergia.app
```

Reinicie a API. Confirme nos logs:

```
[WebPush] Habilitado com subject=mailto:contato@sinergia.app
```

Se aparecer `[WebPush] VAPID keys não configuradas...` o backend continuou funcionando, mas o push está desativado.

### 5.3 Configurar o frontend

`sinergia-web/src/environments/environment.ts` e `environment.prod.ts`:

```ts
vapidPublicKey: 'BPOLNqOkDKIPlVV...',  // a MESMA chave pública do backend
```

(É possível pular esta etapa: o `WebPushService` faz fallback para `GET /notificacoes/push/vapid-key` quando o environment está vazio. Útil em ambientes com a mesma URL de API.)

### 5.4 Service Worker e PWA

- `@angular/service-worker` já está nas dependências do front.
- `ngsw-config.json` está versionado.
- O SW só é registrado em `environment.production && !isLocalhost` (ver `app.config.ts`).

**Importante:** Web Push requer **HTTPS** (exceto em `localhost` no Chrome). Em dev (HTTP/192.x.x.x), `requestSubscription()` falha silenciosamente — comportamento esperado.

### 5.5 Migration

`V12__create_notificacoes_e_push_subscriptions.sql` é aplicada automaticamente pelo Flyway no boot. Como `spring.jpa.hibernate.ddl-auto=validate`, qualquer divergência derruba o boot — confira o log.

> **Atenção (gotcha resolvido):** se a coluna `tipo` for criada como `VARCHAR`, a entidade JPA **precisa** declarar `@JdbcTypeCode(SqlTypes.VARCHAR)` no campo do enum. Sem isso, Hibernate 6 + MariaDB tenta mapear como `ENUM` nativo e quebra a validação na inicialização. Este projeto já segue o padrão.

---

## 6. Adicionando novos eventos notificáveis

Receita curta:

1. **Identifique o ponto de transição** no service de negócio (ex.: status virou X, registro mudou de dono).
2. Injete o `NotificacaoService` no service.
3. Chame `notificacaoService.publicar(usuarioId, tipo, titulo, mensagem, linkAcao)`.
4. Garanta idempotência se necessário (não notifique dentro de loops/saves repetidos — prefira chamadas após transições reais).

Exemplo real, em `AnaliseVideoService.updateFromWorker`:

```java
StatusAnalise novoStatus = salva.getStatusAnalise();
boolean transicionouParaFinal = novoStatus != null && novoStatus != anterior
        && (novoStatus == StatusAnalise.CONCLUIDO || novoStatus == StatusAnalise.ERRO);
if (transicionouParaFinal) {
    notificarConclusaoAnalise(salva);
}
```

> **Dica de UX**: títulos de no máximo ~50 chars (cabe em mobile), `mensagem` em 1 a 2 frases curtas, sempre informe um `linkAcao` quando há contexto para abrir (resultado, plano, etc).

---

## 7. Operação e debugging

- **Logs ricos**: `WebPushService` loga warnings com endpoint abreviado em qualquer falha.
- **Endpoint expirado (404/410)**: removido automaticamente. Não há tarefa de limpeza necessária.
- **Reset total**: `DELETE FROM inscricao_push;` desinscreve todos os dispositivos (eles serão reconvidados via toggle).
- **Inspeção manual**:

  ```sql
  SELECT u.nome, n.tipo, n.titulo, n.lida, n.criado_em
    FROM notificacao n
    JOIN usuario u ON u.id = n.usuario_id
   ORDER BY n.criado_em DESC LIMIT 50;

  SELECT u.nome, COUNT(*) AS dispositivos
    FROM inscricao_push ip
    JOIN usuario u ON u.id = ip.usuario_id
   GROUP BY u.nome;
  ```

- **Teste do envio Web Push em dev**: rode o backend com `VAPID_*` preenchidos, abra a aplicação em **localhost** (Chrome aceita), ative o toggle no perfil; depois dispare um evento real (atribuir um roteiro, por exemplo). Em background, a notificação nativa aparece; em foreground, vira um toast.

---

## 8. Próximas fases (não fazem parte da Fase 1)

- **Lembretes pré-sessão** (job cron rodando ~30 min antes de cada agendamento).
- **Mensagens diretas** profissional ↔ paciente (chat) → tipo `MENSAGEM`.
- **Quiet hours** por usuário (não enviar push entre H1 e H2).
- **Resumo diário consolidado** (uma única notificação agregando vários eventos do dia).
- **Email opcional** para usuários sem push ativo, configurável via preferência.
- **Painel admin** para inspecionar volume de notificações por tipo / falhas de envio.
