. env.fish

kubectl apply -f app hello-word-nginx.yaml
kubectl port-forward deployment/hello-word 1280:80
