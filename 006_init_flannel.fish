. env.fish

kubectl apply -f  config/kube-flannel.yml

for i in $ALL_VM
    ssh $i sudo sysctl net.bridge.bridge-nf-call-iptables=1
end
