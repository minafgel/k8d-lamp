#!/bin/bash

kubectl apply -f ../k8s/mysql-pv.yaml
kubectl apply -f ../k8s/mysql-pvc.yaml
kubectl apply -f ../k8s/mysql-init-configmap.yaml
kubectl apply -f ../k8s/mysql-deployment.yaml
kubectl apply -f ../k8s/php-deployment.yaml
kubectl apply -f ../k8s/phpmyadmin-deployment.yaml
