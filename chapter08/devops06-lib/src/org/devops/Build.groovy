package org.devops


//check out
def CheckOut(){
    println("CheckOut")
    checkout([$class: 'GitSCM', 
        branches: [[name: "${env.branchName}"]], 
        extensions: [], 
        userRemoteConfigs: [[credentialsId: 'gitlab-admin', 
        url: "${params.srcUrl}"]]])
    sh "ls -l "  //验证
}

//run  build
def Build(){
    println("Build")
    sh "${params.buildShell}" 
}
