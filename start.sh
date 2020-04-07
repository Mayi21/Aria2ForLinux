#!/usr/bin/env bash
#===============================================
# Mayi21 Aria2ForLinux one-cklick install script
# date:20200225
# Begin for Centos7
#===============================================
ip=''
updateAndInstall(){
    yum -y update
    yum -y install epel-release 
    yum -y install wget 
    yum -y install git 
    yum -y install unzip 
    yum -y install gcc 
    yum -y install gcc-c++ 
    yum -y install openssl-devel 
    yum -y install nginx 
    yum -y install bzip2
    yum -y install vim
    systemctl stop firewalld
}
install_ariang(){
    mkdir -p /data/Download
    mkdir -p /data/www/ariang
    cd /data/www/ariang/
    wget -N --no-check-certificate "https://github.com/mayswind/AriaNg/releases/download/1.1.4/Ariang-1.1.4.zip" && unzip Ariang-1.1.4.zip && rm -rf Ariang-1.1.4.zip
    cd /etc/nginx/conf.d/
    touch ariang.conf
    echo "server{
        listen 80;
        server_name ${ip};
        location / {
                root /data/www/ariang;
                index index.html index.htm;
        }}" > ariang.conf
    chmod -R 777 /data
    chmod -R 777 /data/www
    nginx -s stop
    nginx -c  /etc/nginx/nginx.conf
}
install_rclone(){
curl https://rclone.org/install.sh | sudo bash
if [ -f "/root/rclone.conf" ];then
    mv /root/rclone.conf /root/.config/rclone/
else
    rclone config
fi
}
install_aria2(){
yum -y update
wget -N https://raw.githubusercontent.com/Mayi21/Aria2ForLinux/master/aria2.sh && chmod +x aria2.sh
bash aria2.sh << EOF
1

EOF
bash aria2.sh << EOF
12
y
EOF
bash aria2.sh << EOF
6
EOF
if [ ! -f "/root/aria2.sh" ];then
    wget -N https://raw.githubusercontent.com/Mayi21/Aria2ForLinux/master/aria2.sh
fi
}
updateAndInstall
install_aria2
ip=$(wget -qO- -t1 -T2 ipinfo.io/ip)
install_ariang
install_rclone
bash /root/aria2.sh << EOF
8
EOF