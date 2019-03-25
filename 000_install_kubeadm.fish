. ./env.fish

wget "https://github.com/containernetworking/plugins/releases/download/$CNI_VERSION/cni-plugins-amd64-$CNI_VERSION.tgz"
wget "https://github.com/kubernetes-incubator/cri-tools/releases/download/$CRICTL_VERSION/crictl-$CRICTL_VERSION-linux-amd64.tar.gz"
wget https://storage.googleapis.com/kubernetes-release/release/$RELEASE/bin/linux/amd64/{kubeadm,kubelet,kubectl}
curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/$RELEASE/build/debs/kubelet.service" > kubelet.service
curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/$RELEASE/build/debs/10-kubeadm.conf" > 10-kubeadm.conf

for i in $ALL_VM
    echo doing $i
    ssh $i sudo sh -c "\"mkdir -p /etc/systemd/system/kubelet.service.d\""

    cat cni-plugins-amd64-$CNI_VERSION.tgz | ssh $i sudo "tar -C /usr/bin -xz"
    cat crictl-$CRICTL_VERSION-linux-amd64.tar.gz | ssh $i sudo "tar -C /usr/bin -xz"
    for f in kubeadm kubelet kubectl
        cat $f | ssh $i sudo sh -c "\"cat > /usr/bin/$f\""
        ssh $i sudo "chmod +x /usr/bin/$f"
    end

    cat kubelet.service | ssh $i sudo sh -c "\"cat > /etc/systemd/system/kubelet.service\""
    cat 10-kubeadm.conf | sed "s:/usr/bin/kubelet:/usr/bin/kubelet --node-ip=$i:g" | ssh $i sudo sh -c "\"cat > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf\""
    ssh $i sudo "systemctl enable --now kubelet"
    echo 'export PATH="$PATH:/opt/bin"' | ssh $i "cat >> ~/.bashrc"
end
