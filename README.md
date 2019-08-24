# Test task middle DevOps
Create infrastructure and deploy stateful app in compliance with test task.

## Prepare environment
- create ~/.aws/credentials file
- create ~/.aws/config file
- create IAM user 
- create key pair like key.pem
- git clone project
- TF_VAR_shared_credentials_file (i.e.:export TF_VAR_shared_credentials_file="/Users/egorbukatkin/.aws/credentials")
## Provisioning Infrastructure
```shell script
cd ${git_root}/terraform_provisioning
```

```shell script
terraform init
terraform plan
terraform apply
```

## Ansible
- create virtualenv
```shell script
cd ${git_root}/
mkdir project
cd project
sudo apt-get install python3-pip
pip3 install virtualenv
python3 -m venv myenv
```
- copy data from app folder
```shell script
cp -R ${git_root}/app/* ${git_root}/project/myenv
```
- run virtualenv
```shell script
cd ${git_root}/project/myenv
source bin/activate
pip3 install -r requirements.txt 
```
- change ansible.cfg
   - add path to key
```shell script
vim ${git_root}/project/myenv/ansible.cfg
```
```shell script
private_key_file=/Users/egorbukatkin/Programming/kyriba_test_task/test-machine.pem
```
- ping ansible:
```shell script
cd ${git_root}/project/myenv
ansible -v -i inventory/ec2.py -u ubuntu us-east-1a -m ping
```
- run playbook:
```shell script
ansible-playbook -v -i inventory/ec2.py -u ubuntu install_app.yml
```

- Check application
```
Open in browser:
http://{aws-ec2-ip-address}:80/
```