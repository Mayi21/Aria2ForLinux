install_aria2(){
yum -y update
wget -N https://raw.githubusercontent.com/Mayi21/Aria2ForLinux/master/aria2.sh
chmod +x aria2.sh
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
}
install_aria2