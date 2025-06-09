#!/bin/bash
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

# Step 2: Grow partition 4 (ensure disk was resized in AWS)
sudo growpart /dev/nvme0n1 4 

# Step 3: Extend LVs (50% each)
sudo lvextend -l +50%FREE /dev/RootVG/rootVol
sudo lvextend -l +50%FREE /dev/RootVG/varVol

# Step 4: Grow XFS filesystems
sudo xfs_growfs /
sudo xfs_growfs /var


sudo curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install fontconfig java-17-openjdk jenkins -y
sudo yum install jenkins -y
sudo ystemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins