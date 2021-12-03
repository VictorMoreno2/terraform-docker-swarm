Repo para automação terraform 

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

```
shared_credentials_file = "<PATH>"
```

para testar playbook pelo wsl
adicionar no arquivo **/etc/ansible/hosts**
```
3.216.127.136 ansible_ssh_private_key_file=~/key.pem ansible_user=ubuntu ansible_become=yes
```