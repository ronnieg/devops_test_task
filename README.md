# Test task middle DevOps
Create infrastructure and deploy stateful app in compliance with test task.

## Prepare environment
1. create ~/.aws/credentials file
2. create ~/.aws/config file
3. create IAM user 
4. create key pair like key.pem
5. git clone project
6. copy key.pem to ${git_root}/terraform_provisioning folder
## Provisioning Infrastructure
```shell script
cd ${git_root}/terraform_provisioning
terraform init
terraform plan
terraform apply
```

## Ansible
create virtualenv
```shell script
cd ${git_root}/
mkdir project
cd project
sudo apt-get install python3-pip
pip3 install virtualenv
python3 -m venv myenv
```
copy data from app folder
```shell script
cp -R ${git_root}/app/* ${git_root}/project/myenv
```
run virtualenv
```shell script
cd ${git_root}/project/myenv
source bin/activate
pip3 install -r requirements.txt 
```

ping ansible:
```shell script
cd ${git_root}/project/myenv
ansible -v -i inventory/ec2.py -u ubuntu us-east-1a -m ping
```
run playbook:
```shell script
ansible-playbook -v -i inventory/ec2.py -u ubuntu install_app.yml
```
