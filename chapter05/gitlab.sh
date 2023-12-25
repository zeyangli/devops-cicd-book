## 创建数据目录
mkdir -p /data/devops/gitlab/{config, logs, data}
chmod +x -R /data/devops/gitlab

## docker 启动容器
docker run -itd --name gitlab \
-p 443:443 \
-p 80:80 \
--restart always \
--hostname 192.168.1.200 \
-v /data/devops/gitlab/config:/etc/gitlab \
-v /data/devops/gitlab/logs:/var/log/gitlab \
-v /data/devops/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:15.0.3-ce.0