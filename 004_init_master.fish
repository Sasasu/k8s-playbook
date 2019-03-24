. env.fish

for master in $MASTER_VM
    ssh $master sudo -E /opt/bin/kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$master
end

for node in $NODE_VM
    echo "[NOTE] now run kubeadm join on $node"
end
