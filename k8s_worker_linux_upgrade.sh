# Before running this script drain node
# kubectl drain $NODE --ignore-daemonsets

VERSION=v1.15.0
K8S_BIN_PATH=/opt/bin

cd ${K8S_BIN_PATH}
echo "Moving the binaries to backup folder"
mkdir backup
mv crictl kubeadm kubectl kubelet backup/

# upgrades crictl, kubeadm, kubectl, kubelet
curl -L "https://github.com/kubernetes-sigs/cri-tools/releases/download/${VERSION}/crictl-${VERSION}-linux-amd64.tar.gz" | tar -C ${K8S_BIN_PATH} -xz

curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/{kubeadm,kubelet,kubectl}
chmod +x {kubeadm,kubelet,kubectl}

kubeadm upgrade node

echo "Restarting Kubelet"
systemctl restart kubelet

echo "You can delete old binaries using rm -r ${K8S_BIN_PATH}/backup"

echo "Use kubectl to uncordon the node"
# kubectl uncordon $NODE