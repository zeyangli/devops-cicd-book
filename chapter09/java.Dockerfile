#jdk1.8 版本镜像 
FROM openjdk:8-jdk
#将应用包添加到容器
ADD app.jar /app.jar
#启动服务
ENTRYPOINT ["java", "-jar", "/app.jar"]