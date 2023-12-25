#FROM 指定基础镜像 
FROM nginx:1.17.0
#MAINTAINER 维护者信息
MAINTAINER jenkins <jenkins@example.com>
#WORKDIR 指定工作目录 
WORKDIR /dist
#ENV 构建时环境变量 
ENV BUILD_TYPE=web
#ARG 构建镜像时可以通过–build-arg 指定参数 
ARG image_name=centos
#RUN 运行 Shell 命令 
RUN echo hello
#ADD 添加文件
ADD run.sh /run.sh
#COPY 复制文件或目录
COPY index.html /usr/share/nginx/html
#VOLUME 定义共享存储卷或者临时存储卷 
VOLUME /shareddata
#EXPOSE 指定容器开放端口 
EXPOSE 80
#USER 指定容器运行时用户身份 
USER root
#ENTRYPOINT 容器启动执行的命令 
ENTRYPOINT ["/start.sh"]
#CMD 容器启动执行的命令
CMD ["yum", "-y", "install","wget"]