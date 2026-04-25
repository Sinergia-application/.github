**Data: 11/04/2026**

**RELATÓRIO DE ACOMPANHAMENTO DO PROJETO**

#### **1 Visão Geral do Andamento**

O projeto apresenta uma evolução consistente e encontra-se em estágio funcional avançado. O núcleo de visão computacional já opera na detecção de movimento, e as principais estruturas de software foram consolidadas. O sistema agora conta com uma arquitetura robusta dividida em três frentes: Interface do Usuário (Frontend), API de Gerenciamento (Backend) e Motor de Análise (Worker).

#### **2 Evolução Arquitetural e Decisões Estratégicas**

Durante a execução, algumas decisões técnicas foram tomadas para adequar o sistema a um cenário de produção real, alterando especificações do documento inicial:

- **Migração de BaaS para Backend Próprio (Spring Boot  MariaDB):** Inicialmente, o projeto utilizaria o Supabase para banco de dados e armazenamento. Decidimos migrar para uma API própria em Java (Spring Boot) com banco relacional (MariaDB) e armazenamento. Isso garante maior controle sobre os dados médicos, elimina custos de terceiros com storage na nuvem e centraliza a regra de negócio.  
- **Processamento Assíncrono e Mensageria (RabbitMQ):** Para evitar que o processamento pesado de visão computacional trave a experiência do usuário, implementamos uma arquitetura de produtor/consumidor. A API recebe os dados e enfileira a tarefa, enquanto o Worker Python processa em segundo plano.  
- **Pivô do Aplicativo Mobile para Web SPA (Angular):** A transição de um aplicativo móvel nativo/híbrido (React Native) para uma Aplicação Web de Página Única (SPA) utilizando Angular foi motivada por desafios técnicos críticos e vantagens operacionais:  
  - **Gargalo de Performance:** Durante os testes, identificou-se que a execução do modelo de visão computacional (TensorFlow.js) diretamente no dispositivo do paciente (*on-device*) causava sobrecarga de hardware, resultando em superaquecimento e travamentos severos em celulares comuns.  
  - **Delegação e Visão de Tempo Real:** A migração para a web está atrelada à decisão de remover o processamento do lado do cliente e delegá-lo integralmente ao servidor (Worker). Se o tempo de produção e a latência de rede permitirem, o objetivo é evoluir essa comunicação para *real-time* (via WebSockets ou WebRTC). Assim, o servidor processará o feed de vídeo e devolverá à tela do paciente, instantaneamente, os *landmarks* de correção, feedbacks em áudio, textos de ajuda e contagem de repetições.  
  - **Portabilidade Universal:** O sistema passa a ser acessível a partir de qualquer dispositivo com um navegador web (smartphones, tablets, notebooks ou até smart TVs), sem exigir requisitos mínimos de hardware do lado do cliente.  
  - **Redução de Custos e Burocracia:** O modelo web elimina a dependência das lojas de aplicativos (Google Play Store e Apple App Store). Isso isenta o projeto de taxas de desenvolvedor, remove o tempo burocrático de aprovação de *releases* e garante que todos os pacientes tenham acesso imediato a atualizações e correções de bugs, sem precisar baixar novas versões.

#### **3 Status por Módulo**

**3.1. Motor de Análise e Visão Computacional (Sinergia Worker  Python)**

- **Tecnologias:** Python, OpenCV, MediaPipe, Celery.  
- **Andamento:** Rotinas de processamento de vídeo implementadas com sucesso para captura de *landmarks* corporais e cálculo de ângulos (usando NumPy).  
- **Melhorias:** A lógica inicial baseada em limites fixos de ângulos foi substituída por uma Máquina de Estados Finitos (FSM), contemplando os estados de movimento (*WAITING, DESCENDING, ASCENDING*). Isso resultou em uma precisão muito maior na contagem de repetições.  
- **IA Generativa:** Iniciada a estruturação dos dados processados em formato JSON. Esses dados contêm os acertos e erros biomecânicos, preparando o sistema para enviar essas informações a uma IA Generativa que formulará feedbacks em linguagem natural para o paciente.

**3.2. API de Gerenciamento (Sinergia API  Spring Boot)**

- **Tecnologias:** Java 17+, Spring Boot, Hibernate/JPA, MariaDB, Flyway.  
- **Andamento:** A API atua como a fonte de verdade do sistema. Foram modeladas e implementadas as regras de negócio para separar os perfis de **Pacientes** e **Profissionais de Saúde**.  
- **Funcionalidades Concluídas:** Sistema de autenticação seguro via JWT; gestão de empresas e clínicas; criação de roteiros de exercícios pelos fisioterapeutas; geração de "códigos públicos" e convites para vincular pacientes aos seus respectivos profissionais. A comunicação interna com o Worker via RabbitMQ já está estruturada.

**3.3. Interface do Usuário (Frontend)**

- **Andamento:** A coleta inicial de vídeos e a validação do fluxo foram realizadas através de um protótipo inicial (app). A interface engloba telas de login, perfil, dashboard do paciente (progresso e exercícios pendentes) e dashboard do profissional (acompanhamento de pacientes e atribuição de roteiros). O foco atual é migrar esses componentes mapeados para a nova estrutura Web com Angular.

#### **4 Participação Individual**

- **Adalberto Silva Santana:**  Criação inicial do banco de testes.  
  - Implementação da arquitetura de mensageria com RabbitMQ.  
  - Configuração do Celery para gerenciar as filas de vídeos e enviar as tarefas de processamento para o Worker.  
  - Refatoração da estrutura de pastas do worker, aplicando responsabilidade única e otimizando funções complexas.
- **Luís Felipe de Macêdo Barbosa:**  Implementação da lógica biomecânica e aplicação de *flags* para cada repetição detectada, baseando-se nas regras armazenadas no banco de dados.  
  - Coleta de dados de vídeos e comparação de métricas utilizando o software Kinovea (padrão-ouro em fisioterapia) para validar a precisão anatômica do algoritmo.  
  - Desenvolvimento de testes automatizados e integração para calcular a taxa de acerto e promover a melhoria contínua do modelo.
- **Wallas Aguiar Rocha:**  Responsável pela transição arquitetural (remoção do *Supabase* e adaptação para MariaDB).  
  - Desenvolvimento da API (Backend) e seus endpoints de comunicação, modelagem do banco de dados (Flyway migrations) e fluxos de autenticação.  
  - Criação inicial do protótipo do aplicativo para coleta dos vídeos e comunicação de ponta a ponta com o backend e o worker.

#### **5 Testes Unitários  Worker**

1. #### **Data / Amostra**: 12/04/2026 / 05 testes de validação.    	**Resultados**:

- #### Contagem: Excelente (MAE 0.00).
- #### Angulação: Desvio médio de 17.85º (impacto da ausência de profundidade na visão frontal).
- #### Flags: 0% de acerto / 5 Falsos Positivos (causado por falha de alinhamento nas *strings*).
- #### Visibilidade: 0 frames de oclusões ou quedas de visibilidade detectados.
- #### Desempenho (Inferência): Tempo médio de 48.46s por vídeo.
- #### Desempenho (Processamento): Média de 19.3 FPS no motor do MediaPipe
  #### **Conclusão**: Contagem pronta para uso. O motor de correção técnica precisa de padronização nas nomenclaturas de erro e ajuste de sensibilidade (*thresholds*)

1. #### **Data / Amostra**: 16/04/2026 / 05 testes de validação.    	**Resultados**:

- #### Contagem: Excelente (MAE 0.00).
- #### Angulação: Desvio médio de 17.85º (impacto da ausência de profundidade na visão frontal).
- #### Flags: 0% de acerto / 5 Falsos Positivos (causado por falha de alinhamento nas *strings*).
- #### Desempenho (Inferência): Tempo médio de 48.46s por vídeo.
- #### Desempenho (Processamento): Média de 19.3 FPS no motor do MediaPipe
  #### **Conclusão**: Contagem pronta para uso. O motor de correção técnica precisa de padronização nas nomenclaturas de erro e ajuste de sensibilidade (*thresholds*)





#### **6 Próximos Passos**

O projeto encontra-se tecnicamente preparado para avançar em direção à validação prática e refinamento da experiência do usuário. As próximas metas incluem:

1. **Desenvolvimento do SPA em Angular:** Iniciar a migração das telas e fluxos de usuário mapeados (dashboards, perfis) para a nova estrutura web.
2. **Pesquisa de Baixa Latência (Real-Time):** Investigar e prototipar a transmissão do feed de câmera do navegador para o servidor em tempo real, avaliando a viabilidade de retornar o feedback (áudio, visual e texto) de forma instantânea durante a execução do exercício.
3. **Finalização da Integração com IA Generativa:** Concluir o *pipeline* de envio dos relatórios estruturados (JSON) gerados pelo Worker para a geração de texto de feedback humanizado e compreensível para o paciente.
4. **Validação com Usuários Reais:** Iniciar os testes do sistema com pacientes e fisioterapeutas em ambientes controlados, avaliando a precisão da detecção remotamente e coletando feedbacks para ajustes finais de usabilidade (UX/UI).

