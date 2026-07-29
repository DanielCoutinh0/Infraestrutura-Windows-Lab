# 🏢 Laboratório de Infraestrutura Windows Server 2022 & Active Directory

Projeto prático de simulação de infraestrutura de TI corporativa, cobrindo virtualização, serviços de domínio, gestão de acessos, políticas de grupo e automação via PowerShell.

---

## 💻 1. Criando as Máquinas Virtuais no VirtualBox
Foram criadas duas VMs no Oracle VirtualBox e interconectadas por uma **Rede Interna** (*Internal Network* nomeada `LabNetwork`) para isolamento seguro do ambiente:

* **DC-Server2022:** Windows Server 2022 Datacenter (4 GB RAM / 2 vCPUs).
* **CL-Win11:** Windows 11 Pro (4 GB RAM / 2 vCPUs).

![Criação das VMs no VirtualBox](ImagensProjeto/VirtualBox.png)

---

## 🌐 2. Configurando IP Fixo
Para garantir a estabilidade das requisições DNS e de domínio, o servidor teve a interface de rede configurada manualmente com um IP estático:

* **Endereço IP:** `192.168.10.1`
* **Máscara de Sub-rede:** `255.255.255.0`
* **DNS Preferencial:** `127.0.0.1` *(apontando para si mesmo)*

![Configuração de IP Fixo no Server](imagens/02_ip_fixo.png)

---

## 🚀 3. Instalando o Active Directory (AD DS)
Promovido o servidor a Controlador de Domínio para a nova floresta `empresa.local`, ativando automaticamente o serviço de **DNS Server**:

* **Domínio criado:** `empresa.local`
* **Função instalada:** Active Directory Domain Services (AD DS).

![Promoção do Domínio empresa.local](imagens/03_active_directory.png)

---

## 👥 4. Criando Usuários e Grupos (AD UC)
No *Usuários e Computadores do Active Directory*, foi organizada a estrutura de Unidades Organizacionais (OUs), segregando por departamentos e aplicando o conceito de RBAC (*Role-Based Access Control*):

* **Estrutura de OUs:** `EmpresaOU` → `Usuarios` / `Grupos`.
* **Grupos de Segurança:** `GRP_Financeiro`, `GRP_RH`, `GRP_TI`.
* **Usuários:** `carlos` (Financeiro), `maria` (Financeiro), `joao` (RH), `ana` (TI).

![Estrutura de OUs, Usuários e Grupos no AD](imagens/04_usuarios_grupos.png)

---

## 📁 5. Configurando Permissões NTFS e Resultado
Criada a pasta `C:\EmpresaDados\Financeiro` com compartilhamento restrito e permissões NTFS individuais para validação de controle de acesso:

* **Usuário Carlos:** Permissão apenas de *Leitura e Execução*.
* **Usuária Maria:** Permissão de *Controle Total*.

### 🧪 Resultado do Teste
Logado no Windows 11 (`CL-Win11`) com a conta do usuário **Carlos**, ao tentar criar/salvar um novo arquivo no diretório `\\192.168.10.1\Financeiro`, o acesso foi imediatamente negado pelo sistema:

![Mensagem de Acesso Negado para o Usuário Carlos](imagens/05_ntfs_resultado.png)

---

## 🛡️ 6. Proibindo Acesso ao Painel de Controle e CMD (GPO)
Criada a diretiva `GPO_Restricoes_Seguranca` no *Gerenciamento de Políticas de Grupo* vinculada à `EmpresaOU` para limitar ações administrativas nos computadores dos clientes:

* **Políticas Habilitadas:**
  * *Impedir acesso ao prompt de comando (CMD)*.
  * *Proibir acesso ao Painel de Controle e às Configurações do Computador*.

### 🧪 Resultado do Teste
Após rodar o comando `gpupdate /force` na máquina cliente, ao tentar abrir o CMD ou o Painel de Controle logado como usuário do domínio, o Windows bloqueou o acesso:

![Acesso bloqueado ao CMD e Painel de Controle via GPO](imagens/06_gpo_resultado.png)

---

## ⚡ 7. PowerShell e Resultado
Desenvolvimento de scripts em PowerShell (`/scripts`) executados no sistema para automação de tarefas de suporte e verificação de saúde do sistema:

1. `ListarProcessos.ps1`: Exporta os 15 processos que mais consomem recurso para um arquivo de texto.
2. `ListarServicos.ps1`: Mapeia todos os serviços com status *Running*.

### 🧪 Resultado do Teste
Execução dos scripts no PowerShell e geração automatizada dos relatórios em `.txt`:

![Execução dos scripts PowerShell e geração dos relatórios](imagens/07_powershell_resultado.png)
