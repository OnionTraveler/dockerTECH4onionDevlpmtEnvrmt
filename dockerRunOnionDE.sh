#!/bin/bash

# docker network rm onionDENET
 [ `docker network ls | grep 'onionDENET' | cut -d ' ' -f 9` ] && echo "The network 「onionDENET」 has existed！" || docker network create -d bridge onionDENET


 [ `docker images | grep 'oniontraveler/onionde' | cut -d ' ' -f 1,4 --output-delimiter=':'` ] && echo "The image 「oniontraveler/onionde:19.6.6」 has existed！" || docker build -f ./myDockerfiles/onionfile -t oniontraveler/onionde:19.6.6 .

 [ `docker ps -a | grep 'onionDE' | rev | cut -d ' ' -f 1 | rev` ] && echo "The container 「onionDE」 has existed" || docker run -itd --name onionDE --hostname onionDE -p 3306:3306 -p 27017:27017 --network=onionDENET oniontraveler/onionde:19.6.6
 
 
#========================= (port explanation)
# -p 「實體主機host」:「容器container」
# -p 3306:3306    -> MySQL
# -p 27017:27017  -> MongoDB


#========================= (docker commands for entering into the container(onionDE))
# docker exec -it onionDE /bin/bash


#========================= (docker commands for remove all containers)
# docker stop onionDE
# docker rm onionDE


#========================= (docker commands for set up SSH Remote Development Container) (「docker exec -it onionDE4RmtDev /bin/bash」)
# Step1：「mkdir ~/Desktop/onionDE4RmtDevDir && cd ~/Desktop/onionDE4RmtDevDir」
# Step2：「docker run -itd --name onionDE4RmtDev --hostname onionDE4RmtDev -v ~/Desktop/onionDE4RmtDevDir:/root/onionDE4RmtDevDir -p 2222:22 --network=onionDENET oniontraveler/onionde:19.6.6」
# Step3：「docker exec -i onionDE4RmtDev /bin/bash -c 'cd ~/.ssh && cat /root/onionDE4RmtDevDir/id_rsa.pub >> ./authorized_keys'」
# Step4：在客戶端執行「.\ssh.exe root@xxx.xxx.xxx.xxx -p 2222」 -> 以指定帳號(是要用遠端伺服上已存在的帳號，這裡是用root作為範例(通常container裡的預設帳號為root))連線到目標Server的指定port號

# SSH說明： (「id_rsa」&「id_rsa.pub」由客戶端執行「.\ssh-keygen.exe -t rsa -f C:\Users\user\.ssh\id_rsa」產生(在Windows裡不要使用「-P ''」這個參數，這會造成客戶端無法辨識私鑰))
# 「~/.ssh/id_rsa」：私鑰(金鑰) --> 權限為「600」--> 客戶端產生，放在客戶端
# 「~/.ssh/id_rsa.pub」：公鑰 --> 權限為「644」--> 客戶端產生，放在伺服端
# 「~/.ssh/authorized_keys」：受權本 --> 權限為「644」--> 伺服端產生，把客戶端的公鑰內容寫入本檔


#========================= (common commands for linux in container)
# 「echo 'root:10112222' | chpasswd」：設定指定帳號(root)的密碼(10112222)
# 「chmod 777 ./xxx」：將指定檔案(或目錄)修改「讀寫執行的權限」為最大 (【r:4 w:2 x:1】、【擁有者的權限、所屬群組的權限、其他人的權限】)
# 「chown onion ./xxx」：將指定檔案(或目錄)修改「擁有者」為「onion」
# 「chgrp onionGrp ./xxx」：將指定檔案(或目錄)修改「所屬群組」為「onionGrp」


