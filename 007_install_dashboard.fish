. env.fish

kubectl apply -f config/kubernetes-dashboard.yaml

for i in $ALL_VM
   docker save k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1 | ssh $i docker load
end
