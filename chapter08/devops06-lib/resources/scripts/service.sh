#!/bin/bash

# sh service.sh anyops-devops-service 1.1.1 8091 start
APPNAME=NULL
VERSION=NULL
PORT=NULL

start(){
    port_result=`netstat -anlpt | grep "${PORT}" || echo false`

    if [[ $port_result == "false" ]];then
        nohup java -jar -Dserver.port=${PORT}  ${APPNAME}-${VERSION}.jar >${APPNAME}.log.txt 2>&1 &
    else
       stop
       sleep 5
       nohup java -jar -Dserver.port=${PORT}  ${APPNAME}-${VERSION}.jar >${APPNAME}.log.txt 2>&1 &
    fi
}


stop(){
    pid=`netstat -anlpt | grep "${PORT}" | awk '{print $NF}' | awk -F '/' '{print $1}' | head -1`
    kill -15 $pid
}


check(){
    proc_result=`ps aux | grep java | grep "${APPNAME}" | grep -v grep || echo false`
    port_result=`netstat -anlpt | grep "${PORT}" || echo false`
    url_result=`curl -s http://localhost:${PORT} || echo false `

    if [[ $proc_result == "false" || $port_result == "false" || $url_result == "false" ]];then
        echo "server not running"
    else
        echo "ok"
    fi
}

case $1 in
    start)
        start
        sleep 5
        check
        ;;

    stop)
        stop
        sleep 5
        check
        ;;
    restart)
        stop
        sleep 5
        start
        sleep 5
        check
        ;;
    check)
        check
        ;;
    *)
        echo "sh service.sh {start|stop|restart|check}"
        ;;
esac

