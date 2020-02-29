# Update
apt update && apt upgrade -y

# VIM
apt install vim -y

# GIT
apt install git -y

# JAVA
apt install openjdk-8-jdk openjdk-8-jre -y
cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
EOL

# ZSH
apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

