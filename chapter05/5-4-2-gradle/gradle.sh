#解压安装包
unzip gradle-7.5.1-bin.zip -d /usr/local/
#配置环境变量
vi /etc/profile
export GRADLE_HOME=/usr/local/gradle-7.5.1/
export PATH=$GRADLE_HOME/bin:$PATH
source /etc/profile
#验证 gradle -v

#清理构建目录和缓存 
gradle clean 

#构建项目
gradle build 

#构建项目并跳过测试 
gradle build -x test