**UNIVERSIDADE ESTÁCIO DE SÁ**  
Ciências Da Computação  
Campus Teresina

Orientador: Dr. Helldânio Muniz Barros  
Matrícula: 3801175

**Inteligência Artificial e Visão Computacional como Auxílio no Acompanhamento de Exercícios Físicos em Reabilitação Neurológica**

**Teresina \- PI**  
**2025**  
**A pesquisa envolve a participação direta ou indireta de seres humanos ou experimento com animais?**  ( ) SIM | (x) NÃO

**Iniciação**: (x) Científica | ( )Tecnológica

**Áreas de concentração e linhas de pesquisa:**  
6 \- Biologia Computacional  
23 \- Fisioterapia Neurofuncional, Cardiorrespiratória, Traumato Ortopedia  
e Reumatofuncional: Atenção Primária, Ambulatorial e Hospitalar  
20 \- Atuação Fisioterapêutica na Saúde do Idoso  
13 \- Interface Homem Máquina

* **RESUMO**

Com os avanços recentes em inteligência artificial (IA) e visão computacional, surge uma nova gama de possibilidades para aplicação dessas tecnologias na área da saúde, especialmente na reabilitação física. Indivíduos com comprometimentos motores causados por doenças neurológicas — como acidente vascular cerebral (AVC), paralisia cerebral ou esclerose múltipla — necessitam de supervisão constante durante a realização de exercícios fisioterapêuticos para garantir a execução correta dos movimentos e obter os melhores resultados. Porém, essa supervisão contínua nem sempre é possível devido à escassez de profissionais ou às limitações financeiras dos pacientes. Estudos indicam que a utilização de sistemas de visão computacional, aliados a algoritmos de aprendizado de máquina, pode oferecer feedbacks automatizados e em tempo real, facilitando a execução correta dos exercícios (ZHOU et al., 2025).  
Este projeto propõe o desenvolvimento de um sistema inteligente baseado em IA e visão computacional, capaz de acompanhar, analisar e fornecer feedback em tempo real sobre a execução dos exercícios por pacientes em reabilitação neurológica. A proposta é utilizar apenas uma câmera convencional e bibliotecas de código aberto como OpenCV e MediaPipe, garantindo baixo custo e acessibilidade, inclusive para uso em domicílio.   
A metodologia contempla a coleta e análise de dados de referência com movimentos corretos, usados para treinar modelos de aprendizado de máquina. Esses modelos reconhecerão padrões biomecânicos específicos dos exercícios analisados. O sistema será testado com usuários reais para verificar sua capacidade de identificar desvios posturais e fornecer orientações corretivas automatizadas.   
Espera-se que o projeto promova maior adesão aos tratamentos fisioterapêuticos, amplie a autonomia dos pacientes e fortaleça a integração entre tecnologia e saúde. Além disso, objetiva-se estimular a continuidade dos tratamentos fora do ambiente clínico e colaborar com a prática profissional da fisioterapia por meio de soluções digitais inteligentes.

* **JUSTIFICATIVA DO TEMA E PROBLEMA DA PESQUISA**

O processo de reabilitação neurológica é fundamental para a recuperação funcional de indivíduos acometidos por doenças como AVC, paralisia cerebral e esclerose múltipla. Essas condições frequentemente afetam a coordenação motora, o equilíbrio e a mobilidade, exigindo um acompanhamento contínuo por profissionais da fisioterapia para garantir que os exercícios sejam executados de forma correta e segura. No entanto, esse acompanhamento presencial muitas vezes não é viável, seja pela escassez de profissionais, pela sobrecarga dos sistemas de saúde ou pelas dificuldades financeiras e logísticas enfrentadas pelos pacientes. A literatura recente mostra que tecnologias de inteligência artificial têm avançado significativamente no apoio à reabilitação, com a capacidade de personalizar tratamentos e monitorar pacientes de forma remota (DE CANNIÈRE et al., 2025).  
Diante desse cenário, surge a necessidade de soluções alternativas e tecnológicas que possam complementar o trabalho dos fisioterapeutas, tornando o processo de reabilitação mais acessível, contínuo e eficaz. O uso de tecnologias como inteligência artificial (IA) e visão computacional representa uma alternativa viável e promissora, permitindo a análise automatizada de movimentos e fornecimento de feedbacks em tempo real, com o uso de dispositivos simples, como uma câmera convencional.   
Apesar dos avanços na IA, ainda são escassas as aplicações práticas voltadas à fisioterapia, especialmente no contexto da reabilitação neurológica. Este projeto justifica-se pela urgência de democratizar o acesso à reabilitação, promovendo autonomia para pacientes realizarem exercícios com supervisão tecnológica remota e ampliando o alcance das terapias para além dos consultórios. Além disso, o projeto pode contribuir significativamente para o avanço das pesquisas em saúde digital e para o desenvolvimento de ferramentas de apoio ao trabalho clínico.

* **OBJETIVOS**  
  * Estudar os princípios biomecânicos de exercícios fisioterapêuticos utilizados em pacientes com comprometimentos neurológicos.   
  * Coletar e organizar dados de referência com execuções corretas dos exercícios.   
  * Se preciso, treinar modelos de aprendizado de máquina para reconhecer padrões de movimentos.   
  * Integrar bibliotecas como OpenCV e MediaPipe para captura e análise de movimentos por vídeo.   
  * Validar o sistema com usuários reais, testando sua eficácia na detecção de erros posturais.   
  * Avaliar a experiência dos usuários quanto à usabilidade e à contribuição do sistema no processo de reabilitação.   
  * Gerar um protótipo funcional de baixo custo e de fácil utilização, aplicável em clínicas e ambientes domiciliares.

* **METODOLOGIA**  
1. **Levantamento e estudo técnico:**

Será realizada uma revisão bibliográfica sobre os exercícios mais utilizados na reabilitação neurológica, bem como sobre as aplicações de IA e visão computacional em fisioterapia. Também serão analisados os requisitos técnicos para a implementação do sistema, com foco em soluções de baixo custo.

2. **Coleta de dados e definição dos padrões biomecânicos:**

Com o apoio de fisioterapeutas, serão gravadas sessões de exercícios com indivíduos executando os padrões de movimentos que desejamos que sejam analisados, utilizando uma câmera convencional. Essas gravações serviram de base para identificar os pontos-chave do movimento (como ângulos articulares e alinhamentos corporais) e alimentar os modelos de IA.

3. **Desenvolvimento do sistema de análise (Algoritmo):**

Utilizando as bibliotecas OpenCV e MediaPipe, será criado um sistema de captura e rastreamento de movimentos corporais. Esses dados serão comparados aos padrões de referência para detectar desvios ou falhas. A IA, treinada com dados supervisionados, classifica os movimentos como adequados ou inadequados, emitindo feedbacks automatizados de melhoria caso seja necessário, e seja do desejo do usuário.

4. **Criação da aplicação mobile:**

Será desenvolvido um MVP (Minimum Viable Product) para dispositivos móveis, permitindo a interação do usuário com o sistema de análise de movimentos. A aplicação exibirá os exercícios propostos, gravará a execução dos movimentos utilizando a câmera do dispositivo e, ao término da atividade, apresentará o vídeo da gravação com marcações e feedbacks sobre os pontos de acerto e correção. Além disso, os dados capturados serão armazenados, compondo um histórico de desempenho que permitirá o acompanhamento da evolução do paciente ao longo do tempo. Tecnologias como Flutter ou React Native poderão ser utilizadas para garantir a compatibilidade entre plataformas Android e iOS, priorizando uma interface intuitiva e de fácil navegação.

5. **Validação com usuários:**

O protótipo será testado com pacientes e/ou voluntários em ambientes controlados (clínicas, laboratórios ou ambientes domiciliares simulados). Os testes avaliaram a precisão da detecção de movimentos incorretos, a clareza dos feedbacks e a aceitação do sistema pelos usuários.

6. **Análise dos resultados e ajustes:**

Os dados coletados nos testes serão utilizados para refinar os algoritmos e a interface do sistema. Serão feitos ajustes técnicos visando melhorar a precisão e usabilidade. Ao final, será entregue um protótipo validado, acompanhado de relatório técnico e científico.

* **FUNDAMENTAÇÃO TEÓRICA**

A integração entre inteligência artificial (IA) e visão computacional na área da saúde tem sido amplamente estudada e demonstrado grande potencial para transformar a prática clínica, especialmente na reabilitação neurológica. Segundo Mendes Neto et al. (2023), a IA proporciona um avanço significativo ao permitir a personalização dos tratamentos fisioterapêuticos, adaptando-os às necessidades específicas de cada paciente e possibilitando uma melhor adesão ao tratamento.

A visão computacional, por sua vez, atua como um recurso técnico essencial para a captura e análise de movimentos corporais. De acordo com a Universidade Estadual Paulista (2023), essa tecnologia é capaz de extrair informações biomecânicas detalhadas a partir de vídeos, possibilitando o acompanhamento preciso dos padrões de movimento em pacientes acometidos por disfunções neurológicas. Essa abordagem é particularmente relevante em um cenário onde a demanda por serviços de reabilitação supera a disponibilidade de profissionais capacitados.

O uso de bibliotecas de código aberto, como o OpenCV e o MediaPipe, tem democratizado o acesso a essas tecnologias, permitindo o desenvolvimento de soluções de baixo custo e alta eficiência. Conforme exposto por Neuroson (2024), essas ferramentas viabilizam a criação de sistemas que capturam dados corporais em tempo real e fornecem feedbacks automáticos, ampliando as possibilidades de reabilitação remota e autônoma. Assim, é possível oferecer suporte tecnológico contínuo aos pacientes, mesmo fora do ambiente clínico.

Além disso, a utilização de algoritmos de aprendizado de máquina para análise dos dados capturados pela visão computacional proporciona uma avaliação mais objetiva dos exercícios realizados. De acordo com o Diário do Minho (2024), a aplicação de algoritmos permite não apenas identificar desvios nos movimentos, mas também personalizar o plano de tratamento com base no desempenho individual, melhorando os resultados terapêuticos.

A reabilitação neurológica, conforme destaca Cunha (2017), é um processo que exige rigor na execução dos exercícios para garantir a recuperação funcional. A ausência de supervisão adequada pode comprometer seriamente os resultados, prolongando o tempo de recuperação ou mesmo resultando em lesões secundárias. Portanto, a automação da análise de movimentos surge como uma solução viável para garantir a correção dos exercícios sem a necessidade da presença física constante de um fisioterapeuta.

Zhou et al. (2025) ressaltam que a análise automatizada dos movimentos deve considerar parâmetros biomecânicos como ângulos articulares, alinhamento postural e fluidez do movimento, uma vez que esses elementos são fundamentais para avaliar a execução correta dos exercícios fisioterapêuticos. O sistema proposto neste projeto, ao utilizar essas métricas, busca não apenas detectar falhas, mas também oferecer orientações corretivas em tempo real.

Embora a IA e a visão computacional tragam inúmeros benefícios, é necessário considerar os desafios técnicos relacionados à sua implementação, tais como a variabilidade dos ambientes de gravação e as diferenças antropométricas entre os indivíduos. Segundo a Universidade Estadual Paulista (2023), esses fatores podem influenciar a precisão dos sistemas de reconhecimento de movimento, exigindo modelos robustos e adaptáveis.

Por fim, destaca-se que o avanço de tecnologias acessíveis na área da saúde contribui diretamente para a democratização dos tratamentos, tornando-os mais inclusivos e acessíveis a populações que, tradicionalmente, enfrentam barreiras para o acesso à reabilitação de qualidade. De acordo com Mendes Neto et al. (2023), a IA e a visão computacional representam inovação tecnológica e oportunidade de transformação social na área da saúde, proporcionando novos caminhos para a otimização de tratamentos e a melhoria na qualidade de vida dos pacientes.

Assim, fundamenta-se a relevância do desenvolvimento de um sistema de acompanhamento de exercícios fisioterapêuticos utilizando IA e visão computacional, focado na acessibilidade, precisão e autonomia do paciente em reabilitação neurológica.

* **VIABILIDADE ECONÔMICO-FINANCEIRA**

O projeto apresenta alta viabilidade econômico-financeira, pois não demandará investimentos financeiros diretos para sua execução. Todos os recursos necessários, como equipamentos de gravação (câmera convencional), computadores para processamento e desenvolvimento de software, além dos ambientes para testes, serão disponibilizados por meio da infraestrutura já existente na instituição e pelos colaboradores envolvidos.

As tecnologias utilizadas, como as bibliotecas OpenCV e MediaPipe, são de código aberto e gratuitas para uso acadêmico e de pesquisa, o que elimina custos com licenciamento de software. Da mesma forma, a coleta de dados e os testes com usuários serão realizados com o apoio de voluntários, sem a necessidade de contratação de serviços externos.

Assim, o projeto se mostra economicamente viável, podendo ser desenvolvido integralmente com os recursos humanos e materiais já disponíveis, garantindo baixo custo e alta acessibilidade para futuros usuários.

* **CRONOGRAMA GERAL**  
  	

| Etapa | Atividades | Período |
| ----- | ----- | ----- |
| Levantamento e estudo técnico | Revisão bibliográfica sobre reabilitação neurológica, IA e visão computacional; análise de requisitos técnicos e soluções de baixo custo.  | 2 Meses |
| Coleta de dados e definição dos padrões | Gravações dos exercícios com fisioterapeutas; definição dos padrões biomecânicos (ângulos, posturas corretas).  | 2 Meses |
| Desenvolvimento do sistema de análise | Criação do algoritmo de rastreamento de movimentos utilizando OpenCV e MediaPipe; treinamento inicial dos modelos de IA.  | 2 Meses |
| Criação da aplicação mobile | Desenvolvimento do MVP (Minimum Viable Product) para Android/iOS; integração com o sistema de análise de movimentos.  | 2 Meses |
| Testes preliminares e ajustes internos | Testes internos do sistema de análise e da aplicação mobile; ajustes iniciais para otimizar desempenho e usabilidade.  | 1 Mês |
| Validação com usuários | Testes do sistema com pacientes/voluntários; coleta de dados sobre a eficácia da detecção de movimentos e clareza dos feedbacks.  | 1 Mês |
| Análise dos resultados e ajustes finais | Ajustes finais nos algoritmos e na aplicação com base nos testes; elaboração do relatório técnico e científico; preparação para entrega do protótipo final.  | 1 Mês |

* **REFERÊNCIAS BIBLIOGRÁFICAS**

MENDES NETO, A.; SOUZA, B. H.; MARQUES, E. M.; VINHATI, L. P.; ABREU, J. R. G. O impacto da inteligência artificial nos tratamentos fisioterapêuticos. *PRÁXIS EM SAÚDE*, v. 1, n. 1, 2023\. Disponível em: [https://revistas.ceeinter.com.br/praxisemsaude/article/download/1303/1119/5988](https://revistas.ceeinter.com.br/praxisemsaude/article/download/1303/1119/5988).

CUNHA, M. Usando a tecnologia para a reabilitação neurológica. *LinkedIn*, 2017\. Disponível em: [https://pt.linkedin.com/pulse/usando-tecnologia-para-reabilita%C3%A7%C3%A3o-neurol%C3%B3gica-monteiro-cunha](https://pt.linkedin.com/pulse/usando-tecnologia-para-reabilita%C3%A7%C3%A3o-neurol%C3%B3gica-monteiro-cunha).

NEUROSON. Inteligência Artificial na Fisioterapia Neurofuncional: Presente e Futuro. *Neuroson*, 2024\. Disponível em: [https://neuroson.com.br/inteligencia-artificial-na-fisioterapia-neurofuncional-presente-e-futuro/](https://neuroson.com.br/inteligencia-artificial-na-fisioterapia-neurofuncional-presente-e-futuro/).

UNIVERSIDADE ESTADUAL PAULISTA (UNESP). Uma combinação da visão computacional e inteligência artificial para auxiliar na reabilitação de pacientes com AVC. *Repositório UNESP*, 2023\. Disponível em: [https://repositorio.unesp.br/items/ee000335-47b2-40e3-86d7-68d7c06294e8](https://repositorio.unesp.br/items/ee000335-47b2-40e3-86d7-68d7c06294e8).

DIÁRIO DO MINHO. Fisioterapia e inteligência artificial: o uso de algoritmos para personalizar tratamentos. *Diário do Minho*, 2024\. Disponível em: [https://www.diariodominho.pt/opiniao/2024-08-22-fisioterapia-e-inteligencia-artificial-o-uso-de-algoritmos-para-personalizar-tratamentos-66c61186e169b.](https://www.diariodominho.pt/opiniao/2024-08-22-fisioterapia-e-inteligencia-artificial-o-uso-de-algoritmos-para-personalizar-tratamentos-66c61186e169b)

ZHOU, Y.; RASHID, F. A. N.; MAT DAUD, M.; HASAN, M. K.; CHEN, W. Machine Learning-Based Computer Vision for Depth Camera-Based Physiotherapy Movement Assessment: A Systematic Review. Sensors, v. 25, n. 5, p. 1586\. Disponível em: [https://doi.org/10.3390/s25051586.](https://doi.org/10.3390/s25051586)

* **IDENTIFICAÇÃO**  
  ---

  * Nome Completo: Adalberto Silva Santana  
  * CPF: 100.696.163-10  
  * E-mail: adalbertosantana501@gmail.com  
  * Matrícula: 202203259091  
  * Coeficiente de rendimento acumulado ( CRA ): 8,9  
  * Campus: Estácio de Sá  
  * Endereço do Currículo Lattes:[https://lattes.cnpq.br/1159352959351316](https://lattes.cnpq.br/1159352959351316)  
  * Curso: Ciências Da Computação  
  * Modalidade do curso: Presencial  
  * Previsão de conclusão do curso: 5/2026  
  * Nunca participou de nenhuma iniciação científica  
  * Possui outros descontos  
  * Deseja permanecer como voluntário  
* **PLANO DE ATIVIDADE DO ALUNO**  
  * Título Do Plano De Trabalho: Aplicação de Visão Computacional na Coleta de Dados para Reabilitação Neurológica   
  * Metodologia: O projeto será desenvolvido em sete etapas: inicialmente, será realizada uma revisão bibliográfica sobre métodos de reabilitação neurológica. Na sequência, ocorrerá a coleta de dados e gravação de vídeos com fisioterapeutas para definição dos padrões de movimentos. A partir dos dados, será criado um sistema de análise para validar a qualidade dos frames capturados. Em seguida, haverá a criação do aplicativo mobile integrando o sistema de rastreamento, permitindo captura de vídeo ao vivo. Posteriormente, serão realizados testes internos e ajustes de usabilidade (UX/UI). O sistema será validado com usuários reais, coletando feedbacks. Por fim, ocorrerá a análise dos resultados e a otimização do sistema baseado nas observações finais.  
  * Cronograma De Atividades:   
    * Título Da Etapa: Revisão Bibliográfica e Levantamento De Soluções Técnicas.   
    * Data De Início e Fim: 01/08/2025 \- 30/09/2025  
    * Descrição Da Etapa: Pesquisa e resumo de artigos sobre reabilitação neurológica e seus métodos atuais.

    * Título Da Etapa: Coleta de Dados e Definição dos Padrões.  
    * Data De Início e Fim: 01/10/2025 \- 30/11/2025  
    * Descrição Da Etapa: Organização das sessões de gravação com fisioterapeutas; gravação dos vídeos dos exercícios.  
        
    * Título Da Etapa: Desenvolvimento do Sistema de Análise.  
    * Data Início e Fim:  01/12/2025 \- 31/01/2026  
    * Descrição Da Etapa: Testar o pipeline de coleta de imagens e vídeos para assegurar a qualidade dos dados de entrada, realizando validações manuais dos frames capturados e reportando eventuais inconsistências para ajustes no sistema de rastreamento.  
        
    * Título Da Etapa: Criação da Aplicação Mobile  
    * Data Início e Fim:  01/02/2026 \- 31/03/2026  
    * Descrição Da Etapa: Integração do algoritmo de rastreamento no app; implementação da captura de vídeo ao vivo.  
        
    * Título Da Etapa: Testes Preliminares e Ajustes Internos  
    * Data Início e Fim: 01/04/2026 \- 30/04/2026  
    * Descrição Da Etapa: (Apoio à Luis) Realizar testes de performance do sistema de rastreamento; identificar bugs no app; propor melhorias de UX/UI  
        
    * Título Da Etapa:  Validação com Usuários  
    * Data Início e Fim: 01/05/2026 \- 31/05/2026  
    * Descrição Da Etapa: Organizar a aplicação dos testes com voluntário; coleta dos feedbacks através de questionários   
        
    * Título Da Etapa: Análise dos Resultados e Ajustes Finais  
    * Data Início e Fim: 01/06/2026 \- 31/07/2026  
    * Descrição Da Etapa: Otimizar o algoritmo de rastreamento e a IA baseada nos testes finais.

---

* Nome Completo: Luís Felipe de Macedo Barbosa  
  * CPF: 067.916.363-86  
  * E-mail: pogdopogdopogchamp@gmail.com  
  * Matrícula: 202203259091  
  * Coeficiente de rendimento acumulado ( CRA ): 8,92  
  * Campus: Estácio de Sá  
  * Endereço do Curriculo Lattes: [http://lattes.cnpq.br/1880628036548492](http://lattes.cnpq.br/1880628036548492)  
  * Curso: Ciências Da Computação  
  * Modalidade do curso: Presencial  
  * Previsão de conclusão do curso: 5/2026  
  * Nunca participou de nenhuma iniciação científica  
  * Possui outros descontos  
  * Deseja permanecer como voluntário  
* **PLANO DE ATIVIDADE DO ALUNO**  
  * Título Do Plano De Trabalho: Implementação de Inteligência Artificial para Análise de Movimentos na Fisioterapia  
  * Metodologia: O projeto seguirá sete etapas: começando pela revisão bibliográfica sobre aplicações de inteligência artificial na fisioterapia, seguida da coleta de dados para definição dos padrões ideais de movimento. Na etapa de desenvolvimento, serão avaliadas e implementadas soluções de IA para o rastreamento de padrões, conforme a necessidade identificada. Após a criação do app mobile em colaboração com outros membros, serão feitos testes preliminares de performance e UX/UI. Em seguida, o sistema será validado com usuários reais, analisando a eficácia do rastreamento. Por fim, será feita a análise crítica dos resultados e a finalização da documentação científica do projeto.  
  * Cronograma De Atividades:   
    * Título Da Etapa: Revisão Bibliográfica e Levantamento De Soluções Técnicas.   
    * Data De Início e Fim: 01/08/2025 \- 30/09/2025  
    * Descrição Da Etapa: Pesquisa e resumo de materiais sobre o uso de Inteligência Artificial aplicada à fisioterapia.

    * Título Da Etapa: Coleta de Dados e Definição dos Padrões.  
    * Data De Início e Fim: 01/10/2025 \- 30/11/2025  
    * Descrição Da Etapa: Análise dos vídeos capturados para identificação dos ângulos ideais e posições corretas.  
        
    * Título Da Etapa: Desenvolvimento do Sistema de Análise.  
    * Data Início e Fim:  01/12/2025 \- 31/01/2026  
    * Descrição Da Etapa:  Avaliar a necessidade de implementar modelos de IA para identificar padrões de movimento. Caso seja identificado que o rastreamento convencional não atende aos requisitos do projeto, proceder com a implementação e treinamento inicial desses modelos, utilizando os dados coletados.​  
        
    * Título Da Etapa: Criação da Aplicação Mobile  
    * Data Início e Fim:  01/02/2026 \- 31/03/2026  
    * Descrição Da Etapa: (Apoio à Adalberto) Integração do algoritmo de rastreamento no app; implementação da captura de vídeo ao vivo.  
        
    * Título Da Etapa: Testes Preliminares e Ajustes Internos   
    * Data Início e Fim: 01/04/2026 \- 30/04/2026  
    * Descrição Da Etapa: Realizar testes de performance do sistema de rastreamento; identificar bugs no app; propor melhorias de UX/UI  
        
    * Título Da Etapa:  Validação com Usuários  
    * Data Início e Fim: 01/05/2026 \- 31/05/2026  
    * Descrição Da Etapa: Análise dos dados coletados; avaliação da eficiência do rastreamento e da clareza do feedback dado pelo sistema  
        
    * Título Da Etapa: Análise dos Resultados e Ajustes Finais  
    * Data Início e Fim: 01/06/2026 \- 31/07/2026  
    * Descrição Da Etapa: Redigir o relatório técnico e científico final; compilar toda a documentação (vídeos, dados coletados, protocolos).

---

* Nome Completo: Wallas Aguiar Rocha  
  * CPF: 074.370.833-45  
  * E-mail: rochaaguiar2016@gmail.com  
  * Matrícula: 202203573012  
  * Coeficiente de rendimento acumulado ( CRA ): 9,4  
  * Campus: Estácio de Sá  
  * Endereço do Curriculo Lattes: [https://lattes.cnpq.br/4788434660182957](https://lattes.cnpq.br/4788434660182957)   
  * Curso: Ciências Da Computação  
  * Modalidade do curso: Presencial  
  * Previsão de conclusão do curso: 5/2026  
  * Nunca participou de nenhuma iniciação científica  
  * Possui outros descontos  
  * Deseja permanecer como voluntário	  
* **PLANO DE ATIVIDADE DO ALUNO**  
  * Título Do Plano De Trabalho: Desenvolvimento de Algoritmo de Rastreamento de Movimento Aplicado à Reabilitação Neurológica  
  * Metodologia: O desenvolvimento será dividido em sete etapas: inicialmente será feita a pesquisa de bibliografias e análise de ferramentas de visão computacional (OpenCV e MediaPipe). Em seguida, será documentado um manual técnico de padrões biomecânicos. Na fase de desenvolvimento, será construído um algoritmo de rastreamento para detectar movimentos e posturas. Depois, será realizado o desenvolvimento das interfaces do aplicativo mobile, incluindo login, cadastro e telas de monitoramento. Testes internos de performance e usabilidade serão realizados, com suporte aos demais membros. Após a validação com usuários, serão implementadas melhorias finais no aplicativo conforme os feedbacks recebidos.  
  * Cronograma De Atividades:   
    * Título Da Etapa: Revisão Bibliográfica e Levantamento De Soluções Técnicas.   
    * Data De Início e Fim: 01/08/2025 \- 30/09/2025  
    * Descrição Da Etapa:  Pesquisa e análise de ferramentas de visão computacional (OpenCV, MediaPipe) para rastreamento de movimentos e soluções de baixo custo.  
        
    * Título Da Etapa: Coleta de Dados e Definição dos Padrões.  
    * Data Início e Fim:  01/10/2025 \- 30/11/2025.  
    * Descrição Da Etapa: Documentação dos padrões biomecânicos (criação de um manual técnico com referências dos movimentos).  
        
    * Título Da Etapa: Desenvolvimento do Sistema de Análise.  
    * Data Início e Fim:  01/12/2025 \- 31/01/2026  
    * Descrição Da Etapa: Desenvolver o algoritmo de rastreamento de movimentos corporais utilizando as bibliotecas OpenCV e MediaPipe, focando na detecção precisa de posturas e movimentos relevantes para a reabilitação neurológica.​  
        
    * Título Da Etapa: Criação da Aplicação Mobile  
    * Data Início e Fim:  01/02/2026 \- 31/03/2026  
    * Descrição Da Etapa: Desenvolvimento das interfaces do aplicativo (telas de login, cadastro, monitoramento de movimento).  
        
    * Título Da Etapa: Testes Preliminares e Ajustes Internos   
    * Data Início e Fim: 01/04/2026 \- 30/04/2026  
    * Descrição Da Etapa: (Apoio à luis) Realizar testes de performance do sistema de rastreamento; identificar bugs no app; propor melhorias de UX/UI.  
        
    * Título Da Etapa:  Validação com Usuários  
    * Data Início e Fim: 01/05/2026 \- 31/05/2026  
    * Descrição Da Etapa: (Apoio à Luis) Análise dos dados coletados; avaliação da eficiência do rastreamento e da clareza do feedback dado pelo sistema.  
        
    * Título Da Etapa: Análise dos Resultados e Ajustes Finais  
    * Data Início e Fim: 01/06/2026 \- 31/07/2026  
    * Descrição Da Etapa: Atualizar o aplicativo mobile conforme feedbacks (UI/UX, melhorias visuais).

---

