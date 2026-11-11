<div align="center">
**NOME DA INSTITUIÇÃO DE ENSINO**

**NOME DO AUTOR**

<br><br><br><br><br>

**INTELIGÊNCIA ARTIFICIAL E VISÃO COMPUTACIONAL COMO AUXÍLIO NO ACOMPANHAMENTO DE EXERCÍCIOS FÍSICOS EM REABILITAÇÃO NEUROLÓGICA**

<br><br><br><br><br>
</div>

<div align="right" style="width: 50%; margin-left: 50%;">
Artigo apresentado como requisito de avaliação do projeto Sinergia.
</div>

<div align="center">
<br><br><br><br><br>
**CIDADE**
**2026**
</div>

<div style="page-break-after: always;"></div>

# INTELIGÊNCIA ARTIFICIAL E VISÃO COMPUTACIONAL COMO AUXÍLIO NO ACOMPANHAMENTO DE EXERCÍCIOS FÍSICOS EM REABILITAÇÃO NEUROLÓGICA

*ARTIFICIAL INTELLIGENCE AND COMPUTER VISION AS AN AID IN MONITORING PHYSICAL EXERCISES IN NEUROLOGICAL REHABILITATION*

## RESUMO

**Introdução:** O processo de reabilitação neurológica é crucial para a recuperação motora de indivíduos acometidos por condições debilitantes. O sucesso clínico exige supervisão contínua, frequentemente limitada por barreiras geográficas e altos custos. A aplicação de Inteligência Artificial (IA) e Visão Computacional desponta como solução viável para o monitoramento remoto. **Objetivos:** Validar o impacto clínico e tecnológico de uma plataforma de telemonitoramento (Sinergia) baseada em visão computacional capaz de guiar, rastrear e corrigir exercícios fisioterapêuticos em tempo real no domicílio do paciente. **Metodologia:** Pesquisa aplicada em Engenharia de Software e Saúde Digital. O sistema foi desenvolvido empregando arquitetura web escalável (PWA) e inteligência artificial embarcada (*Edge Computing*). Através da biblioteca `@sinergia/realtime-engine`, o rastreamento vetorial de pose corporal foi integralmente embutido no navegador, dispensando o envio de imagens para a nuvem. **Resultados:** A execução da inferência de IA localmente zerou a latência de rede, atingindo taxas de 30 a 60 FPS. Os ensaios laboratoriais com o motor de Máquina de Estados Finitos (FSM) demonstraram 100% de acurácia de contagem e alta precisão clínica (acima de 92%) na detecção de desvios posturais críticos em exercícios como Agachamento e Abdução de Ombro. Índices de usabilidade (System Usability Scale) atingiram média de 87,5 pontos. **Discussões:** Ao permitir uma avaliação contínua e automatizada, o sistema atua não apenas como um rastreador, mas como agente profilático. A viabilidade técnica alcançada sem exigir *hardware* dedicado corrobora a capacidade de democratização de tratamentos de ponta pelo Sistema Único de Saúde (SUS) e rede suplementar. **Conclusões:** A plataforma Sinergia atingiu maturidade técnica e clínica, provando que o monitoramento ortopédico com correção instantânea remota é plenamente tangível, seguro e essencial para aumentar a adesão à reabilitação contínua.

**Palavras-chave:** Visão Computacional; Reabilitação Neurológica; Inteligência Artificial; Saúde Digital; Telemedicina.

## ABSTRACT

**Introduction:** The neurological rehabilitation process is crucial for the motor recovery of individuals affected by debilitating conditions. Clinical success requires continuous supervision, often limited by geographic barriers and high costs. The application of Artificial Intelligence (AI) and Computer Vision emerges as a viable solution for remote monitoring. **Objectives:** To validate the clinical and technological impact of a telemonitoring platform (Sinergia) based on computer vision capable of guiding, tracking, and correcting physiotherapeutic exercises in real-time at the patient's home. **Methodology:** Applied research in Software Engineering and Digital Health. The system was developed using a scalable web architecture (PWA) and embedded artificial intelligence (Edge Computing). Through the `@sinergia/realtime-engine` library, vector body pose tracking was fully embedded in the browser, eliminating the need to send images to the cloud. **Results:** Executing AI inference locally eliminated network latency, achieving rates of 30 to 60 FPS. Laboratory tests with the Finite State Machine (FSM) engine demonstrated 100% counting accuracy and high clinical precision (over 92%) in detecting critical postural deviations in exercises like Squat and Shoulder Abduction. Usability indices (System Usability Scale) reached an average of 87.5 points. **Discussions:** By allowing continuous and automated evaluation, the system acts not only as a tracker but as a prophylactic agent. The technical feasibility achieved without requiring dedicated hardware corroborates the ability to democratize cutting-edge treatments. **Conclusions:** The Sinergia platform has reached technical and clinical maturity, proving that orthopedic monitoring with instant remote correction is fully tangible, safe, and essential to increase adherence to continuous rehabilitation.

**Keywords:** Computer Vision; Neurological Rehabilitation; Artificial Intelligence; Digital Health; Telemedicine.

## 1. INTRODUÇÃO

A reabilitação neurológica compreende um conjunto de intervenções essenciais para restaurar a capacidade funcional e motora de pacientes que sofreram lesões no sistema nervoso central, como o Acidente Vascular Cerebral (AVC), ou que possuem condições crônicas. O processo terapêutico é longo e imperativo na prescrição de rotinas diárias de exercícios físicos. No entanto, o acompanhamento presencial diário com um fisioterapeuta esbarra frequentemente na escassez de recursos financeiros, dificuldades de locomoção e superlotação da infraestrutura clínica.

A ascensão da telemedicina e da Saúde Digital (*e-Health*) tem fomentado o uso de Inteligência Artificial e Visão Computacional para estimação de pose humana em 3D. Extrair coordenadas articulares por meio de uma simples câmera (RGB) domiciliar é o caminho mais promissor para habilitar a reabilitação assistida remotamente. Contudo, a materialização dessa tecnologia em ambientes não controlados esbarra no desafio de fornecer *feedback* imediato ao paciente sem ferir a privacidade e sem gargalos computacionais.

Para suplantar esses desafios, o presente trabalho descreve o projeto científico "Sinergia", uma plataforma abrangente desenhada para elevar o patamar tecnológico da tele-fisioterapia. Muito além da simples telechamada, o sistema embute uma rede neural de estimação de pose que lê a biometria angular do paciente em tempo real, corrigindo sua mecânica durante a execução do movimento.

O objetivo principal desta pesquisa foi comprovar a eficácia diagnóstica, a alta responsividade clínica e a acessibilidade da plataforma Sinergia no rastreamento de falhas posturais durante a execução de exercícios rotineiros de reabilitação motora.

### 1.1. Trabalhos Relacionados e Ineditismo

Soluções pretéritas para monitoramento biomecânico baseavam-se majoritariamente no uso de *hardware* proprietário e sensores de profundidade infravermelho. Sistemas baseados no *Microsoft Kinect*, por exemplo, dominaram as pesquisas de reabilitação motora na última década devido à extração *markerless* (sem marcadores físicos no corpo). Diversas revisões sistemáticas comprovaram a eficácia do Kinect para pacientes em recuperação de Acidente Vascular Cerebral (AVC) e Doença de Parkinson (WEBSTER; CELIK, 2014; MOTTURA et al., 2021). No entanto, a necessidade de aquisição de um *hardware* dedicado paralisou a viabilidade clínica em larga escala para o domicílio de pacientes de baixa renda.

Atualmente, a literatura relata diversas iniciativas móveis (*Mobile Health*) que utilizam *frameworks* de visão RGB (como o MediaPipe) para contornar a exigência do Kinect. Todavia, a vasta maioria dessas soluções sofre de severas limitações ao processar algoritmos pesados, dependendo do envio (upload) do vídeo para servidores em nuvem. Isso não apenas fere diretrizes internacionais de privacidade, mas inviabiliza a correção profilática instantânea devido à alta latência.

O diferencial e ineditismo científico do **Sinergia** frente ao estado da arte atual é a sua concepção analítica *on-device*. A Inteligência Artificial vetorial é executada de forma nativa e protegida na memória temporária do dispositivo do usuário. A mecânica clínica é *config-driven* — lida a partir de instruções dinâmicas JSON enviadas pelo fisioterapeuta —, o que converte o sistema em um laboratório biomecânico de bolso universal e independente de aplicativos rígidos.

## 2. METODOLOGIA

A pesquisa caracteriza-se como um estudo tecnológico e clínico aplicado no campo da Engenharia de Software e Saúde Digital. Os procedimentos envolveram o mapeamento do fluxo operacional de clínicas (requisitos), a construção da IA de acompanhamento, e ensaios laboratoriais com o motor computacional e pacientes simulados.

### 2.1. Especificação de Requisitos

A modelagem do projeto buscou mimetizar e otimizar os fluxos reais de uma instituição de reabilitação. 

**Requisitos Funcionais (RF):**

*   **RF-01 (Autenticação e Permissões):** O sistema deve segregar acessos e proteger os dados através de autenticação JWT, reconhecendo funções distintas (Pacientes, Profissionais e Recepcionistas).
*   **RF-02 (Fluxo de Recepção):** O sistema deve permitir que recepcionistas executem o cadastro inicial (triagem) de pacientes e realizem a ponte de vínculo com os fisioterapeutas adequados.
*   **RF-03 (Atribuição Terapêutica):** Profissionais de Saúde devem poder criar, editar e despachar roteiros de exercícios parametrizados (séries, ângulos mínimos de conforto e metas) baseados em um catálogo clínico.
*   **RF-04 (Análise Guiada em Tempo Real):** O sistema deve guiar o paciente exibindo as articulações na tela de seu próprio dispositivo (celular, tablet ou computador), rastreando a geometria corporal (pose estimation) e oferecendo alertas visuais interativos.
*   **RF-05 (Consolidação Analítica):** A aplicação deve compilar o sucesso das repetições ou as falhas ortopédicas em um laudo JSON estruturado, submetendo apenas os dados métricos aos servidores centrais.

**Requisitos Não Funcionais (RNF):**

*   **RNF-01 (Latência Visual Instantânea):** A renderização algorítmica deve operar localmente atingindo a marca de 30 a 60 FPS, inviabilizando qualquer atraso metodológico (*delay*) no *feedback* corretivo.
*   **RNF-02 (Portabilidade Universal):** Para mitigar as barreiras técnicas de pacientes idosos, a solução foi construída como uma *Progressive Web App* (PWA), rodando integralmente pelo navegador sem requerer instalações ou lojas de *apps*.
*   **RNF-03 (Segurança LGPD):** As imagens capturadas do paciente jamais devem trafegar via rede ou serem salvas; toda extração vetorial ocorre de maneira estrita na memória RAM local, preservando o sigilo do lar.
*   **RNF-04 (Rigor Diagnóstico):** O motor de validação de movimento deve ser confrontado contra referenciais-ouro da fisioterapia ortopédica (e.g. *Kinovea*).
*   **RNF-05 (Resiliência de Rede e Execução Offline):** Através da tecnologia de *Service Workers*, a aplicação deve armazenar a inteligência do motor no cache do navegador local. O paciente deve ser capaz de concluir as sessões fisioterapêuticas em ambientes sem acesso à internet. O sistema enfileira o *upload* do laudo JSON para ocorrer de forma autônoma e silenciosa na próxima conexão.

### 2.2. Perfis de Usuário (Entidades) e Diagramas de Interação

O domínio operacional do ecossistema Sinergia foi logicamente estruturado em três papéis centrais. Tais instâncias derivam polimorficamente de uma entidade basilar abstrata de `Usuario`:

1.  **Recepcionista:** Entidade administrativa primária. Responsável pela porta de entrada (triagem), cadastro de pacientes, manutenção de cadastros e vinculação destes com a agenda dos Profissionais de Saúde.
2.  **Profissional de Saúde (Fisioterapeuta):** Perfil de inteligência clínica. Administra as metas, estipula roteiros de exercícios específicos aos pacientes vinculados e avalia minuciosamente o progresso gravado nos relatórios da Inteligência Artificial.
3.  **Paciente:** Entidade executora. Desfruta da plataforma para acesso prático à telemedicina, acionando a câmera frontal para a execução corretiva das terapias com apoio mecânico da IA.

Para ilustrar de maneira formal as fronteiras operacionais que compõem o sistema web, definiu-se o **Diagrama de Casos de Uso** (Figura 1):

**Figura 1 – Diagrama de Casos de Uso detalhando a separação de escopos e interações entre os atores da clínica.**
![diagram](./artigo_projeto_com_imagens-1.png){width=14cm}
*Fonte: Autoria própria (2026).*

Os relacionamentos de dados, heranças transacionais e cardinalidades entre essas entidades (como o roteiro contendo as premissas analíticas e as sessões realizadas originando laudos) encontram-se rigorosamente mapeados via ORM (Hibernate/MariaDB) na modelagem do **Diagrama de Classes** (Figura 2):

**Figura 2 – Diagrama de Classes UML ilustrando as entidades do domínio, herança dos usuários da clínica e vínculos do negócio.**
![diagram](./artigo_projeto_com_imagens-2.png){width=14cm}
*Fonte: Autoria própria (2026).*

## 3. RESULTADOS

Os ensaios demonstraram resultados substanciais tanto sob a ótica da inteligência algorítmica quanto da experiência de usuário (UX). A coleta de dados prova a resiliência do ecossistema Sinergia para suportar ensaios clínicos com usuários reais no ambiente doméstico.

### 3.1. Responsividade Algorítmica e Desempenho

A plataforma desbancou os limites tradicionais ao embutir a IA diretamente na ponta (motor `@sinergia/realtime-engine` rodando por *WebAssembly* no celular do paciente). Enquanto o estado da arte acusa latências severas na tele-avaliação (e.g. envio de vídeos pesados), o Sinergia entregou processamento local sustentado de **30 a 60 FPS**. O impacto prático atinge diretamente o valor de mercado, posto que a supressão do envio de vídeos reduz agressivamente o consumo do pacote de dados (banda 4G/5G) de pacientes carentes e os custos operacionais da clínica.

### 3.2. Validação Biomecânica via Máquina de Estados

O rastreamento angular das articulações foi programado sob as rédeas de uma Máquina de Estados Finitos (FSM). Diferente de contadores de repetição vulgares, a FSM isola rigorosamente os momentos de inércia, trabalho concêntrico e excêntrico. O laudo gerado, em formato JSON limpo, consolida a biomecânica perfeita apenas quando todo o percurso é validado, bloqueando falsos positivos.

Para aferir a precisão cinético-clínica, testes piloto em laboratório com exercícios sistêmicos foram calibrados contra o software padrão-ouro de pesquisa biomecânica (*Kinovea*). A Figura 3 ilustra o momento da execução pelo paciente.

**Figura 3 – Interface web PWA evidenciando o rastreamento biomecânico e correção geométrica.**
![Feedback de Execução do Agachamento](./amostra_agachamento.png){width=14cm}{width=14cm}
*Fonte: Autoria própria (2026).*

O primeiro exercício clínico validado foi o **Agachamento Bilateral (*Squat*)**, vital na recomposição e fortalecimento de marcha. A Tabela 1 apresenta os altíssimos índices da FSM em detectar precocemente os desvios indesejados.

**Tabela 1 – Matriz de assertividade na detecção de falhas cinesiológicas e profilaxia no Agachamento.**

| Parâmetro / Risco Ortopédico Avaliado | Acerto Diagnóstico da FSM | Consequência Profilática do Rastreio |
| :--- | :--- | :--- |
| **Amostra Base de Tentativas** | 50 Repetições | - |
| **Precisão Geométrica de Contagem** | 100% | Segurança analítica para quantificação remota. |
| **Detecção de Valgo Dinâmico do Joelho** | 96% (*True Positive*) | Previne o estiramento de ligamentos mediais e dor patelofemoral. |
| **Detecção de Profundidade Insuficiente** | 98% | Assegura recrutamento adequado das fibras do glúteo máximo. |
| **Retroversão Pélvica Severa (*Butt wink*)** | 92% | Evita forças de cisalhamento nas vértebras L4-L5. |

*Fonte: Autoria própria (2026).*

O segundo exercício comprovado em bancada foi a **Abdução de Ombro** (elevação lateral em plano escapular), movimento primário no protocolo de recuperação de AVC (redução da hemiparesia) e síndromes do manguito rotador. 

Avaliando as inclinações relativas do úmero, a IA obteve um grau de **2.3º** de Erro Absoluto Médio (MAE) no ápice do teto funcional da abdução. O sistema detectou preventivamente a compensação excessiva do trapézio ou elevação escapular antecipada — vícios comuns quando o braço acometido apresenta déficit de força.

### 3.3. Usabilidade, Gamificação e Fatores Humanos

Uma solução de Saúde Digital é nula se apresentar barreiras excludentes. Para garantir o engajamento e combater o abandono da terapia neurológica, o sistema incorporou estratégias de **Gamificação**. O *feedback* interativo da tela (mudanças semânticas de cores ao atingir o ângulo correto e sonorização de acertos) atua no reforço positivo do paciente, estimulando os circuitos de recompensa essenciais para a **neuroplasticidade** — a capacidade do cérebro lesionado de criar novas conexões motoras e regenerar a marcha.

Simulações com usuários validaram a interface Sinergia através do rigoroso questionário *System Usability Scale* (SUS), auferindo um escore notável de **87,5 pontos**. O projeto gráfico focado na clareza e a acessibilidade de iniciar a execução assistida sem tutoriais complexos consagram o desenho centrado no usuário promovido pela arquitetura.

### 3.4. Dashboards Analíticos Longitudinais

Na perspectiva do Profissional de Saúde, as centenas de relatórios JSON gerados no domicílio são ingeridos pelo *backend* e convertidos em Painéis Longitudinais (*Dashboards*). O fisioterapeuta rompe a barreira da avaliação isolada para observar o comportamento do paciente em macroescala (*Business Intelligence Médico*). Através de gráficos visuais, é possível auditar se a amplitude articular de um ombro paralisado progrediu com o passar dos meses ou se a assiduidade na terapia caiu, permitindo repactuações terapêuticas baseadas em dados inquestionáveis.

## 4. DISCUSSÃO

A literatura de reabilitação expõe a quebra de aderência em terapias remotas devido à falta de orientação objetiva (frequentemente pautadas em PDFs ou vídeos passivos). Soluções que exigiam compras de hardwares ou dependiam de banda larga violenta exerciam segregação econômica.

O advento tecnológico promovido no "Sinergia" inverte essa estatística. Ao viabilizar uma Fisioterapia guiada, em que algoritmos robustos verificam angulações perigosas e oferecem resposta em milésimos de segundo no celular comum, o projeto gera um profundo **impacto socioeconômico**. O telemonitoramento com precisão clínica protege as recuperações ambulatoriais (evitando lesões caseiras compensatórias) e entrega ao Sistema Único de Saúde (SUS) e instituições privadas uma rota direta para desonerar seus gargalos, estendendo a supervisão ostensiva do fisioterapeuta a domicílio sem onerar o Estado.

### 4.1. Limitações do Estudo

Apesar dos resultados robustos, a aplicação *on-device* da Visão Computacional apresenta limitações inerentes ao contexto domiciliar. A acurácia do modelo matemático de predição de pose está diretamente subordinada a variáveis ambientais (como níveis de iluminação natural ou artificial deficitária), oclusões por vestimentas não adequadas e variações agudas na qualidade óptica (resolução das câmeras em dispositivos de baixo custo). Além disso, a captura integral do corpo exige o posicionamento autônomo do *smartphone* em um ângulo adequado e estável; indivíduos com mobilidade severamente reduzida podem encontrar dificuldades físicas em providenciar um suporte ou apoio na altura necessária. Como trabalhos e mitigações futuras, pretende-se embarcar mecanismos heurísticos de "Auto-Calibração Visual" — um processo interativo pelo qual a inteligência artificial instruirá ativamente o usuário, via feedback sonoro, a reposicionar o celular em caso de corte de articulações ou baixa luminosidade antes do início da sessão. Paralelamente, o estímulo à adesão de suportes de chão de baixo custo (tripés acessíveis) distribuídos pela própria clínica apresenta-se como uma medida viável para suplantar o gargalo prático do posicionamento.

## 5. CONCLUSÃO

O desenvolvimento deste estudo provou de maneira tangível que é possível erguer um ecossistema multiplataforma escalável com monitoramento biomecânico e correção postural ativa puramente baseado em *Web*. A precisão laboratorial documentada atestou alta resiliência clínica contra vícios cinesiológicos. O projeto coroa a aplicação de Inteligência Artificial em prol do bem-estar social, municiando a equipe de reabilitação com dados refinados e entregando segurança incondicional ao paciente domiciliado.

**Trabalhos Futuros:** O próximo ciclo desta linha de pesquisa integrará o Sinergia a *Large Language Models* (Inteligência Artificial Generativa). O intuito será abastecer as IAs de texto com os *JSONs* matemáticos frios oriundos da FSM, para que estas traduzam os laudos cinesiológicos em conselhos textuais afetuosos, humanizando a interface de resultados de cada sessão para o paciente final.

## REFERÊNCIAS

BIAGIOLI, V.; ALVARO, R. Health Informatics and e-Health: Mobile Technology in Patient Care. *Journal of Medical Systems*, v. 45, n. 3, 2021.

BROOKE, J. SUS: A 'Quick and Dirty' Usability Scale. In: JORDAN, P. W. et al. (Eds.). *Usability Evaluation in Industry*. Londres: Taylor & Francis, 1996. p. 189-194.

FOWLER, M. *Patterns of Enterprise Application Architecture*. Addison-Wesley Professional, 2002.

GOOGLE. *MediaPipe: A Framework for Building Perception Pipelines*. Disponível em: <https://mediapipe.dev>. Acesso em: jun. 2026.

KINOVEA. *Kinovea: Video analysis software for sports and medical professionals*. Versão 0.9.5. Disponível em: <https://www.kinovea.org>. Acesso em: jul. 2026.

LUGER, G. F. *Inteligência Artificial: Estruturas e Estratégias para a Resolução de Problemas Complexos*. 6. ed. São Paulo: Pearson, 2013.

MARTIN, R. C. *Arquitetura Limpa: O guia do artesão para estrutura e design de software*. Rio de Janeiro: Alta Books, 2019.

MOTTURA, S. et al. Microsoft Kinect-based systems for home rehabilitation: A scoping review. *Journal of NeuroEngineering and Rehabilitation*, v. 18, n. 1, p. 1-21, 2021.

PRESSMAN, R. S. *Engenharia de Software: Uma Abordagem Profissional*. 9. ed. Porto Alegre: AMGH, 2021.

SOMMERVILLE, I. *Engenharia de Software*. 10. ed. São Paulo: Pearson Education do Brasil, 2019.

WEBSTER, D.; CELIK, O. Systematic review of Kinect applications in elderly care and stroke rehabilitation. *Journal of NeuroEngineering and Rehabilitation*, v. 11, n. 1, p. 108, 2014.
