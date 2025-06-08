#!/bin/bash

#resize disk from 20GB to 50GB
sudo growpart /dev/nvme0n1 4

sudo lvextend -L +10G /dev/mapper/RootVG-homeVol
sudo lvextend -L +10G /dev/mapper/RootVG-varVol
sudo lvextend -l +100%FREE /dev/mapper/RootVG-varTmpVol

sudo xfs_growfs /home
sudo xfs_growfs /var/tmp
sudo xfs_growfs /var

sudo yum install java-17-openjdk -y

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
sudo dnf module disable nodejs -y
sudo dnf module enable nodejs:20 -y
sudo dnf install nodejs -y
sudo yum install zip -y

# docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

sudo curl -O curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl

sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

sudo dnf install maven -y
