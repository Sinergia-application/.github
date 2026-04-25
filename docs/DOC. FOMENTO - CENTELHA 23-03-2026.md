**Qual é a solução desenvolvida?**

A solução é o Sinergia, uma plataforma digital baseada em Inteligência Artificial e Visão Computacional para o acompanhamento e análise biomecânica de exercícios fisioterapêuticos voltados à reabilitação neurológica.

a) **Inovação:** O sistema utiliza câmeras convencionais de smartphones para capturar movimentos, dispensando sensores caros. Emprega uma arquitetura híbrida: processamento no dispositivo (MoveNet) para feedback em tempo real e processamento em nuvem (MediaPipe/OpenCV) para análise científica assíncrona profunda.

b) **Funcionalidades:** Conta com um portal web para o profissional da saúde prescrever roteiros de exercícios, um aplicativo mobile para o paciente executar os movimentos guiados por um esqueleto virtual, e um sistema backend que gera relatórios detalhados e vídeos de feedback com marcações de acertos e erros.

c) **Diferenciais:** Foco específico em reabilitação neurológica (AVC, esclerose múltipla), baixo custo de implementação e alta precisão analítica pautada em regras fisioterapêuticas.

d) **Benefícios:** Aumenta a adesão ao tratamento, permite o monitoramento remoto contínuo, democratiza o acesso à reabilitação de qualidade e fornece dados objetivos para a tomada de decisão clínica.

---

## **Estratégia para o desenvolvimento do produto/solução**

**Como você pretende desenvolver a solução para atingir o estágio de desenvolvimento planejado?**

A estratégia baseia-se na construção de um Produto Mínimo Viável (MVP) em ciclos ágeis ao longo de 12 meses.

a) **Recursos necessários:** Infraestrutura em nuvem escalável (MariaDB, RabbitMQ), ferramentas de desenvolvimento mobile (React Native) e bibliotecas de IA open-source.

b) **Estratégia de produção:** Desenvolvimento de software in-house com arquitetura de microsserviços (API Spring Boot e Workers em Python) para garantir escalabilidade.

c) **Pesquisas necessárias:** Coleta de dados com fisioterapeutas para mapear padrões biomecânicos de referência (ex: ângulos de agachamento e abdução de ombro) e validação dos algoritmos de detecção de erros em ambientes clínicos e domiciliares simulados.

d) **Certificações:** Adoção de protocolos de segurança rigorosos para proteção de dados sensíveis de saúde, visando a adequação à LGPD (criptografia, JWT, acesso restrito).

---

# **Impacto**

## **Impacto socioambiental**

### **Descrição do desafio socioambiental**

**Qual o desafio socioambiental que a sua solução se propõe a resolver e os impactos socioambientais positivos gerados?**

(a) O problema central é a inacessibilidade e a descontinuidade do acompanhamento fisioterapêutico para indivíduos com comprometimentos motores severos (AVC, paralisia cerebral). A escassez de profissionais, sobrecarga do sistema de saúde e barreiras financeiras e logísticas impedem a supervisão constante necessária para uma recuperação funcional segura.

(b) Os impactos positivos incluem a democratização do acesso à reabilitação, aumento da autonomia dos pacientes para realizar exercícios em casa com segurança, e a redução do tempo de recuperação funcional. A solução promove a inclusão social e melhora a qualidade de vida de populações vulneráveis.

---

**Quais os potenciais impactos socioambientais negativos a partir de sua operacao? Quais as estrategias para evitar/mitigar tais impactos?**

O principal risco é a execução incorreta de movimentos caso o paciente ignore os feedbacks ou o sistema apresente falhas na detecção, o que poderia causar lesões secundárias. Para mitigar isso, a solução adota uma abordagem de "IA como suporte": os vídeos analisados e os relatórios (JSON) são enviados ao profissional de saúde, mantendo o especialista no centro da tomada de decisão. Além disso, dados de saúde são altamente sensíveis; o impacto de vazamentos será mitigado por meio de comunicação criptografada (HTTPS/WSS) e autenticação robusta.

---

# **Mercado**

## **Descrição do mercado**

**Qual mercado sua solução/negócio pretende atingir?**

O Sinergia atua no mercado de Healthtech, especificamente no segmento de Rehabtech (tecnologias para reabilitação).

a) **Tamanho e abrangência:** O mercado tem potencial de escala nacional e global, considerando o envelhecimento populacional e o aumento de doenças neurológicas.

b) **Tendências:** O setor de telessaúde e monitoramento remoto de pacientes (RPM) encontra-se em forte expansão, impulsionado pela necessidade de descentralizar o atendimento hospitalar.

c) **Testes:** A validação será feita inicialmente em clínicas parceiras e ambientes domiciliares simulados, coletando métricas de precisão dos modelos e engajamento dos usuários.

d) **Canais de venda:** Venda direta B2B (Inside Sales) para clínicas de fisioterapia e parcerias institucionais com redes de saúde e universidades.

---

## **Segmento de clientes**

**Qual o público-alvo da sua solução/negócio?**

a) **Nicho:** Clínicas de fisioterapia, centros de reabilitação e profissionais autônomos de saúde.

b) **Desejos do cliente:** Fisioterapeutas precisam de ferramentas que permitam escalar seu atendimento, monitorar a aderência ao tratamento prescrito e obter dados quantitativos precisos sobre a evolução motora dos pacientes.

c) **Clientes em potencial:** Gestores de clínicas de reabilitação neurológica e traumato-ortopédica.

d) **Público beneficiado:** Os pacientes neurológicos (e seus familiares/cuidadores) são os usuários finais beneficiados pela tecnologia, recebendo maior suporte e independência.

---

# 

# **Modelo de negócio**

## **Qual o modelo de negócio da sua solução?**

**B2B \- Venda para outras empresas**

## **De que forma a sua solução será monetizada?**

A monetização se dará por meio de um modelo SaaS (Software as a Service) com receita recorrente (assinatura mensal/anual) cobrada das clínicas ou profissionais de saúde. Os planos serão escalonados (tiers) com base no volume de análises processadas pelo backend (consumo da API/Worker) ou pelo número de pacientes ativos cadastrados na plataforma. O negócio possui alta escalabilidade tecnológica devido ao uso de filas de processamento em nuvem. A atração de clientes será feita por estratégias de marketing de conteúdo técnico para a área de saúde e programas de parceria com instituições de ensino superior.

---

# **Gestão**

## **Gestão do negócio**

**Como você pretende acompanhar o desempenho do seu negócio?**

A gestão será dividida em métricas de produto e de negócio. Para o produto tecnológico, monitoraremos o tempo de latência do processamento de vídeo assíncrono (meta: \< 5 minutos por gravação), a precisão dos algoritmos na detecção de landmarks e o tempo de *uptime* da infraestrutura em nuvem (meta: 99%). Para o negócio, acompanharemos o Custo de Aquisição de Clientes (CAC), *Lifetime Value* (LTV), e a taxa de pacientes ativos mensais (MAU) no aplicativo. Utilizaremos ferramentas de versionamento de código, esteiras de CI/CD para automação e metodologias ágeis (Scrum/Kanban) para gerenciar as entregas dos times de API, Mobile e Workers de IA.

---

## **Grau de maturidade atual do negócio**

**Identificação do nicho de mercado: definição da abrangência e foco da ideia de negócio em algum nicho potencial de mercado** (Fase de Ideação, com arquitetura técnica e de dados já validada em ambiente de desenvolvimento).

## **Grau de maturidade pretendido do negócio**

Ao final dos 12 meses, pretende-se alcançar a fase de **Operação Inicial/Tração**, com o MVP totalmente desenvolvido, integrado (App, API Spring Boot e Worker Celery) e validado com usuários reais em ambiente clínico.

---

# **Cronograma**

## **Cronograma fisico de atividades \- Desenvolvimento do Produto e do Negócio**

### **Etapa 1**

* **Atividade 1**  
  * **Nome:** Mapeamento Biomecânico e Coleta de Dados.  
  * **Descrição:** Gravações de exercícios com fisioterapeutas para definição dos padrões (ângulos, posturas).  
  * **Indicadores:** Banco de vídeos criado com no mínimo 3 exercícios mapeados e regras JSON definidas.  
  * **Início:** Mês 1 | **Fim:** Mês 2

### **Etapa 2**

* **Atividade 1**  
  * **Nome:** Desenvolvimento da Inteligência e Workers.  
  * **Descrição:** Criação do algoritmo de rastreamento (MediaPipe/OpenCV) e integração com RabbitMQ e banco de dados MariaDB.  
  * **Indicadores:** Worker processando vídeos e atualizando status de testes para "Concluído" em menos de 5 minutos.  
  * **Início:** Mês 3 | **Fim:** Mês 5

### **Etapa 3**

* **Atividade 1**  
  * **Nome:** Desenvolvimento da API e App Mobile.  
  * **Descrição:** Criação da API REST (Spring Boot) e do app React Native com captura em tempo real.  
  * **Indicadores:** Upload de vídeos funcional e roteiros sendo exibidos no app do paciente.  
  * **Início:** Mês 6 | **Fim:** Mês 8

### **Etapa 4**

* **Atividade 1**  
  * **Nome:** Validação Clínica e Testes de Usabilidade.  
  * **Descrição:** Aplicação do sistema com voluntários/pacientes para testar a detecção de erros e UX.  
  * **Indicadores:** Relatório de testes de precisão e questionários de satisfação (NPS) preenchidos.  
  * **Início:** Mês 9 | **Fim:** Mês 11

### **Etapa 5**

* **Atividade 1**  
  * **Nome:** Ajustes Finais e Lançamento do MVP.  
  * **Descrição:** Otimização final baseada em feedbacks e preparação da infraestrutura para escala comercial.  
  * **Indicadores:** Sistema em produção na nuvem com 99% de disponibilidade.  
  * **Início:** Mês 12 | **Fim:** Mês 12

nova:  
**Etapa 1: Validação Alfa e Otimização da Infraestrutura**

**Objetivo:** Testar o sistema desenvolvido em ambiente controlado para garantir estabilidade antes de expor aos utilizadores finais.

**Atividade 1**

* **Nome da Atividade:** Testes de Usabilidade em Ambiente Clínico Controlado.  
* **Descrição da Atividade:** Implantação do Sinergia (App e Portal) em 2 clínicas parceiras para testes com fisioterapeutas (sem pacientes). O objetivo é mapear constrangimentos na usabilidade (UX) e medir o tempo de resposta da nuvem (API e RabbitMQ).  
* **Indicadores da atividade:** Relatório de usabilidade concluído; Correção de 100% dos *bugs* críticos identificados.  
* **Início:** 01/07/2026 | **Fim:** 31/07/2026

**Atividade 2**

* **Nome da Atividade:** Calibragem Fina dos Algoritmos de IA.  
* **Descrição da Atividade:** Ajuste de tolerância de ângulos e redução de falsos positivos no reconhecimento de esqueleto (MediaPipe) com base no *feedback* técnico dos fisioterapeutas parceiros.  
* **Indicadores da atividade:** Aumento da precisão de deteção de movimentos corretos/incorretos para acima de 90%.  
* **Início:** 01/08/2026 | **Fim:** 31/08/2026

---

### **Etapa 2: Lançamento Beta e Validação Domiciliária**

**Objetivo:** Validar a eficácia da solução com os utilizadores finais (pacientes neurológicos) e medir a taxa de envolvimento.

**Atividade 1**

* **Nome da Atividade:** *Onboarding* e Testes de Campo com Pacientes.  
* **Descrição da Atividade:** Libertação da aplicação *mobile* para um grupo piloto de 30 pacientes reais realizarem as suas rotinas domiciliárias, com gravação e processamento real na nuvem.  
* **Indicadores da atividade:** 30 pacientes ativos no sistema; Mínimo de 150 vídeos de exercícios processados com sucesso.  
* **Início:** 01/09/2026 | **Fim:** 30/09/2026

**Atividade 2**

* **Nome da Atividade:** Avaliação de Envolvimento e Desempenho Clínico.  
* **Descrição da Atividade:** Monitorização da taxa de adesão (MAU) dos pacientes e recolha de *feedback* estruturado (NPS) dos gestores e fisioterapeutas sobre o valor dos relatórios gerados.  
* **Indicadores da atividade:** *Net Promoter Score* (NPS) \> 75; Taxa de adesão ao tratamento através da aplicação \> 60%.  
* **Início:** 01/10/2026 | **Fim:** 31/10/2026

---

### **Etapa 3: Segurança de Dados e Propriedade Intelectual**

**Objetivo:** Blindar o negócio juridicamente e tecnologicamente para escalar com segurança no mercado B2B de saúde.

**Atividade 1**

* **Nome da Atividade:** Adequação Avançada à LGPD e Cibersegurança.  
* **Descrição da Atividade:** Implementação de camadas extra de encriptação para os vídeos e dados de saúde no banco MariaDB, gestão rigorosa de consentimento na Aplicação e testes de intrusão (*pentest*) na API Spring Boot.  
* **Indicadores da atividade:** Termos de Utilização e Privacidade validados; Relatório de conformidade LGPD aprovado e sem vulnerabilidades graves.  
* **Início:** 01/11/2026 | **Fim:** 30/11/2026

**Atividade 2**

* **Nome da Atividade:** Registo de *Software* e Propriedade Intelectual.  
* **Descrição da Atividade:** Depósito do código-fonte e algoritmo (Sinergia) no INPI para salvaguarda da propriedade intelectual desenvolvida e proteção face à concorrência no mercado.  
* **Indicadores da atividade:** Certificado de registo de programa de computador (INPI) emitido ou devidamente protocolado.  
* **Início:** 01/12/2026 | **Fim:** 31/12/2026

---

### **Etapa 4: Comercialização (*Go-to-Market*) e Aquisição**

**Objetivo:** Estruturar a máquina de vendas e iniciar a captação de clientes pagantes.

**Atividade 1**

* **Nome da Atividade:** Configuração da Máquina de Vendas B2B e Precificação.  
* **Descrição da Atividade:** Definição final dos planos SaaS (*Tiers* de subscrição baseados em volume de análises) e estruturação do processo de *Inside Sales* focado em gestores de clínicas de reabilitação.  
* **Indicadores da atividade:** *Playbook* de vendas criado; Funil de vendas parametrizado em sistema CRM.  
* **Início:** 01/01/2027 | **Fim:** 31/01/2027

**Atividade 2**

* **Nome da Atividade:** Lançamento Comercial e Marketing de Performance.  
* **Descrição da Atividade:** Execução de campanhas de tráfego pago (Google Ads/Meta) e produção de conteúdo educacional voltado para clínicas e profissionais de saúde, visando atrair interessados (*leads*).  
* **Indicadores da atividade:** Geração de no mínimo 50 *leads* qualificados (MQLs); Mapeamento do Custo de Aquisição de Cliente (CAC).  
* **Início:** 01/02/2027 | **Fim:** 31/03/2027

---

### **Etapa 5: Tração e Expansão**

**Objetivo:** Converter os *leads* em contratos ativos, gerar receita recorrente e finalizar as obrigações do edital.

**Atividade 1**

* **Nome da Atividade:** Fecho de Contratos e Receita Recorrente.  
* **Descrição da Atividade:** Negociação e conversão dos *leads* gerados em clientes pagantes (clínicas e fisioterapeutas independentes), estabelecendo as primeiras linhas de receita do negócio.  
* **Indicadores da atividade:** Mínimo de 5 clientes corporativos (clínicas) pagantes ativos; Receita Mensal Recorrente (MRR) inicial projetada.  
* **Início:** 01/04/2027 | **Fim:** 31/05/2027

**Atividade 2**

* **Nome da Atividade:** Expansão de Funcionalidades e Prestação de Contas.  
* **Descrição da Atividade:** Adição de novos padrões de exercícios ao catálogo com base na procura dos primeiros clientes e elaboração do relatório técnico e financeiro final exigido pela FAPEPI.  
* **Indicadores da atividade:** Catálogo de exercícios da Aplicação expandido; Prestação de contas final do Centelha submetida e aprovada.  
* **Início:** 01/06/2027 | **Fim:** 30/06/2027

---

# **Orçamento \- Plano de Aplicação dos Recursos**

*(Nota: Os valores abaixo são uma sugestão estratégica para distribuir os R$ 80.000 da subvenção, maximizando a produção do software e adequando-se às regras comuns de editais de inovação. Ajuste as rubricas de acordo com as exigências específicas do edital do Centelha/FAP).*

## **Itens de Custeio**

**Custeio 1**

* **Rubrica:** Serviços de Terceiros \- Pessoa Jurídica  
* **Descrição e Justificativa:** Contratação de infraestrutura em nuvem (Servidores, Cloud Storage, Bancos de Dados) necessária para processamento pesado de vídeos e hospedagem da API.  
* **Quantidade:** 12 meses  
* **Valor Unitário:** R$ 1.500,00  
* **Origem do Recurso:** Subvenção  
* **Valor Total:** R$ 18.000,00

**Custeio 2**

* **Rubrica:** Serviços de Terceiros \- Pessoa Física  
* **Descrição e Justificativa:** Consultoria especializada de fisioterapeutas para validação científica das métricas biomecânicas.  
* **Quantidade:** 80 horas  
* **Valor Unitário:** R$ 150,00  
* **Origem do Recurso:** Subvenção  
* **Valor Total:** R$ 12.000,00

**Custeio 3**

* **Rubrica:** Material de Consumo  
* **Descrição e Justificativa:** Licenças de softwares de desenvolvimento e ferramentas de produtividade.  
* **Quantidade:** 1  
* **Valor Unitário:** R$ 5.000,00  
* **Origem do Recurso:** Subvenção  
* **Valor Total:** R$ 5.000,00

## **Itens de Capital**

**Capital 1**

* **Rubrica:** Equipamentos e Material Permanente  
* **Descrição e Justificativa:** Aquisição de estações de trabalho de alto desempenho (Workstations) e dispositivos móveis (smartphones Android/iOS) essenciais para desenvolvimento local, simulação, compilação de código e testes do aplicativo e algoritmos de visão computacional.  
* **Quantidade:** 3  
* **Valor Unitário:** R$ 15.000,00  
* **Origem do Recurso:** Subvenção  
* **Valor Total:** R$ 45.000,00

---

# **Equipe**

## **Domínio da tecnologia**

**Existem conhecimentos-chave, tecnologias de suporte ou know-how que possam ser considerados elementos essenciais para o sucesso da solução proposta?**

O sucesso da solução depende do domínio sólido em Visão Computacional (processamento avançado com OpenCV e MediaPipe para extração de dados 3D), arquitetura de microsserviços e mensageria (Spring Boot e RabbitMQ), além da criação de interfaces de alto desempenho em dispositivos móveis (React Native com Vision Camera). O projeto ganha viabilidade técnica através de uma forte base acadêmica conectada à prática de mercado, apoiada pela estrutura e orientação metodológica no ambiente universitário.

---

## **Constituição da equipe executora**

**A equipe executora domina plenamente as tecnologias necessárias para o desenvolvimento da solução?**

A equipe fundadora é altamente técnica e complementar:

1. **Desenvolvedor Full-Stack e Especialista em Dados:** Focado na arquitetura robusta de dados, orquestração de APIs e sistemas assíncrono.  
2. **Especialistas em IA e Visão Computacional:** Responsáveis por traduzir regras fisioterapêuticas para algoritmos programados usando tecnologias modernas, garantindo a precisão dos cálculos de ângulos articulares.

Sempre focando na construção e integração das ferramentas de detecção em tempo real para feedback instantâneo na plataforma.

---

# **Resumo do negócio**

O Sinergia é uma plataforma B2B em saúde digital que transforma a câmera de um smartphone comum em um assistente inteligente de fisioterapia. Focado na reabilitação neurológica, o sistema permite que profissionais da saúde prescrevam rotinas de exercícios que os pacientes executam em casa, com a orientação de um guia visual no aplicativo. Em background, algoritmos de Inteligência Artificial e Visão Computacional avaliam biomecanicamente o movimento gravado, gerando vídeos comentados e relatórios de desempenho precisos. Viabilizado por uma arquitetura em nuvem acessível e escalável, o negócio democratiza tratamentos fisioterapêuticos contínuos, fornecendo às clínicas uma ferramenta inovadora para expandir seus atendimentos remotamente com segurança e objetividade.

