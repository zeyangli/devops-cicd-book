#下载安装包
wget https://nodejs.org/dist/v14.16.1/node-v14.16.1-linux-x64.tar.xz
#解压安装包
tar xf node-v14.16.1-linux-x64.tar.xz -C /usr/local/
#修改环境变量
#vi /etc/profile
export NODE_HOME=/usr/local/node-v14.16.1-linux-x64 
export PATH=$NODE_HOME/bin:$PATH
source /etc/profile
#验证 
node -v 
# v14.16.1 
npm -v 
#6.14.12

#安装模块
npm install <moduleName> -g
#查看已安装包
npm list
#配置使用淘宝源
npm config set registry https://registry.npm.taobao.org 

#配置模块缓存路径
npm config set cache "/opt/npmcache/"

#构建
npm run build