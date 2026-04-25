# Diagramas do Projeto Fisioterapia com IA

## 0. Decisão arquitetural: Spring Boot, MariaDB e armazenamento em disco

### O que mudou em relação à documentação anterior

Versões antigas deste arquivo e de outros materiais descreviam um backend **Python (FastAPI)** com **Supabase** como banco e armazenamento de objetos. A implementação atual da API de produção é **Spring Boot 3**, com **MariaDB** (esquema versionado por **Flyway**) e **ficheiros de vídeo no sistema de ficheiros** (configurável via `STORAGE_PATH`), não via Supabase.

O **worker de análise** continua em **Python** (Celery, MediaPipe, OpenCV, etc.), mas o desenho alvo é integrá-lo à API via **RabbitMQ** e **endpoints internos** (`/api/v1/internal/...`), em vez de ler e gravar diretamente no Supabase.

### Por quê

- **Um único ambiente operacional (VPS ou servidor dedicado):** Pretende-se hospedar **API, worker, RabbitMQ e MariaDB** (e, se necessário, reverse proxy) no mesmo sítio ou na mesma rede privada. Stacks BaaS separadas dificultam custos, latência e políticas de rede quando tudo precisa de correr junto.
- **Controlo de dados e custos:** Base relacional auto-hospedada e disco local (ou volume anexo ao servidor) evitam dependência de quotas e pricing de storage gerido para o fluxo principal de vídeos.
- **Evolução natural para object storage:** Em produção pode substituir-se ou complementar-se o disco por **S3 compatível** (ou disco de blocos na VPS) mantendo o mesmo contrato na API (URLs/paths persistidos em `analise_video`). A mudança fica concentrada na camada de storage, não no modelo de domínio.
- **Separação de responsabilidades mantida:** A API continua a ser o **produtor** do job na fila; o worker continua a ser o **consumidor** da análise pesada; apenas a **fonte de verdade** passou a ser a API + MariaDB + disco (e não o Supabase).

Documentação complementar do contrato API ↔ worker: [INTEGRACAO_API_SPRING.md](https://github.com/Sinergia-application/sinergia-app/blob/main/sinergia-worker/docs/INTEGRACAO_API_SPRING.md) (monorepo [Sinergia-application/sinergia-app](https://github.com/Sinergia-application/sinergia-app), pasta `sinergia-worker/`).

---

## 1. Diagrama de Fluxo: Arquitetura e ciclo de vida

Caminho da informação desde o aplicativo até ao servidor: API Spring Boot, MariaDB, armazenamento em disco, fila RabbitMQ e worker Python.

```mermaid
flowchart TD
    subgraph App [Aplicativo React Native]
        A[Paciente inicia exercício] --> B{Câmera com Vision Camera}
        B --> C[Feedback de esqueleto em tempo real]
        B --> D[Gravação de vídeo]
        D --> E[Upload assíncrono para a API]
    end

    subgraph Server [Servidor — VPS / dedicado]
        subgraph API [API Spring Boot]
            F[Recebe vídeo] --> F2[Grava ficheiro em disco + registo em MariaDB]
            F2 --> G[Publica job na fila RabbitMQ]
        end
        Rabbit[[RabbitMQ]]
        subgraph Worker [Worker Python]
            H[Consome mensagem da fila] --> I[Vídeo e regras via API interna ou volume partilhado]
            I --> J[Análise MediaPipe + regras]
            J --> K[Vídeo de feedback + relatório JSON]
            K --> L[Atualiza análise na API — endpoints internos]
        end
        MariaDB[(MariaDB)]
        Disco[(Disco / volume)]
        F2 --> MariaDB
        F2 --> Disco
        L --> MariaDB
        L --> Disco
    end

    E --> F
    G --> Rabbit
    Rabbit --> H
    L -. opcional / futuro .-> M[Notificação push]
    M --> N[Paciente vê resultado na app]
    MariaDB --> O[Profissional e paciente via API REST]
```

---

## 2. Diagrama de Casos de Uso

Interações principais dos atores (Paciente, Profissional e Sistema) com as funcionalidades da plataforma.

```mermaid
flowchart LR
    %% Atores
    Paciente((Paciente))
    Profissional((Profissional\nda Saúde))
    Sistema((Sistema\nBackend))

    %% Casos de Uso
    subgraph Plataforma [Plataforma de Reabilitação com IA]
        UC1([Visualizar Roteiro de Exercícios])
        UC2([Realizar Exercício Guiado])
        UC3([Consultar Histórico e Feedback])
        UC4([Gerenciar Pacientes])
        UC5([Criar e Atribuir Roteiros])
        UC6([Analisar Desempenho do Paciente])
        UC_Auth([Autenticar no Sistema])
        UC_Sys1([Processar Vídeo e Gerar Análise])
        UC_Sys2([Enviar Notificação])
    end

    %% Relações Paciente
    Paciente --> UC1
    Paciente --> UC2
    Paciente --> UC3
    Paciente --> UC_Auth

    %% Relações Profissional
    Profissional --> UC4
    Profissional --> UC5
    Profissional --> UC6
    Profissional --> UC_Auth

    %% Relações Sistema
    UC2 -. Triggers .-> UC_Sys1
    UC_Sys1 -. Triggers .-> UC_Sys2
    Sistema --> UC_Sys1
    Sistema --> UC_Sys2
    UC_Sys2 -. Notifica .-> Paciente
    UC_Sys1 -. Fornece Dados .-> UC6

```

---

## 3. Diagrama de Classes (Banco de Dados e Entidades)

Estrutura de dados que baseia o **MariaDB** (JPA/Hibernate + migrações Flyway) na API Spring Boot. Os nomes de tabelas/colunas no servidor seguem o modelo físico; aqui o foco é o modelo conceitual.

```mermaid
classDiagram
    class Usuario {
        <<abstract>>
        +UUID id
        +String nome
        +String email
        -String senhaHash
        +DateTime criadoEm
        +autenticar(email, senha) boolean
        +alterarSenha(novaSenha) void
    }

    class Paciente {
    }

    class ProfissionalDaSaude {
    }

    class Roteiro {
        +UUID id
        +String titulo
        +String descricao
        +DateTime criadoEm
        +boolean ativo
    }

    class ItemRoteiro {
        +int ordem
        +int series
        +int repeticoes
        +String observacoes
    }

    class Exercicio {
        +UUID id
        +String nome
        +String descricao
        +String urlVideoDemonstracao
        +JSON regrasAnalise
    }

    class SessaoExercicio {
        +UUID id
        +DateTime dataRealizacao
        +String status
    }

    class AnaliseVideo {
        +UUID id
        +StatusEnum statusAnalise
        +String videoOriginalUrl
        +String videoFeedbackUrl
        +JSON relatorioJson
    }

    class StatusEnum {
        <<enumeration>>
        PENDENTE
        PROCESSANDO
        CONCLUIDO
        ERRO
    }

    Usuario <|-- Paciente
    Usuario <|-- ProfissionalDaSaude

    ProfissionalDaSaude "1" --> "0..*" Paciente : supervisiona
    ProfissionalDaSaude "1" --> "0..*" Roteiro : cria

    Paciente "1" --> "0..*" Roteiro : recebe
    Paciente "1" --> "0..*" SessaoExercicio : realiza

    Roteiro "1" *-- "1..*" ItemRoteiro : contém
    ItemRoteiro "0..*" --> "1" Exercicio : refere-se a

    SessaoExercicio "1" --> "1" ItemRoteiro : executa
    SessaoExercicio "1" --> "1" AnaliseVideo : resulta em
    AnaliseVideo --> StatusEnum

```

---

## 4. Arquitetura do Worker de Análise (Produtor / Consumidor)

Como o aplicativo, a **API Spring Boot** e o **worker Python** se coordenam: fila RabbitMQ, persistência em MariaDB e ficheiros em disco (evolução possível para object storage tipo S3).

```mermaid
flowchart TD
    App((React Native App))

    subgraph Backend [Ecossistema no servidor]
        API[API Spring Boot\nProdutor do job]
        Worker[Worker Python\nCelery / consumidor AMQP]
        Fila[[RabbitMQ\nfila ex. analise.video]]
        MariaDB[(MariaDB)]
        Disco[(Disco / volume\nSTORAGE_PATH)]
    end

    App -- "1. Upload REST" --> API
    API -- "2. Persiste sessão/análise + path do vídeo" --> MariaDB
    API -- "2b. Grava ficheiro de vídeo" --> Disco
    API -- "3. Publica mensagem analiseId + exercicioId" --> Fila
    Fila -- "4. Entrega job" --> Worker
    Worker -- "5a. GET /internal/analises/id/video" --> API
    Worker -- "5b. GET /internal/exercicios/id/regras" --> API
    Worker -- "6. Processamento MediaPipe / OpenCV" --> Worker
    Worker -- "7. Escreve vídeo de feedback + PATCH /internal/analises/id" --> API
    API -- "7b. Atualiza URLs e relatório" --> MariaDB
    Worker -. grava ficheiro em volume partilhado .-> Disco
```

**Nota:** Se API e worker partilharem o mesmo volume (mesmo host ou NFS), o passo 7 pode usar paths acordados sem transferir o vídeo de feedback por HTTP; caso contrário, prevê-se extensão da API (ex. upload interno) ou uso de object storage comum.
