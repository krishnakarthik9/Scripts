# Before running this script drain node
# kubectl drain $NODE --ignore-daemonsets

VERSION=1.15.0-00

echo "upgrading kubeadm to $VERSION"
# replace x in 1.15.x-00 with the latest patch version
apt-mark unhold kubeadm
apt-get update
apt-get install -y --allow-downgrades kubeadm=${VERSION}
apt-mark hold kubeadm

kubeadm upgrade node

echo "upgrading kubelet and kubectl to $VERSION"
apt-mark unhold kubelet kubectl
apt-get update
apt-get install -y --allow-downgrades kubelet=${VERSION} kubectl=${VERSION}
apt-mark hold kubelet kubectl

echo "restarting kubelet"
systemctl restart kubelet

echo "Use kubectl to uncordon the node"
# kubectl uncordon $NODE