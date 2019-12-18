#! /bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install python -y
## Anisble Install
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y

# install git
sudo apt-get install git -y

# clone repository
git clone https://github.com/deeco/gitlab-install.git /tmp/aws-gitlab

# install role pre-req
sudo ansible-galaxy install geerlingguy.docker

# run playbook to install docker
sudo ansible-playbook --connection=local --inventory 127.0.0.1, --limit 127.0.0.1 /tmp/aws-gitlab/docker.yml -i ansible_hosts

# run docker compose to install awx
sudo docker-compose -f /tmp/aws-gitlab/gitlab/docker-compose.yml up -d
