# Análise Arquitetural e Visão Computacional: Escala de Berg no Sinergia
A premissa fundamental aqui é: **Visão Computacional 2D não tem discernimento clínico perfeito**. Algoritmos não sabem o que é "supervisão", "segurança" ou "orientação verbal", alguns até podem ser contornados conforme especificação da analise. Por via de duvidas, portanto, a Computer Vision atuará como um **Sugeridor de Score Baseado em Cinemática**, e a decisão final, a validação, é **sempre** do profissional de saúde.

---

## 1. Análise Individual dos Exercícios

### Exercício 2: PERMANECER EM PÉ SEM APOIO
**1. Dinâmica de Execução e Articulações Monitoradas:**
- Movimento predominantemente isométrico.
- **Keypoints Principais:** Tornozelos, Joelhos, Quadris (para cálculo do centro de massa e alinhamento vertical) e Pulsos/Mãos (para detectar busca de apoio externo).

**2. Lógica Algorítmica da Pontuação (Mapeamento 0 a 4):**
- Implementar uma máquina de estados: `INICIANDO` -> `ESTAVEL` -> `DESEQUILIBRIO/APOIO_DETECTADO`.
- Rodar **Timer 1 (120s)** e **Timer 2 (30s)** a partir da estabilidade inicial.
- Se mantiver a postura (eixo Y alinhado) e mãos próximas ao corpo ou livres por 120s = **Score 4**.
- Se mantiver por 30s e interromper = **Score 2**.
- Quebra de postura antes de 30s ou múltiplas tentativas deverão ser computadas via UI (incremento de tentativa falha = **Score 1** ou **0**).

**3. Dificuldades Técnicas e Limitações Reais:**
- **Incapacidade de diferenciar Score 3:** A visão computacional não sabe se o paciente está "com supervisão" (alguém perto de olho) versus "sem apoio". Isso é contexto fora da câmera.
- **Falsos Positivos de Apoio:** O paciente pode apenas cruzar os braços ou apoiar as mãos na própria perna, e o modelo pode interpretar como apoiar em um andador ou mesa, dependendo da oclusão frontal.

### Exercício 3: PERMANECER SENTADO SEM APOIO NAS COSTAS
*(Documentação técnica completa em [Berg_Ex3_Sentado.md](file:///d:/Projects/.github/docs/Berg_Ex3_Sentado.md))*

**1. Dinâmica de Execução e Articulações Monitoradas:**
- Postura isométrica sentada por até 2 minutos (120s), em **plano sagital (perfil)**.
- **Keypoints:** Ombros, Quadris (inclinação de tronco sagital), Joelhos, Tornozelos e Pés (manutenção da geometria sentada com pés apoiados) e Pulsos/Cotovelos (monitoramento não bloqueante de braços cruzados e heurística de apoio de mãos).

**2. Lógica Algorítmica da Pontuação (Mapeamento 0 a 4):**
- Executado através da arquitetura de Strategy (`SentadoSagitalProfile` desacoplado no `StaticPostureEngine`).
- Mantém tronco estável sem encosto e pés apoiados por 120s = **Score 4**.
- Mantém estável por 30s = **Score 2**.
- Mantém estável por 10s = **Score 1** (< 10s = **Score 0**).
- Braços cruzados são monitorados como orientação (`pct_tempo_bracos_cruzados`) e não como bloqueio rígido.

**3. Dificuldades Técnicas e Limitações Reais:**
- **Diferenciação 4 vs 3 (Supervisão):** Se o paciente atingir 120s, a IA sugere Score 4 e fornece interface para o terapeuta sinalizar supervisão (Score 3).
- **Encosto da Cadeira:** Câmeras 2D não detectam a malha física da cadeira diretamente; a violação de apoio é inferida pela inclinação excessiva para trás do vetor quadril-ombro em relação à calibração inicial.

### Exercício 5: TRANSFERÊNCIAS
**1. Dinâmica de Execução e Articulações Monitoradas:**
- Movimento de translação e rotação complexo (sentado -> em pé -> giro -> sentado).
- **Keypoints:** Quadris, Joelhos e Tornozelos (para rastrear as fases de elevação e marcha), Ombros e Pulsos (para detectar apoio de mãos nos braços da cadeira).

**2. Lógica Algorítmica da Pontuação (Mapeamento 0 a 4):**
- Monitorar a trajetória do quadril no eixo Y (subida/descida) em conjunto com a translação no eixo X/Z.
- Avaliar a relação entre Pulsos e Quadril: se durante a fase de elevação (Y do quadril aumentando verticalmente) os pulsos estiverem fixos num ponto baixo correspondente ao assento/braço da cadeira, infere-se "uso das mãos" (**Score 3**). Se os pulsos estiverem livres = "uso mínimo/sem mãos" (**Score 4**).

**3. Dificuldades Técnicas e Limitações Reais:**
- **Oclusão Extrema e Interação Humano-Objeto:** A câmera não entende nativamente a geometria da cadeira. Pior ainda: identificar se o paciente precisou de "uma pessoa" (**Score 1**) ou "duas pessoas" (**Score 0**) exigiria rastreamento multi-pessoas robusto *e* detecção de interação física complexa.
- **Veredito Pragmático:** O Sinergia deve inferir apenas se houve ou não uso das mãos (Score 4 ou 3). Pontuações de dependência humana (0, 1 e 2) devem ser entradas *manuais* do clínico.

### Exercício 8: ALCANÇAR A FRENTE COM O BRAÇO ESTENDIDO
**1. Dinâmica de Execução e Articulações Monitoradas:**
- Exige posicionamento estrito em **perfil** em relação à câmera para análise de profundidade e deslocamento horizontal.
- **Keypoints:** Ombro, Cotovelo, Pulso (do braço estendido em 90º), Quadris e Tornozelos (para garantir que os pés não se moveram do lugar).

**2. Lógica Algorítmica da Pontuação (Mapeamento 0 a 4):**
- Capturar coordenada X do pulso no instante zero (braço reto).
- Rastrear o deslocamento máximo do pulso (ΔX) sem que haja movimento no eixo X dos tornozelos.
- Converter ΔX de pixels para centímetros.
- Mapear distâncias: >25cm (**Score 4**), >12.5cm (**Score 3**), >5cm (**Score 2**).

**3. Dificuldades Técnicas e Limitações Reais:**
- **A Calibração Espacial (O grande gargalo):** Câmeras 2D não medem centímetros nativamente. Converter pixels em centímetros exige um referencial. A alternativa será usar a **altura do paciente** informada previamente para criar um *ratio* pixel/cm com base no comprimento estimado dos ossos longos na imagem.
- **Perda de Equilíbrio (Score 0):** Pode ser detectada por um solavanco repentino (queda no Y do ombro) ou um passo à frente (movimento súbito do tornozelo).

### Exercício 11: GIRAR 360 GRAUS
**1. Dinâmica de Execução e Articulações Monitoradas:**
- Rotação corporal completa sobre o próprio eixo vertical.
- **Keypoints:** Ombros e Quadris (para cruzar coordenadas e inferir inversão frente/costas).

**2. Lógica Algorítmica da Pontuação (Mapeamento 0 a 4):**
- Rastrear a inversão do Ombro Esquerdo vs Ombro Direito no eixo horizontal da imagem.
- Contabilizar o tempo percorrido desde o início do movimento angular até o retorno à posição zero.
- Se realizar giro completo para ambos os lados em < 4s = **Score 4**.
- Apenas um lado = **Score 3**. Lento (>4s) = **Score 2**.

**3. Dificuldades Técnicas e Limitações Reais:**
- **Oclusão e "Flickering":** Quando o paciente vira de costas, modelos padrão (MediaPipe/MoveNet) perdem a confiança e tendem a "inverter" a esquerda pela direita. Isso causa ruído massivo no tracking. Será necessário implementar um algoritmo que ignore perdas de sinal curtas no meio do giro ou utilizar tracking específico de calcanhares para inferir rotação contínua.

### Exercício 14: PERMANECER EM PÉ SOBRE UMA PERNA
**1. Dinâmica de Execução e Articulações Monitoradas:**
- **Keypoints:** Tornozelos (distância Y ou X relativa entre eles), Joelhos e Quadris.

**2. Lógica Algorítmica da Pontuação (Mapeamento 0 a 4):**
- Identificar a quebra da simetria dos pés: calcular o vetor diferencial Y entre Tornozelo 1 e Tornozelo 2.
- Ao superar um *threshold* de diferença (perna suspensa), inicia-se o cronômetro.
- >10s = **Score 4**. Entre 5-10s = **Score 3**. ≥3s = **Score 2**.
- Falha antes de 3s = **Score 1**.

**3. Dificuldades Técnicas e Limitações Reais:**
- **Ambiguidade de Perspectiva:** Se a câmera estiver alta e o paciente flexionar o joelho dobrando o pé *para trás*, o tornozelo ficará ocluído pelo corpo, dificultando a detecção. Exigirá um posicionamento angular claro (câmera à meia-altura).

---

## 2. Gap Analysis do Sistema (O que temos vs O que falta)

**O que o Sinergia já possui:**
- Extração de keypoints para reconhecimento de articulações que permitem movimento do corpo humano.
- Câmera ativa renderizando o esqueleto.

**O que FALTA ser criado (Módulos Novos):**
1. **Engine de Máquina de Estados de Exercícios (Front-end):** Um módulo TypeScript que não apenas pegue o X e Y, mas entenda o "momento" do paciente: `AGUARDANDO_POSICAO` -> `ANALISANDO` -> `CRITERIO_ALCANCADO` -> `FALHA_DETECTADA`.
2. **Motor de Calibração Dimensional (Front/Backend):** Uma rotina que, ao iniciar a sessão, pergunte a altura do paciente ou exija um "T-Pose" rápido na tela para calibrar a escala de Centímetros vs Pixels daquela câmera.
3. **Adaptação da Persistência de Sessão Atual (API / Banco de Dados):**
   - Como o sistema já possui persistência de sessão, o foco será **adaptar e estender** o esquema atual para as métricas da Escala de Berg.
   - Adicionar ou mapear na entidade que relaciona a sessão ao exercício as colunas essenciais: `AI_Suggested_Score` (Int), `Therapist_Validated_Score` (Int), `Validation_Notes` (Text), `Attempts` (Int).
4. **Filtro de Ruído Temporal (Smoothing):** Um buffer de frames (ex: média móvel dos últimos 5 frames) para impedir que uma falha de 1 frame da inteligência artificial interrompa o timer de um exercício longo.

> **Nota de Evolução:** Para o detalhamento técnico e instruções completas das próximas melhorias estruturais do motor, consulte o [PLANO_MELHORIAS_ARQUITETURAIS_MOTOR_REALTIME.md](file:///d:/Projects/.github/docs/PLANO_MELHORIAS_ARQUITETURAIS_MOTOR_REALTIME.md).

---

## 3. Dúvidas Clínicas e Técnicas (Para João e Juvanir)

Para amarrarmos a arquitetura e a UX perfeitamente, precisamos do veredito dos especialistas nessas 4 questões:
1. **Sobre o Ex 2:** O critério 'Score 3' menciona "supervisão". Para o sistema, como o terapeuta quer registrar isso? Haverá um botão "Supervisionar de perto" que ele aperta antes de iniciar o relógio?
2. **Sobre o Ex 5 (Transferência):** Como o Sinergia deve se comportar se o terapeuta entrar no quadro da câmera para ajudar o paciente (Scores 0 e 1)? Podemos programar o sistema para abortar a inferência se duas pessoas entrarem no quadro, forçando o terapeuta a inserir a nota manualmente?
3. **Sobre o Ex 8:** Podemos exigir no app Sinergia que, obrigatoriamente neste exercício, o paciente fique em *PERFIL* (de lado) para a câmera? É a única forma geometricamente confiável de medir o avanço do braço.
4. **Subjetividade:** Se o paciente girar 360 graus mas *quase* cair, como fica? O sistema pode achar que ele completou o giro e dar nota 4, mas o terapeuta pode dar nota 1 pelo risco. O sistema só sugere baseado no tempo e posição pura, certo? A palavra final da segurança é sempre do profissional de saude?
5. **Funcionamento:** Como seria o funcionamento integrado ao sistema? O paciente poderá ter independencia e fazer as atividades em casa ou será acompanhado presencialmente com o profissional e supervisor?

---