# 🏢 Laboratório de Infraestrutura Windows Server 2022 & Active Directory

Projeto prático focado na simulação da infraestrutura de TI de uma pequena/média empresa, abordando administração de usuários, políticas de segurança, gestão de permissões e automação via PowerShell.

---

## 🎯 Objetivos do Projeto
* Implementar e configurar um **Controlador de Domínio** utilizando **Windows Server 2022**.
* Estruturar o **Active Directory (AD DS)** com Unidades Organizacionais (OUs), Usuários e Grupos por departamento.
* Aplicar **Políticas de Grupo (GPO)** para endurecimento de segurança do sistema (*Hardening*).
* Gerenciar **Compartilhamento de Pastas** e permissões avançadas **NTFS**.
* Criar e executar **Scripts em PowerShell** para inventário e checagem de processos.

---

## 💻 Arquitetura do Ambiente
* **Servidor (DC):** Windows Server 2022 Datacenter (`192.168.10.1`) — Domínio: `empresa.local`
* **Estação Cliente:** Windows 11 Pro (`192.168.10.10`)
* **Rede:** Isolada (VirtualBox Internal Network)

---

## 📸 Evidências de Implementação

### 1. Estrutura do Active Directory
OUs organizadas por departamento (`EmpresaOU` -> `Usuarios` / `Grupos`).
![Active Directory](<img width="966" height="729" alt="Usuarios Active Directory" src="https://github.com/user-attachments/assets/c3d8a3ad-f841-44be-9b2f-cec213960b0e" />
)

### 2. Restrições via GPO Aplicadas
Bloqueio do Prompt de Comando (CMD) e Painel de Controle para usuários do domínio.
![Testes GPO](<img width="966" height="720" alt="Grupos Active Directory" src="https://github.com/user-attachments/assets/2fcedce6-f2a4-47d8-845a-9006ca41a979" />)

### 3. Validação de Permissões NTFS e Compartilhamento
Teste de bloqueio de escrita para usuários sem controle total.
![Permissões NTFS](<img width="1023" height="767" alt="Acesso negado CTFS pasta" src="https://github.com/user-attachments/assets/ad2ba915-cbb7-495b-a8f5-83bf1109b8ba" />)

---

## 🛠️ Tecnologias Utilizadas
`Windows Server 2022` | `Windows 11 Pro` | `Active Directory` | `DNS` | `GPO` | `NTFS` | `PowerShell` | `VirtualBox`
