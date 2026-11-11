# Conformidade LGPD, Consentimento, Retenção de Mídia e Menores

**Escopo:** Diretrizes de proteção de dados pessoais sensíveis, termos de consentimento, telemetria de dispositivo, expurgo automático de vídeos e pontos de atenção jurídica  
**Repositórios:** `sinergia-api` e `sinergia-web`

> **Nota sobre natureza do documento:** Este documento consolida a arquitetura de privacidade já implementada no sistema e os pontos de atenção jurídica mapeados para validação junto ao encarregado de dados (DPO) e assessoria jurídica.

---

## 1. Contexto de Tratamento de Dados no Sinergia

A operação clínica do Sinergia envolve a captura e o processamento de:
1. **Imagem e vídeo corporal do paciente** durante a execução dos exercícios prescritos;
2. **Coordenadas articulares derivadas (`landmarks_json`)** e métricas biomecânicas de desempenho (ângulos, repetições, estabilidade e alertas posturais);
3. **Dados clínicos e de saúde:** condição clínica, altura, roteiros prescritos, evolução histórica e anotações do fisioterapeuta;
4. **Dados cadastrais e operacionais:** nome, e-mail, telefone, CPF, endereço, mensagens trocadas com o profissional, registros de auditoria (`audit_log`) e, quando autorizado, telemetria técnica da câmera e do aparelho (`sessao_dispositivo`).

Nos termos da Lei Geral de Proteção de Dados Pessoais (Lei nº 13.709/2018 — LGPD, art. 5º, II), dados referentes à saúde e dados biométricos são classificados como **dados pessoais sensíveis**, exigindo salvaguardas técnicas e governança estrita.

---

## 2. Arquitetura de Consentimento e Telemetria Implementada

As migrations `V37__consentimento.sql` e `V38__dispositivo_telemetria.sql`, juntamente com `ConsentimentoController`, `ConsentimentoService` e a página `patient-privacy.component.ts`, implementam a segregação de consentimentos por finalidade (`FinalidadeConsentimento`):

| Finalidade (`FinalidadeConsentimento`) | Natureza | Regra de Bloqueio e Operação |
|---|---|---|
| `CAPTURA_IMAGEM_SAUDE` | **Obrigatória para sessões** | Exigida para iniciar a gravação ou análise de exercícios com câmera. Sem aceite vigente: o paciente continua acessando sua conta, agenda, mensagens e histórico, mas a criação/upload de sessões é bloqueada na interface e na API. |
| `TELEMETRIA_DISPOSITIVO_CAMERA` | **Opcional** | Autoriza o envio de metadados técnicos do aparelho (`SessaoDispositivo`: resolução da câmera, FPS médio, modelo de navegador/SO, problemas de permissão ou iluminação) para diagnóstico de suporte técnico. |

### Registro de Prova do Consentimento (`ConsentimentoUsuario`)
Para atender ao ônus da prova previsto no art. 8º, §2º da LGPD, cada alteração na tabela `consentimento_usuario` registra:
- `usuario_id` e `finalidade`;
- `versao_termo` e `hash_texto_termo` (garantindo que mudanças no texto do termo exijam novo aceite quando necessário);
- `concedido` (`boolean`), `concedido_em` e `revogado_em`;
- `ip_mascarado` e `user_agent` do momento da manifestação;
- `responsavel_id` (coluna opcional reservada para futura vinculação de representante legal).

---

## 3. Política de Retenção e Expurgo Automático de Vídeos (`SessaoCleanupTask`)

Para aplicar o princípio da minimização e limitação de armazenamento (art. 6º, III e art. 15 da LGPD) sem comprometer o acompanhamento longitudinal da evolução clínica:

1. **Expurgo de arquivos de vídeo após 15 dias:**
   - A tarefa agendada `SessaoCleanupTask#purgarVideosAntigos` executa diariamente e localiza registros de `AnaliseVideo` criados há mais de 15 dias que ainda possuam arquivos de mídia vinculados.
   - Os arquivos físicos de vídeo (`videoOriginalUrl` e `videoFeedbackUrl`) são removidos do armazenamento (`StorageService`) e as respectivas URLs são limpas na entidade.
2. **Preservação de métricas clínicas e landmarks:**
   - Os relatórios estruturados (`relatorio_json`, `resultado_materializado`), as notas do fisioterapeuta e as séries numéricas de coordenadas (`landmarks_json`) permanecem disponíveis para consulta de evolução histórica e reprocessamento biomecânico.

---

## 4. Pontos de Atenção Jurídica e Evolução de Segurança

### 4.1. Base Legal e Papel dos Agentes de Tratamento (Controlador vs. Operador)
- **Qualificação jurídica:** Definir formalmente nos contratos com as clínicas parceiras se a clínica/profissional atua como **Controladora** dos dados de saúde de seus pacientes e o Sinergia como **Operador** (ou co-controlador), estabelecendo o respectivo Acordo de Processamento de Dados (DPA).
- **Enquadramento nos arts. 7º e 11 da LGPD:** Avaliar com o jurídico a combinação entre a base de **tutela da saúde** (art. 11, II, "f") / execução contratual e o **consentimento específico e destacado** para uso de imagem e voz.

### 4.2. Guarda de Prontuário vs. Eliminação de Dados
- Normas de prontuário eletrônico e resoluções do COFFITO estabelecem prazos mínimos de guarda documental em anos. O mapeamento jurídico deve delimitar exatamente quais registros do Sinergia integram o prontuário clínico (que devem ser preservados ou exportados à clínica mesmo em caso de revogação de consentimento de imagem) e quais artefatos (como arquivos de vídeo brutos) devem ser eliminados imediatamente após a revogação.

### 4.3. Tratamento de Dados de Crianças, Adolescentes e Idosos Dependentes
- Antes de habilitar o cadastro de menores de idade (art. 14 da LGPD e ECA) ou o login autônomo de cuidadores para pacientes com declínio cognitivo:
  - Coletar data de nascimento obrigatória no cadastro do paciente para verificação etária;
  - Habilitar o fluxo formal de consentimento específico assinado pelo pai, mãe ou responsável legal (`responsavel_id`);
  - Restringir ao mínimo estritamente necessário o acesso a vídeos domésticos.

### 4.4. Roadmap Técnico de Blindagem de Segurança
Conforme detalhado na Seção 5.2 de [plano-implementacao-reunioes-clinicas.md](../03-clinico-e-biomecanica/plano-implementacao-reunioes-clinicas.md), o backlog técnico de segurança contempla:
1. Geração de URLs temporárias assinadas para leitura de vídeos no `StorageService` e registro em `audit_log` de toda visualização de mídia;
2. Job imediato de expurgo dos vídeos do paciente no ato da revogação do consentimento `CAPTURA_IMAGEM_SAUDE`;
3. Ferramenta de autoatendimento na página de privacidade do paciente para exportação de dados pessoais (portabilidade) e solicitação de eliminação;
4. Garantia de anonimização estrita nos payloads enviados a serviços externos de IA (`GeminiFeedbackService` e `ElevenLabsTtsService`), enviando apenas métricas angulares e códigos de flags sem identificadores pessoais.

---

## 5. Referência Rápida de Arquivos

| Camada | Arquivos Principais |
|---|---|
| **Backend (`sinergia-api`)** | `ConsentimentoUsuario.java`, `FinalidadeConsentimento.java`, `ConsentimentoController.java`, `ConsentimentoService.java`, `SessaoDispositivo.java`, `DispositivoTelemetriaService.java`, `SessaoCleanupTask.java`, `AuditLog.java`, `AuditService.java` |
| **Frontend (`sinergia-web`)** | `features/patient/pages/patient-privacy/` |
