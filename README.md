Repo para automação terraform + ansible + docker swarm

A intenção é utilizar terraform + ansible para automação e configuração
Docker swarm para ser usado como cluster futuramente, mesmo usando apenas 1 node atualmente
É utilizado ec2 e ebs como volume do banco de dados para prover uma solução de menor custo e complexibilidade
Mesmo sendo uma solução de baixo custo, o EBS é para tentar diminuir tempo de downtime caso precise de uma troca de ec2 e persistência de dados.

Nesse projeto foi usado VPC & Subnet padrão

###################### Terraform e Ansible ######################

Necessário a key estar na home do usuario para o ansible utilizar e colocar permissao 400

para sobreescrever variavel do ansible usando WSL2
```
export ANSIBLE_CONFIG=$PWD/ansible.cfg
```
Arquivo backend
Colocar a key dentro de um arquivo e passar no shared_credentials, ou colocar no path padrão "**~/.aws/credentials**" 

**credentials file**
```
[default]  
aws_access_key_id=*****************  
aws_secret_access_key=*****************  
```
no arquivo backend.tf
```
shared_credentials_file = "<PATH>"
```

para testar playbook pelo wsl
adicionar no arquivo **/etc/ansible/hosts** exemplo:
```
3.216.127.136 ansible_ssh_private_key_file=~/key.pem ansible_user=ubuntu ansible_become=yes```

###################### Destroy & create ######################
para efetuar a troca de ec2 tbm precisa realizar a troca da playbook para acionar a playbook
```
terraform taint aws_instance.teste_glpi 
```
rodar o apply depois da ec2 estar criada(2 etapas), pois o EIP já está criado e com isso o ansible irá tentar conectar mas o ec2 vai estar "iniciando" e vai ter o erro de conexão recusada

```
terraform taint null_resource.ansible_playbook
```