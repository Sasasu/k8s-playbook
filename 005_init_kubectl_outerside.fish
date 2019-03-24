. env.fish
mkdir -p $HOME/.kube

for master in $MASTER_VM
    ssh $master sudo cat /etc/kubernetes/admin.conf > $HOME/.kube/config
end
