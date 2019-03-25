. env.fish

kubectl apply -f config/mandatory.yaml
kubectl apply -f config/service-nodeport.yaml
kubectl port-forward services/ingress-nginx 1280:80 -n ingress-nginx
