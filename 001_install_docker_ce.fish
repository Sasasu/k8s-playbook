. ./env.fish

for i in $ALL_VM
    ssh $i 'sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common ebtables ethtool socat'
    ssh $i 'curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -'
    ssh $i 'sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"'
    ssh $i 'sudo apt-get update'
    ssh $i 'sudo apt-get install -y docker-ce docker-ce-cli containerd.io'
    ssh $i 'sudo docker run hello-world'
    ssh $i 'sudo usermod -a -G docker $(whoami)'
end
