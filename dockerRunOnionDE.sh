#!/bin/bash

# docker network rm onionDENET
 [ `docker network ls | grep 'onionDENET' | cut -d ' ' -f 9` ] && echo "The network 「onionDENET」 has existed！" || docker network create -d bridge onionDENET


 [ `docker images | grep 'oniontraveler/onionde' | cut -d ' ' -f 1,4 --output-delimiter=':'` ] && echo "The image 「oniontraveler/onionde:19.6.6」 has existed！" || docker build -f ./myDockerfiles/onionfile -t oniontraveler/onionde:19.6.6 .

 [ `docker ps -a | grep 'onionDE' | rev | cut -d ' ' -f 1 | rev` ] && echo "The container 「onionDE」 has existed" || docker run -itd --name onionDE --hostname onionDE -p 3306:3306 -p 27017:27017 --network=onionDENET oniontraveler/onionde:19.6.6
 
 
 #========================= (port explanation)
# -p 「實體主機host」:「容器container」
# -p 3306:3306  -> MySQL
# -p 27017:27017    -> MongoDB


#========================= (docker commands for entering into the container(onionDE))
# docker exec -it onionDE /bin/bash


#========================= (docker commands for remove all containers)
# docker stop onionDE
# docker rm onionDE


