**Data:** 2026-03-28  

# Regras de Negócio: Registro e Vínculo

O modelo de negócio do Sinergia é estruturado para garantir que cada paciente receba acompanhamento profissional adequado dentro de uma estrutura organizacional (clínica ou consultório).

## 1. Perfis e Hierarquia de Acesso

A plataforma opera sob três perfis principais:

- **Administrador do Sistema:** Responsável pela gestão global, incluindo a criação de empresas e o credenciamento de profissionais responsáveis.
- **Profissional da Saúde:** Representa uma empresa (clínica ou sociedade) e detém a tutela dos planos de tratamento dos pacientes vinculados.
- **Paciente:** Usuário final que realiza os exercícios e interage com o orientador.

## 2. Diretrizes de Registro

- **Empresas e Profissionais:** O acesso inicial de uma empresa e de seus profissionais não é realizado por autoatendimento público; ele deve ser provisionado pelo Administrador do Sistema.
- **Pacientes:** O registro público é exclusivo para o perfil de paciente.
- **Identificação:** No momento do cadastro, o sistema gera automaticamente um **Código Público de Identificação** para o paciente. Este identificador é fixo e não pode ser alterado pelo usuário.

## 3. Modelo de Vínculo (Tutela)

O vínculo estabelece a relação de acompanhamento entre o profissional e o paciente.

- **Exclusividade de Orientação:** Cada paciente pode estar vinculado a **no máximo um** profissional por vez.
- **Vínculo via Convite:** O profissional pode gerar códigos de convite com data de validade e limites de uso. Se um paciente utilizar um convite válido durante o seu registro, o vínculo com o profissional é estabelecido automaticamente.
- **Vínculo de Contas Existentes:** Para pacientes já cadastrados que não possuem um orientador, o profissional pode realizar o vínculo utilizando o Código Público fornecido pelo paciente.

## 4. Gerenciamento de Identificadores e Códigos

- **Código de Convite:** Gerado pelo profissional para prospecção de novos pacientes, podendo ser de uso único ou múltiplo.
- **Código Público:** Um identificador alfanumérico (exibido visualmente com o prefixo `@`) que serve como o "endereço" do paciente para que profissionais possam localizá-lo e solicitar a tutela.

## 5. Alteração e Encerramento de Vínculo

- **Transferência de Orientador:** Para que um paciente seja acompanhado por um novo profissional, o vínculo atual deve ser obrigatoriamente encerrado antes que um novo seja solicitado.
- **Autoridade de Remoção:** O encerramento de um vínculo ativo só pode ser realizado pelo profissional que detém a tutela atual ou pelo Administrador do Sistema.
- **Restrição do Paciente:** O paciente não possui autonomia para remover o próprio vínculo ou alterar seu orientador sem a intervenção de um profissional ou administrador.

