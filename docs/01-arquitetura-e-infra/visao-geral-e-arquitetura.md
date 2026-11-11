# Visão Geral do Sistema e Arquitetura Técnica

**Escopo:** Arquitetura integrada dos repositórios `sinergia-web` e `sinergia-api`  
**Última atualização:** Novembro de 2026

---

## 1. Propósito da Plataforma

O Sinergia é uma plataforma de telerreabilitação e acompanhamento fisioterapêutico domiciliar assistida por visão computacional e inteligência artificial. O objetivo do sistema é permitir que fisioterapeutas e clínicas prescrevam roteiros de exercícios personalizados, acompanhem a execução biomecânica realizada pelo paciente através da câmera do próprio smartphone ou computador e recebam indicadores objetivos de evolução, aderência e risco clínico.

A plataforma opera sob a diretriz de apoio à decisão clínica: os algoritmos de visão computacional e os modelos generativos estruturam métricas, detectam compensações posturais e sintetizam resumos, mas a validação final e a conduta terapêutica pertencem exclusivamente ao profissional de saúde responsável.

---

## 2. Topologia dos Componentes

A arquitetura atual do sistema é composta por dois repositórios principais de aplicação e um repositório central de governança:

1. **Frontend Web e PWA (`sinergia-web`):**
   - Desenvolvido em Angular com Tailwind CSS e distribuído como Progressive Web App (PWA) via Cloudflare Workers / Pages.
   - Executa localmente no navegador do paciente a inferência de pose corporal utilizando MediaPipe Pose e o motor determinístico `@sinergia/realtime-engine` em TypeScript.
   - Suporta execução em tempo real com feedback sonoro imediato e execução por gravação com análise no próprio navegador antes do envio.

2. **Backend e Motor Clínico (`sinergia-api`):**
   - Desenvolvido em Java 21 com Spring Boot 3, Spring Security (JWT), Spring Data JPA / Hibernate e migrações versionadas via Flyway sobre banco de dados relacional MariaDB.
   - Centraliza autenticação e controle de acesso baseado em papéis (RBAC), gestão multi-tenant de clínicas, prescrição de roteiros, armazenamento de mídia (`StorageService`), reprocessamento determinístico de landmarks em Java (`LandmarksReplayer`), enriquecimento assíncrono de relatórios via Google Gemini (`GeminiFeedbackService`), síntese de voz via ElevenLabs (`ElevenLabsTtsService`), notificações Web Push (VAPID) e disparo de e-mails transacionais.

3. **Governança e Documentação (`.github`):**
   - Repositório centralizador dos padrões de engenharia, GitFlow, especificações clínicas, diagramas arquiteturais e documentação dos fluxos de ponta a ponta.

> **Nota sobre evolução arquitetural:** Nas primeiras versões do projeto, o processamento de vídeo dependia de um serviço externo em Python (`sinergia-worker`) acoplado por filas RabbitMQ/Celery. Na arquitetura vigente, toda a extração de coordenadas articulares (landmarks) ocorre no cliente (`sinergia-web`) e o reprocessamento de regras biomecânicas roda nativamente na `sinergia-api` (`LandmarksReplayer`), eliminando a latência de fila de vídeo e reduzindo custos operacionais de infraestrutura.

---

## 3. Diagrama de Contexto e Integrações

```mermaid
flowchart TB
    subgraph Clientes["Camada de Apresentacao (PWA Angular)"]
        PAC["Paciente / Acompanhante<br/>(Smartphone ou Desktop)"]
        PROF["Fisioterapeuta / Gestor de Clinica"]
        REC["Recepcionista"]
        ADM["Administrador do Sistema"]
    end

    subgraph Frontend["sinergia-web (Cloudflare Pages / Workers)"]
        UI["Aplicacao Angular + Service Worker"]
        MP["MediaPipe Pose + Motor Biomecanico TS"]
    end

    subgraph Backend["sinergia-api (Spring Boot 3 / Java 21)"]
        SEC["Filtro JWT + Controle RBAC + Multi-tenancy"]
        CORE["Servicos de Dominio e Regras Clinicas"]
        REPLAY["LandmarksReplayer + Validadores de Regras"]
        ASYNC["Pos-Processamento Assincrono e Materializacao"]
        TASKS["Schedulers: Engajamento, Alertas Clinicos e Expurgo LGPD"]
    end

    subgraph Persistencia["Camada de Dados e Midia"]
        DB[("MariaDB 11<br/>Schema Gerenciado via Flyway")]
        FS[("Storage Local / Volumes<br/>Videos, Avatares e Audios TTS")]
    end

    subgraph Externos["Servicos Externos Integrados"]
        GEMINI["Google Gemini API<br/>(Resumos Clinicos e Conteudo)"]
        ELEVEN["ElevenLabs API<br/>(Sintese de Voz TTS por Flag)"]
        SMTP["Servidor SMTP<br/>(E-mails Transacionais e Lembretes)"]
        WEBPUSH["Servicos Web Push (VAPID)"]
    end

    PAC --> UI
    PROF --> UI
    REC --> UI
    ADM --> UI
    UI <--> MP
    UI -->|HTTPS REST / JSON / Multipart| SEC
    SEC --> CORE
    CORE --> REPLAY
    CORE --> ASYNC
    CORE --> DB
    CORE --> FS
    TASKS --> CORE
    ASYNC --> GEMINI
    CORE --> ELEVEN
    CORE --> SMTP
    CORE --> WEBPUSH
```

---

## 4. Modelo de Domínio Principal

O diagrama abaixo representa as entidades centrais persistidas no MariaDB e seus relacionamentos estruturais:

```mermaid
erDiagram
    EMPRESA ||--o{ PROFISSIONAL_SAUDE : "vincula"
    EMPRESA ||--o{ RECEPCIONISTA : "vincula"
    EMPRESA ||--o{ EXERCICIO_EMPRESA : "visualiza"
    PROFISSIONAL_SAUDE ||--o{ PACIENTE : "orienta (tutela)"
    PROFISSIONAL_SAUDE ||--o{ ROTEIRO : "prescreve"
    PROFISSIONAL_SAUDE ||--o{ EXERCICIO_INSTANCIA : "personaliza"
    PROFISSIONAL_SAUDE ||--o{ AGENDAMENTO : "atende"
    PACIENTE ||--o{ ROTEIRO : "recebe"
    PACIENTE ||--o{ SESSAO_EXERCICIO : "executa"
    PACIENTE ||--o{ AGENDAMENTO : "participa"
    PACIENTE ||--o{ CONSENTIMENTO_USUARIO : "aceita"
    EXERCICIO ||--o{ ITEM_ROTEIRO : "compoe"
    EXERCICIO ||--o{ EXERCICIO_INSTANCIA : "baseia"
    EXERCICIO ||--o{ AUDIO_FEEDBACK : "possui"
    ROTEIRO ||--|{ ITEM_ROTEIRO : "contem"
    ITEM_ROTEIRO ||--o{ SESSAO_EXERCICIO : "origina"
    SESSAO_EXERCICIO ||--|| ANALISE_VIDEO : "gera"
    SESSAO_EXERCICIO ||--o| SESSAO_DISPOSITIVO : "registra_telemetria"
    USUARIO ||--o{ NOTIFICACAO : "recebe"
    USUARIO ||--o{ MENSAGEM : "troca"
    USUARIO ||--o{ AUDIT_LOG : "gera_trilha"
```

---

## 5. Ambientes Operacionais e Isolamento

A infraestrutura do Sinergia mantém isolamento estrito entre os ambientes de Homologação e Produção, tanto na camada de aplicação quanto na camada de banco de dados e armazenamento de arquivos:

| Camada | Ambiente de Homologação | Ambiente de Produção |
|---|---|---|
| **Branch de Origem** | `develop` | `master` (mediante Pull Request aprovado e Tag SemVer) |
| **Frontend Web (PWA)** | `https://app-hml.sinergiahealth.com.br` | `https://app.sinergiahealth.com.br` |
| **Backend API REST** | `https://api-hml-sinergia.yegear.dev` | `https://api-sinergia.yegear.dev` |
| **Health Check** | `https://api-hml-sinergia.yegear.dev/api/v1/health` | `https://api-sinergia.yegear.dev/api/v1/health` |
| **Container de Banco** | `sinergia-mariadb-homolog` (rede isolada, porta interna/host `8081`) | `sinergia-mariadb` (volume dedicado de produção, porta `8080`) |

Detalhes operacionais sobre deploy contínuo, variáveis de ambiente, proxy reverso Nginx e certificados SSL encontram-se em [ci-cd-ambientes-e-monitoramento.md](ci-cd-ambientes-e-monitoramento.md).
