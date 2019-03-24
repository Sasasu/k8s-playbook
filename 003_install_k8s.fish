. ./env.fish

set all_images (ssh $ALL_VM[1] /opt/bin/kubeadm config images list 2> /dev/null)

for image in $all_images
    docker pull $image
    for master in $ALL_VM
        docker save $image | ssh $master sudo docker load
    end
end

docker pull quay.io/coreos/flannel:v0.11.0-amd64
docker pull k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
for i in $ALL_VM
    docker save quay.io/coreos/flannel:v0.11.0-amd64 | ssh $i sudo docker load
end
