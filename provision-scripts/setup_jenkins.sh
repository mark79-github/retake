#!/bin/bash

CRED_NAME=mark79
CRED_PASS=dckr_pat_PAXVuflqS7FoImDQx1zWWLz250g

echo "* Stop Jenkins"
systemctl stop jenkins

echo "* Turn off setup wizard"
sed -i 's/# arguments to pass to java/JAVA_OPTS="-Djenkins.install.runSetupWizard=false"/' /etc/default/jenkins

echo "* Upload Groovy scripts"
mkdir /var/lib/jenkins/init.groovy.d
cp /vagrant/jenkins/*.groovy /var/lib/jenkins/init.groovy.d/
chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d/

echo "* Start Jenkins" 
systemctl start jenkins

if [ -f "jenkins-plugin-manager-2.12.9.jar" ]; then
    echo "*** Jenkins Plugin Manager binary files found ..."
else 
    echo "*** Download Jenkins Plugin Manager" 
    wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.9/jenkins-plugin-manager-2.12.9.jar
fi

echo "* Install Plugins" 
java -jar jenkins-plugin-manager-*.jar --war /usr/share/java/jenkins.war --plugin-file /vagrant/jenkins/plugins.txt -d /var/lib/jenkins/plugins --verbose

echo "* Restart Jenkins" 
systemctl restart jenkins

if [ -f "jenkins-cli.jar" ]; then
    echo "*** Jenkins CLI binary files found ..."
else 
    echo "* Download Jenkins CLI"
    wget http://192.168.99.121:8080/jnlpJars/jenkins-cli.jar
fi

echo "* Create vagrant credentials"
/vagrant/jenkins/add-jenkins-credentials.sh vagrant vagrant vagrant

echo "* Create Docker Hub credentials"
/vagrant/jenkins/add-jenkins-credentials.sh docker-hub $CRED_NAME $CRED_PASS

echo "* Add slave node"
/vagrant/jenkins/add-jenkins-slave.sh docker vagrant

echo "* Add the homework job"
/vagrant/jenkins/add-jenkins-job.sh
