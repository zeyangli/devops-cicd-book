#创建目录
mkdir -p /data/devops/nexus3/data chmod 777 -R /data/devops/nexus3/
#启动容器
docker run -itd \
-p 8081:8081 \
-v /data/devops6/nexus3/:/nexus-data \ 
--name nexus3 sonatype/nexus3:3.53.0