#下载安装包
wget https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.8.6/binaries/ apache-maven-3.8.5-bin.tar.gz

#解压安装包
tar zxf apache-maven-3.8.5-bin.tar.gz -C /usr/local/
cd /usr/local/apache-maven-3.8.6/

#配置环境变量
vi /etc/profile
export M2_HOME=/usr/local/apache-maven-3.8.6 export PATH=$M2_HOME/bin:$PATH
source /etc/profile

#验证
#mvn -v
Apache Maven 3.8.6 (84538c9988a25aec085021c365c560670ad80f63)
Maven home: /data/devops5/tools/apache-maven-3.8.6
Java version: 1.8.0_201, vendor: Oracle Corporation, runtime: /usr/local/ jdk1.8.0_201/jre
Default locale: zh_CN, platform encoding: UTF-8
OS name: "linux", version: "4.18.0-373.el8.x86_64", arch: "amd64", family: "unix"

# maven命令
#清理构建目录和缓存 
mvn clean 
#项目打包
mvn clean package 
#项目打包并部署本地 
mvn clean install 
#进行单元测试
mvn clean test
#指定配置文件
mvn clean package -f ../pom.xml 
#运行打包并跳过单元测试
mvn clean package -DskipTests
mvn claan package -Dmaven.test.skip=true 
#将包发布到远程制品库
mvn deploy