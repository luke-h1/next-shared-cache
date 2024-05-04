start in docker

```bash
docker-compose up
```

start in kubernetes

```bash
docker build -t nextjs-docker .
kubectl apply -f k8s/configmaps/nextjs.yaml
kubectl apply -f k8s/deployments/nextjs.yaml
kubectl apply -f k8s/deployments/redis.yaml
kubectl apply -f k8s/services/nextjs.yaml
kubectl apply -f k8s/services/redis.yaml
```
