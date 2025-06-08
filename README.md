# LAMP Stack on Kubernetes (Apache + PHP + MySQL + phpMyAdmin)

This project deploys a **secure and modular LAMP environment on Kubernetes** using:

- **Apache + PHP 8.2**
- **MySQL 8**
- **phpMyAdmin**
- Environment secrets via Kubernetes **Secrets**
- Application code and SQL init script via **ConfigMaps**
- Persistent storage for MySQL

---

## Project Structure

```
.
├── .gitignore
├── config.env
├── README.md
├── k8s
│ ├── mysql-deployment.yaml
│ ├── mysql-init-configmap.yaml
│ ├── mysql-pv.yaml
│ ├── mysql-pvc.yaml
│ ├── php-deployment.yaml
│ ├── phpmyadmin-deployment.yaml
│ └── secrets.yaml
├── php
│ └── index.php
├── scripts
│ ├── cleanup.sh
│ └── deploy.sh
└── sql
└── init.sql
```

---

## Prerequisites

- Kubernetes cluster (e.g., Minikube, kind, k3s, or cloud)
- `kubectl` installed and configured
- Volume directory on host if using `hostPath` (e.g. `/data/mysql`)
- Optional: Ingress controller or port-forwarding

---

## Deployment

1. **Edit your credentials** in `config.env`:

```env
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=myapp
MYSQL_USER=user
MYSQL_PASSWORD=userpass
```

2. **Run the deployment script**:

```bash
./deploy.sh
```

This will:
- Create Secrets and ConfigMaps
- Apply PersistentVolume and PVC
- Deploy MySQL, Apache+PHP, and phpMyAdmin
- Expose services via NodePort

---

## Access Services

| Component     | URL                        |
|---------------|----------------------------|
| PHP Web App   | `http://localhost:30080`   |
| phpMyAdmin    | `http://localhost:30081`   |

> You can port-forward instead on clusters without NodePort:
> ```bash
> kubectl port-forward svc/php-apache 8080:80
> kubectl port-forward svc/phpmyadmin 8081:80
> ```

---

## Cleanup

To remove all resources:

```bash
./cleanup.sh
```

---

## What's Inside?

### `sql/init.sql`  
Creates a `products` table and inserts 3 sample products during container startup.

### `php/index.php`  
Connects to MySQL using environment variables and displays product data.

---

## Security Notes

- MySQL credentials are stored in **Kubernetes Secrets**.
- Sensitive configs are excluded from Git.
- Configurable via `.env` file and external mounts.

---

## TODO (Optional Enhancements)

- Add Ingress with HTTPS
- Use Helm chart structure
- Add horizontal scaling or health probes
- Separate dev/prod environments with `kustomize`
