
# Deploying Globus-Personal-Docker on Nautilus

This guide provides step-by-step instructions to deploy the Globus-Personal-Docker Helm chart on the Nautilus Kubernetes platform.

## Prerequisites

Before you begin, ensure you have the following:

- Access to a Nautilus Kubernetes cluster.
- `kubectl` installed and configured to interact with your Nautilus cluster.
- `helm` installed on your local machine.
- Docker image of Globus-Personal-Docker pushed to a container registry accessible by your Nautilus cluster.

## Deployment Steps

### 1. Clone the Repository

Clone the Globus-Personal-Docker repository to your local machine:

```bash
git clone https://github.com/your-repo/globus-personal-docker.git
cd globus-personal-docker
```

### 2. Configure Values

Edit the `values.yaml` file to configure your deployment settings. Ensure you set the correct `currentUser`, `endpointName`, and any other necessary configurations:

```yaml
image:
  repository: your-docker-repo/globus
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

persistence:
  config:
    enabled: true
    size: 1Gi
    storageClass: "your-storage-class"
  data:
    enabled: true
    size: 5Gi
    storageClass: "your-storage-class"

globus:
  endpointName: "myep"
  currentUser: "gridftp"
```

### 3. Deploy the Helm Chart

Use Helm to deploy the chart to your Nautilus cluster:

```bash
helm install globus-personal-docker ./globus-personal-docker
```

### 4. Verify the Deployment

Check the status of your deployment to ensure everything is running smoothly:

```bash
kubectl get pods
kubectl get services
```

### 5. Access the Application

Depending on your service type, you may need to set up port forwarding or use a LoadBalancer to access the application. For a `ClusterIP` service, you can use port forwarding:

```bash
kubectl port-forward svc/globus-personal-docker 8080:80
```

Then, access the application at `http://localhost:8080`.

## Troubleshooting

- **Pod Issues:** If your pods are not running, check the logs for errors:

  ```bash
  kubectl logs <pod-name>
  ```

- **Helm Issues:** If the Helm deployment fails, check the Helm release status:

  ```bash
  helm status globus-personal-docker
  ```

## Cleanup

To remove the deployment from your cluster, use the following command:

```bash
helm uninstall globus-personal-docker
```

This guide should help you deploy the Globus-Personal-Docker application on Nautilus. Adjust the configurations as needed for your specific environment and requirements.