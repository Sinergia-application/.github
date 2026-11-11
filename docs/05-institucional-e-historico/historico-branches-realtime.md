# Changelog das Branches Realtime

Registro das funcionalidades, correções e alterações relevantes adicionadas nas branches de realtime em relação à base principal (`master`/`main`).

Última atualização: 23/05/2026.

## Branches acompanhadas

- `sinergia-api`: `feat/exercise-instances-and-audio`
- `sinergia-web`: `feat/realtime-custom-exercises`
- `sinergia-worker`: `feat/fastapi-dynamic-rules`

## 04/05/2026 a 10/05/2026 - Base do motor dinâmico no worker

### Novas funcionalidades

- Implementação inicial do motor de regras dinâmicas por orientação no `sinergia-worker`.
- Expansão da coleta de landmarks e métricas biomecânicas para avaliação dos exercícios.
- Mapeamento das regras de análise alinhado ao payload enviado pela API.
- Evolução do pipeline de processamento de vídeo e integração com feedback gerado por LLM.

### Correções e ajustes

- Suporte a múltiplos formatos de `regras_analise`.
- Padronização de parâmetros da task de análise para `camelCase`.
- Envio do feedback para a API usando path relativo ao storage.
- Ajustes para impedir marcação de erros em fases de contagem quando não aplicável.

## 16/05/2026 - Fluxo realtime, instâncias e feedback

### API

- Criação de instâncias personalizadas de exercício para uso em roteiros.
- Upload e gerenciamento de áudios de feedback por flag do exercício.
- Inclusão de tempo de descanso configurável no item de roteiro.
- Consultas e limpeza agendada de sessões/análises em andamento.
- Conclusão de sessão em tempo real com vídeo de feedback e resumo via Gemini.
- Confirmação de e-mail por código no primeiro acesso do paciente.

### Web

- Sessão em tempo real com séries automáticas, overlay e câmera espelhada.
- Configuração de URL de WebSocket realtime para produção.
- Análise de pose local sem fila de WebSocket.
- Extração do motor realtime isolado, com testes de contrato.
- Gravação de vídeo com landmarks e envio do relatório para IA.
- Debounce de flags durante a coleta da sessão realtime.
- Ajustes no primeiro acesso com confirmação de e-mail por código.

### Worker

- WebSocket de análise em tempo real.
- Dependências e documentação do módulo realtime.
- Runner de contrato compartilhado com fixtures do `sinergia-web`.
- Ajuste para avaliar erros em `DESCENDO` apenas no fundo da amplitude de movimento.

### Correções e ajustes

- Correção de vídeo salvo com apenas landmarks e fundo preto.
- Correção de URL realtime removendo duplicação de `/ws`.
- Ajustes de ícones, avatar e scroll em telas do profissional.
- Calibração de limites das regras do agachamento no seed da API.
- Correção para não marcar inatividade logo após o primeiro acesso.
- Migrações para alinhar campos SHA-256 com o tipo esperado pelo Hibernate (`VARCHAR`).

## 21/05/2026 - Endereço, localidades, evolução angular e polimentos

### API

- Criação do domínio de localidades e endereço: `Estado`, `Cidade` e `Endereco`.
- Repositórios, DTOs, serviços e endpoints para consulta de estados/cidades.
- Suporte a criação/garantia de cidade a partir do fluxo de ViaCEP.
- Integração de endereço no pré-cadastro, cadastro, edição e perfil do paciente.
- Retorno de endereço nos detalhes do paciente e respostas de usuário/paciente.
- Endpoints de evolução de angulação para exercícios com instância.
- Inclusão de `urlVideoDemonstracao` e `previewImageUrl` no próximo exercício do dashboard do paciente.

### Web

- Componente compartilhado de formulário de endereço.
- Integração com ViaCEP e API de localidades.
- Endereço no pré-cadastro profissional e no perfil do paciente.
- Endereço no detalhe do paciente para o profissional.
- Gráficos de evolução angular para paciente e profissional.
- Preview de mídia no card de próximo exercício do dashboard do paciente.
- Ajustes responsivos na mídia de demonstração do exercício.
- Correções visuais em ativação de exercício, avatar, ícones e botão de mensagens.

### Migrações e produção

- Inclusão da migração de localidades e endereço do paciente.
- Correção de incompatibilidades entre tipos criados nas migrações e tipos esperados pelo Hibernate.
- Ajuste específico de produção para `estado.uf`, criado como `CHAR(2)` e validado pelo Hibernate como `VARCHAR(2)`.
- Adição de migração posterior para converter `estado.uf` para `VARCHAR(2)` sem alterar o checksum da migração já aplicada.

## Validações realizadas

- `sinergia-api`: compilação Maven executada com sucesso após os ajustes.
- `sinergia-web`: build Angular executado com sucesso após correções de tipagem e templates.

## Critérios para próximos registros

- Agrupar novas entradas por período de desenvolvimento ou data de fechamento do bloco.
- Separar mudanças por projeto quando envolver API, Web e Worker.
- Registrar correções de produção em seção própria quando envolver migrações, schema ou comportamento já publicado.
- Não alterar migrações já aplicadas; registrar novas correções sempre em migração posterior.
