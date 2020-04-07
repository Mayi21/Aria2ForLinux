#!/usr/bin/env bash
aria2_conf="/root/.aria2/aria2.conf"
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
    systemctl start nginx
    systemctl enable nginx.service
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
install_aria2{
    yum -y install aria2
    yum -y install git
    # create folder
    if [ ! -d '/root/.aria2' ];then
        mkdir /root/.aria2
        mkdir /root/Download
    fi
    # download conf
    cd /root/.aria2
    git clone "https://github.com/Mayi21/Aria2ForLinux.git"
    mv Aria2ForLinux/conf/* /root/.aria2/
    rm -rf aria2.conf
    mv aria.conf aria2.conf
    bash <(wget -qO- git.io/tracker.sh) ${aria2_conf}
    aria2c --conf-path=/root/.aria2/aria2.conf -D
    echo "aria2c --conf-path=/root/.aria2/aria2.conf -D &" > /etc/rc.d/rc.local
}
updateAndInstall
ip=$(wget -qO- -t1 -T2 ipinfo.io/ip)
install_ariang
install_aria2
