# Planejamento da Aplicação (Logística, Ferramentas e Diagramas)

## 1\. Visão Geral e Logística
Este documento detalha a proposta de arquitetura e o fluxo de trabalho para a aplicação de acompanhamento de exercícios fisioterapêuticos.

### 1.1. Perfis de Usuário (Entidades)

  * **Profissional da Saúde:** Responsável por gerenciar pacientes e seus planos de tratamento.
  * **Paciente:** Executa os exercícios e recebe feedback sobre seu desempenho.

### 1.2. Fluxo básico

1.  O **Profissional da Saúde** cadastra um novo **Paciente** na plataforma.
2.  O **Profissional** monta um "roteiro" de exercícios para o **Paciente**, especificando quais movimentos, número de séries, repetições, etc.
3.  O **Paciente** acessa o aplicativo, visualiza seu roteiro e seleciona um exercício para iniciar.
4.  O **Paciente** realiza o exercício enquanto é gravado pelo aplicativo.
5.  A gravação é analisada pela IA.
6.  O **Paciente** e o **Profissional** recebem um relatório detalhado com um vídeo de feedback.

### 1.3. Questões em Aberto para Definição

  * O **Paciente** poderá realizar exercícios "avulsos", ou seja, que não foram recomendados diretamente por um profissional? (Ex: um catálogo geral de exercícios para prevenção).

## 2\. Requisitos do Sistema

### 2.1. Requisitos Funcionais (RF)

*O que o sistema deve FAZER.*

1.  **Autenticação de Usuários (RF-01):** O sistema deve permitir que usuários (Paciente e Profissional) se cadastrem e façam login de forma segura.
2.  **Gerenciamento de Pacientes (RF-02):** O Profissional deve ser capaz de cadastrar, visualizar, editar e remover seus pacientes.
3.  **Gerenciamento de Roteiros (RF-03):** O Profissional deve poder criar roteiros de exercícios, selecionar movimentos de um catálogo e atribuir esses roteiros aos seus pacientes.
4.  **Visualização de Roteiro (RF-04):** O Paciente deve poder visualizar o roteiro de exercícios atualizado que foi atribuído a ele.
5.  **Execução Guiada de Exercício (RF-05):** O aplicativo deve guiar o Paciente durante a execução de um exercício, exibindo um esqueleto em tempo real para auxiliar no posicionamento.
6.  **Gravação de Vídeo (RF-06):** O aplicativo deve gravar a sessão de exercícios do Paciente.
7.  **Upload de Gravação (RF-07):** O aplicativo deve realizar o upload do vídeo gravado para o servidor em segundo plano.
8.  **Análise de Movimento (RF-08):** O backend deve processar o vídeo para analisar a execução do exercício com base em regras pré-definidas.
9.  **Geração de Feedback (RF-09):** O backend deve gerar um novo vídeo com marcações visuais (certo/errado) e um relatório de dados sobre a performance.
10. **Visualização de Histórico (RF-10):** Pacientes e Profissionais devem poder acessar o histórico de exercícios realizados e seus respectivos relatórios de análise.
11. **Notificação (RF-11):** O sistema deve notificar o Paciente quando a análise de um exercício for concluída.

### 2.2. Requisitos Não Funcionais (RNF)

*Como o sistema deve SER.*

1.  **Desempenho (RNF-01):** O feedback visual (esqueleto) no aplicativo deve rodar em tempo real (mínimo de 20 FPS). A análise no backend, por ser assíncrona, deve ser concluída em tempo hábil (ex: menos de 5 minutos para um vídeo de 1 minuto).
2.  **Usabilidade (RNF-02):** A interface do aplicativo deve ser simples e intuitiva, considerando que pacientes podem ter dificuldades motoras. O portal do profissional deve ser claro e eficiente.
3.  **Segurança (RNF-03):** Os dados dos pacientes são sensíveis (LGPD). A comunicação entre app e servidor deve ser criptografada (HTTPS/WSS). O armazenamento deve ser seguro e com acesso restrito.
4.  **Custo (RNF-04):** Para a fase de protótipo e pesquisa, a infraestrutura deve se basear em serviços que ofereçam planos gratuitos robustos (ex: Supabase).
5.  **Escalabilidade (RNF-05):** A arquitetura do backend (com fila de processamento) deve ser capaz de lidar com um aumento no número de usuários e uploads sem degradar o serviço.
6.  **Disponibilidade (RNF-06):** O sistema deve estar disponível para uso 99% do tempo.
7.  **Precisão da Análise (RNF-07):** A análise de movimento deve ser precisa e confiável, refletindo as regras definidas pelos profissionais da saúde para ser útil na pesquisa e no tratamento.
8.  **Funcionamento Offline Parcial (RNF-08):** O paciente deve ser capaz de gravar uma sessão de exercícios mesmo sem conexão com a internet. O upload deve ser enfileirado e enviado assim que a conexão for restabelecida.


## 3\. Arquitetura Proposta: Modelo Híbrido

A arquitetura combina o processamento no dispositivo (on-device) para uma melhor experiência do usuário com o processamento no servidor (backend) para garantir máxima precisão na análise.

### 3.1. O Frontend: Aplicativo (React Native)

O app é o ponto de contato com o usuário. Suas responsabilidades são:

  * **Feedback Visual Imediato:**

      * Utiliza `react-native-vision-camera` para acesso à câmera.
      * Usa `TensorFlow.js` com o modelo **MoveNet** para desenhar o esqueleto do usuário em tempo real na tela.
      * **Objetivo:** Apenas guiar o posicionamento do usuário, sem análise complexa.

  * **Gravação de Média/Alta Qualidade:**

      * Enquanto exibe o esqueleto, grava um vídeo "limpo" (sem os desenhos) em boa resolução (1080p @ 30fps ou 720 @ 30fps) - analisar disponibilidade de armazenamento.
      * O vídeo é salvo temporariamente no dispositivo do usuário (cache).

  * **Upload em Segundo Plano:**

      * Após o exercício, o app faz o upload do vídeo para o backend.
      * O processo ocorre de forma assíncrona, liberando o usuário para fazer outras coisas no app ou até fechá-lo.

### 3.2. O Backend: Cérebro Analítico (Python)

O servidor é onde a análise científica e o processamento pesado acontecem.

  * **API de Recebimento:**

      * Um endpoint web (criado com `Flask` ou `FastAPI`) recebe os uploads de vídeo.

  * **Fila de Processamento (Essencial):**

      * Para não travar o sistema, os vídeos recebidos são colocados em uma fila de tarefas com `Celery` e `Redis` ou `RabbitMQ`.
      * O app recebe uma resposta instantânea de "recebido, em processamento".

  * **Análise Detalhada:**

      * Processos "workers" pegam os vídeos da fila e executam o algoritmo principal:
        1.  **Extração de Dados:** `MediaPipe Pose` processa o vídeo quadro a quadro, extraindo as coordenadas dos 33 pontos corporais com alta precisão.
        2.  **Lógica Científica:** O código implementa as regras definidas pelos fisioterapeutas (ângulos, velocidades, trajetórias) para validar cada movimento.

  * **Geração de Vídeo com Feedback:**

      * Após a análise, o script usa `OpenCV` ou `moviepy` para gerar um novo vídeo.
      * Este vídeo contém as marcações visuais: esqueleto sobreposto, membros coloridos (verde/vermelho) e textos explicativos.

  * **Armazenamento Persistente (Com Foco em Serviços Gratuitos):**

      * **Dados da Análise e Metadados (Banco de Dados):**

          * Utilizaremos o **Supabase**, que oferece um banco de dados PostgreSQL com um excelente plano gratuito.
          * Ele cuidará dos dados relacionais: perfis de usuário, roteiros de exercícios, e principalmente, os resultados das análises.
          * O Supabase também já inclui **autenticação**, o que facilita muito a criação dos perfis de Paciente e Profissional.
          * No banco, salvaremos: `ID do paciente`, `ID do exercício`, `data`, `link para os vídeos no storage`, e o `JSON com o relatório detalhado da análise`.

      * **Vídeos e Imagens (Armazenamento de Objetos):**

          * A melhor parte é que o próprio **Supabase já vem com um serviço de Storage** compatível com S3.
          * Nosso backend Python fará o upload do vídeo original e do vídeo com feedback para um "bucket" dentro do Supabase Storage.
          * **Vantagem:** Mantém tudo (autenticação, banco de dados e arquivos) no mesmo lugar, simplificando a gestão e o desenvolvimento.

      * **Alternativas de Storage (se necessário):**

          * **Cloudinary:** Focado em mídia, tem um plano gratuito generoso baseado em créditos. Ótimo para manipulação de imagens e vídeos.
          * **Firebase Storage:** O concorrente direto do Supabase Storage, também com um bom plano gratuito.

  * **Notificação:**

      * Ao final de todo o processo, uma notificação push é enviada ao app do paciente.

### 3.3. Diagrama de caso de uso
![caso de uso](https://www.plantuml.com/plantuml/dsvg/TLHDRzj64BtpLqpbGvE30rHEZ288ZB2kxURI5dQJQp5UZgH1bZl4xDAnM_J7j3tqb5FHIw_wOvdbIeGeMo8WSEVZyRqtGxwD2JNrhQ--IYjg2JgF7AgluLp2WfUzulgVzNyKeI6uY8czG8UAq99VYS8Tnnuz_vQh_fRAqo914b1UhX8qhEGIIwZYHmwvhGLqIVGcFNW2_4HHMjf9zf4SHeBVAx3VT-W-BbNwq9oB5uMZonExBajEj27TnESN9_MtzH2lLUNJDFp7pWCo7mnBRuyu17FWqRLT6SkS-PuM77WG38r4g4qHnMfG1hEVqJ65H3F02Dl3c5HPS8mi0Jqq23Uu_hyffRkfRVaDnqGj3ldDFHnTAJva6jUKrd-5PUy5b3gbIC6qDG82dbjE17OVIrSr2ZSE7XCkH0sh8KF1M_QSiEXnqiAxUcRs33xO6c2KOVZlOrOxAihfSLxlpx_956SVjjkWS2s9M6LOctjIj_xiME9ihsq-j5rJQTgfXAkUiP7z-fEXtbOpzZvPmmycR_sliXCWk2HgRcrmiqFS9nPFWLyEm5Ua51oZZZ8VCNvL66Wk8gYJyctFezn7vQT3UHrCO4IrrOdKTXHM4oydXBTypwNjK1Fx5JQoX_fhtQTLGUwJ8R0px23R7JbWm9Y7P-z28WqId-y3tpp4Cahpob7Cd3-iFpUK_JLtx5Y7zPycXcPmz0kvLH0louSdOCfeBy9TTkf7IRnWLvPisbdUgMlowF9WMfEp-reD6obn8gNQ6WV7ntdtzixplVF9phdlZhV-LTNkFfJIbq_4NZqHEvt4fh2FrTYVqdGOpovzVo_FAsCBBrwSZTQ_XZTl82albwGHpiwgJMAdQ7weg22DMb-FhaEKMoLORDuFw5ICLYRwqxWIT4-kJvYjxihexOutQr9jgxBuGkXnQ5u0fvyuwYYOv0O1Dti3HXhjt94VFqzxAa-BGkDnnmr5wqu82z4izQtXzQt_0W00)

### 3.4. Diagrama de Classes
![classes](https://www.plantuml.com/plantuml/svg/ZLJDRXj73BxlKx3k8J-rZRYv58kYY2h9Y8F2CgIu9r-e6KeYF3jSS6OL9saVfkcXw277Fe5Uh3ChhtvaDurqsI7vVUH7SkPLYAYngLpnJLnGHL0xP5yyWRxu6SyRnTLVgtyeW2KOXiXEYd3BlaR52ep347enAa-RI1T6_8G_4BpO2N7iARwl2KJZOXUhqdXhH3qfdEqYmWAjl6C_XwWD7MQ3ZmMatyzeRkSjHL-SA7nx_ZBzpzS-KKjwR_z--BBtGw-rzrJbtKFpQy8K_e1mq1iC4k7lnO8j0LLrV0yLLLFIKAJs36Z6dbDl_XIm6A2VYwC0LyhUS8qSuEdGHxQ9F3mh2fo6g6ZYlOhhqA2oj6g-0xObN5zV3Dg3bufAc4HDBMWDL26x7Si91F8BV8rXiHTdbD7Ai2fXW97USaKv-AJrOHF9HpQeJrkwupN7inAc8exGhwDS94MTPDTJBqkSt0SjXMrgHR4k_WeD9pQ2ZpisbHc7mEBH3N22ZTrpZoKIwwDw8yV6oPuIIo69CIZ_hoyL7Naf6ntRb1UHglsqUIyIcdriZu6KAMpFIZL5Dh9hascAMc8sThLiCmplI0sRhnpZuw8QTR-o9HbG9Jwlo660qbmnz3mw3edmpMHqcIhm4WcKvui8CjiMKiAeZG0ZFgx-ha02rAYhJnL5bN3JtYH8Vx_w8_E15PYcpITlZsyytPMm-kJdZKimT4ivXZhnP9mHhKNpLblApI6b4EWOA9hJhXsJP4BvObCiHXnJal8XwpmOP8WOcqsREv6EPbdZ8Ni9OwgL0lc8q5G8x4DCnHj6i7JZcmhgRarrdT5RIP59PkPOVKuaMKoW1dIz9XibzztEWpcKiQrqEvD9UnocdArtcM6ZD1nE0TUwStKxvpcHpMq_T2evZA8iRuBunsUzLri9_UsSbKBZ8jhqIP1dvjZVjkF7x5wkFYT4W3afsdOLo6s6dvHJRjbMIIlxQdWv65w-7URFyQW_d4nwbuDHElL7b_rVKZVozt0y7kKxyGJ6vD2mUAp8nro6ZqgmVHoBedlsVlpjv6JpZ1nO7puaHV684OxEZY357xquFNr-j2634a9JaowvZOQVlWBRlH8b6EKCAJgs_mnKCZIbpFvuvE5TABibpEmTJOOypvYpZDbxiChk1XSxreuyGJ9qdtr6IYU1eCrmcBuhxkmm2zsHQMB2V06oVntARj60gfngrva0kvUXU4NUDfNx5m00)

## 4\. O "Algoritmo Programado"

É fundamental entender que **não vamos treinar um modelo de IA do zero**. Vamos usar o MediaPipe como uma ferramenta que nos dá os dados brutos, e nossa inteligência será o código que interpreta esses dados.

  * **O que o MediaPipe faz:**

      * Ele olha para um vídeo e nos diz **ONDE** estão os ombros, joelhos, cotovelos, etc., em cada quadro (as coordenadas x, y, z).

  * **O que o NOSSO ALGORITMO faz:**

      * Ele pega essas coordenadas e, usando o conhecimento da fisioterapia que vamos programar, decide **SE** o movimento está correto.
      * Calcula ângulos, verifica posturas, conta repetições e identifica erros com base em regras pré-definidas.
