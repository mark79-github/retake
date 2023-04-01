#!/bin/bash

# 
# Create Jenkins job
# 

echo "* Import job"
java -jar /home/vagrant/jenkins-cli.jar -s http://192.168.99.121:8080/ -http -auth admin:admin delete-job retake
java -jar /home/vagrant/jenkins-cli.jar -s http://192.168.99.121:8080/ -http -auth admin:admin create-job retake < /vagrant/jenkins/retake.xml

echo "* Build job"
java -jar /home/vagrant/jenkins-cli.jar -s http://192.168.99.121:8080/ -http -auth admin:admin build retake