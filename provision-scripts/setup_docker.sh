#!/bin/bash

echo "* Change Docker configuration to expose Prometheus metrics"
cp /vagrant/docker/daemon.json /etc/docker/

echo "* Restart Docker to apply the changes"
systemctl restart docker
