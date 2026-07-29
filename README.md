# 🏢 Laboratório de Infraestrutura Windows Server 2022 & Active Directory

Projeto prático de simulação de infraestrutura de TI corporativa, cobrindo virtualização, serviços de domínio, gestão de acessos, políticas de grupo e automação via PowerShell.

---

## 💻 1. Criando as Máquinas Virtuais no VirtualBox
Foram criadas duas VMs no Oracle VirtualBox e interconectadas por uma **Rede Interna** (*Internal Network* nomeada `LabNetwork`) para isolamento seguro do ambiente:

* **DC-Server2022:** Windows Server 2022 Datacenter (4 GB RAM / 2 vCPUs).
* **CL-Win11:** Windows 11 Pro (4 GB RAM / 2 vCPUs).

<h4> Criação das VMs no VirtualBox <img width="1911" height="764" alt="VirtualBox" src="https://github.com/user-attachments/assets/03358397-4784-49be-a272-011a391b337f" /></h4>
)

---

## 🌐 2. Configurando IP Fixo
Para garantir a estabilidade das requisições DNS e de domínio, o servidor teve a interface de rede configurada manualmente com um IP estático:

* **Endereço IP:** `192.168.10.1`
* **Máscara de Sub-rede:** `255.255.255.0`
* **DNS Preferencial:** `127.0.0.1` *(apontando para si mesmo)*

<h4> Configuração de IP Fixo no Server <img width="1018" height="716" alt="Config IP fixo DC-Server2022" src="https://github.com/user-attachments/assets/0c551aa8-9915-4ad9-bdca-3190dcacb8be" /></h4>

---

## 🚀 3. Instalando o Active Directory (AD DS)
Promovido o servidor a Controlador de Domínio para a nova floresta `empresa.local`, ativando automaticamente o serviço de **DNS Server**:

* **Domínio criado:** `empresa.local`
* **Função instalada:** Active Directory Domain Services (AD DS).

<h4> Promoção do Domínio empresa.local <img width="1010" height="724" alt="Instalação Active Directory" src="https://github.com/user-attachments/assets/5a5a6d33-208a-43ed-83bc-c2046dc78898" /></h4>

---

## 👥 4. Criando Usuários e Grupos (AD UC)
No *Usuários e Computadores do Active Directory*, foi organizada a estrutura de Unidades Organizacionais (OUs), segregando por departamentos e aplicando o conceito de RBAC (*Role-Based Access Control*):

* **Estrutura de OUs:** `EmpresaOU` → `Usuarios` / `Grupos`.
* **Grupos de Segurança:** `GRP_Financeiro`, `GRP_RH`, `GRP_TI`.
* **Usuários:** `carlos` (Financeiro), `maria` (Financeiro), `joao` (RH), `ana` (TI).

<h4> Estrutura de OUs, Usuários e Grupos no AD <img width="966" height="729" alt="Usuarios Active Directory" src="https://github.com/user-attachments/assets/ee92d508-6e72-4072-a565-18345cbb2d9d" />
<img width="966" height="720" alt="Grupos Active Directory" src="https://github.com/user-attachments/assets/bc5d2dd5-9ec4-47c2-817c-3a9de3ea60c0" /></h4>

---

## 📁 5. Configurando Permissões NTFS e Resultado
Criada a pasta `C:\EmpresaDados\Financeiro` com compartilhamento restrito e permissões NTFS individuais para validação de controle de acesso:

* **Usuário Carlos:** Permissão apenas de *Leitura e Execução*.
* **Usuária Maria:** Permissão de *Controle Total*.

### 🧪 Resultado do Teste
Logado no Windows 11 (`CL-Win11`) com a conta do usuário **Carlos**, ao tentar criar/salvar um novo arquivo no diretório `\\192.168.10.1\Financeiro`, o acesso foi imediatamente negado pelo sistema:

<h4> Mensagem de Acesso Negado para o Usuário Carlos <img width="1023" height="767" alt="Acesso negado CTFS pasta" src="https://github.com/user-attachments/assets/46dda92d-4919-432a-b256-a0b1b780ed07" /></h4>

---

## 🛡️ 6. Proibindo Acesso ao Painel de Controle e CMD (GPO)
Criada a diretiva `GPO_Restricoes_Seguranca` no *Gerenciamento de Políticas de Grupo* vinculada à `EmpresaOU` para limitar ações administrativas nos computadores dos clientes:

* **Políticas Habilitadas:**
  * *Impedir acesso ao prompt de comando (CMD)*.
  * *Proibir acesso ao Painel de Controle e às Configurações do Computador*.

### 🧪 Resultado do Teste
Após rodar o comando `gpupdate /force` na máquina cliente, ao tentar abrir o CMD ou o Painel de Controle logado como usuário do domínio, o Windows bloqueou o acesso:

<h4> Acesso bloqueado ao CMD e Painel de Controle via GPO <img width="1024" height="768" alt="CMD mensagem de permissao" src="https://github.com/user-attachments/assets/254fddbe-7c56-42dc-b76d-c42c70239ad4" /><img width="1022" height="768" alt="painel de controle mensagem de permissao" src="https://github.com/user-attachments/assets/b22059a0-951e-4ff9-aa77-a916474ad73b" /> </h4>

---

## ⚡ 7. PowerShell e Resultado
Desenvolvimento de scripts em PowerShell (armazenados na pasta `/Scripts`) para automação de tarefas de suporte e verificação de saúde do sistema.

### 📜 Código 1: Exportar Processos (`ListarProcessos.ps1`)
Este script captura os 15 processos que mais consomem CPU e exporta os dados organizados para um arquivo de texto:

```powershell
Get-Process | Select-Object -First 15 Name, Id, CPU | Out-File -FilePath .\processos.txt
Write-Host "Lista de processos exportada com sucesso para processos.txt!" -ForegroundColor Green
```

### 📜 Código 2: Exportar Serviços Ativos (`ListarServicos.ps1`)
Este script filtra apenas os serviços do sistema que estão atualmente em execução (Running) e os salva em um relatório:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Out-File -FilePath .\servicos_ativos.txt
Write-Host "Lista de serviços em execução exportada com sucesso para servicos_ativos.txt!" -ForegroundColor Green
```

### 🧪 Resultado do Teste
<h4> Execução dos scripts PowerShell e geração dos relatórios <img width="1017" height="771" alt="Script servicos" src="https://github.com/user-attachments/assets/a1d23e06-c1e4-49c9-8ce7-759486765a47" /> <img width="1020" height="768" alt="Script processos" src="https://github.com/user-attachments/assets/2d37937b-59ad-4cd4-9da1-75a2c339178d" /> </h4>

