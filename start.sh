#!/usr/bin/env bash
#===============================================
# Mayi21 Aria2ForLinux one-cklick install script
# date:20200225
# Begin for Centos7
#===============================================
ip=""
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
    systemctl start nginx
    systemctl enable nginx.service
    systemctl stop firewalld
    echo "update and install complate!"
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
    systemctl restart nginx
}
install_rclone(){
    curl https://rclone.org/install.sh | sudo bash
}
updateAndInstall
read -p "请输入本机IP(please input ip):" ip
install_ariang
install_rclone
printf "aria2安装成功\n
        nginx安装成功\n
        ariang安装成功\n
        rclone安装成功,使用 rclone config配置rclone(默认rclone的名字为:GoogleDrive)\n"






