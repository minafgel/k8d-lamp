#!/bin/bash

# Start Kubernetes LAMP stack deployment

# Create Secret from .env file
kubectl create secret generic mysql-secrets --from-env-file=../config.env --dry-run=client -o yaml | kubectl apply -f -

# Create ConfigMaps from init.sql and index.php files
kubectl create configmap mysql-init-script --from-file=../sql/init.sql --dry-run=client -o yaml | kubectl apply -f -

kubectl create configmap php-code --from-file=../php/index.php --dry-run=client -o yaml | kubectl apply -f -

# Apply Kubernetes YAML files
kubectl apply -f ../k8s/mysql-pv.yaml
kubectl apply -f ../k8s/mysql-pvc.yaml
kubectl apply -f ../k8s/mysql-deployment.yaml
kubectl apply -f ../k8s/php-deployment.yaml
kubectl apply -f ../k8s/phpmyadmin-deployment.yaml

echo "Deployment completed successfully."
echo "PHP app at: http://localhost:30080"
echo "phpMyAdmin at: http://localhost:30081"
