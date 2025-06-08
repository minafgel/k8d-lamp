#!/bin/bash

# Cleanup Kubernetes LAMP stack resources
kubectl delete deployment php-apache mysql phpmyadmin
kubectl delete service php-apache mysql phpmyadmin
kubectl delete pvc mysql-pvc
kubectl delete pv mysql-pv
kubectl delete configmap php-code mysql-init-script
kubectl delete secret mysql-secrets
echo "All resources deleted successfully."
