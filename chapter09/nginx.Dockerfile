#Nginx 镜像
FROM nginx:1.17.0
#复制网站资源到站点目录
COPY index.html /usr/share/nginx/html/