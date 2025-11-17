#!/bin/bash
set -xe

###########################################
# UPDATE SYSTEM
###########################################
apt-get update -y
apt-get upgrade -y

###########################################
# INSTALL DOCKER
###########################################
apt-get install -y docker.io curl wget ca-certificates
systemctl enable --now docker
usermod -aG docker ubuntu || true
chmod 666 /var/run/docker.sock || true

###########################################
# RUN JENKINS IN DOCKER
###########################################
docker pull jenkins/jenkins:lts

docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

###########################################
# INSTALL K3S
###########################################
curl -sfL https://get.k3s.io | sh -
sleep 15

###########################################
# COPY KUBECONFIG FOR JENKINS
###########################################
mkdir -p /var/jenkins_home/kubeconfig
cp /etc/rancher/k3s/k3s.yaml /var/jenkins_home/kubeconfig/config
chmod 600 /var/jenkins_home/kubeconfig/config

###########################################
# INSTALL MONGODB
###########################################
apt-get install -y mongodb
systemctl enable --now mongodb

sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongodb.conf || true
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf || true

systemctl restart mongodb

echo "SETUP COMPLETE"