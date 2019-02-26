#!/bin/bash

# This script is meant to be run in the User Data of each EC2 Instance while it's booting.

# Install jenkins
sudo yum -y update

sudo yum install -y java-1.8.0-openjdk.x86_64

sudo /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java

sudo /usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac

sudo yum remove -y java-1.7*

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins
sudo service jenkins start
sudo chkconfig --add jenkins

