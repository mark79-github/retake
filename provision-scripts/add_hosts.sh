#!/bin/bash

{
    echo "192.168.99.121 pipelines.retake.exam jenkins"
    echo "192.168.99.122 containers.retake.exam docker"
    echo "192.168.99.123 monitoring.retake.exam monitoring" 
} >> /etc/hosts
