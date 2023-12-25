package org.devops


// SonarScannerByPlugin
def SonarScannerByPlugin(){
    withSonarQubeEnv(credentialsId: 'fdf4362a-69e7-4014-8fa7-80b1ba268588') {              
        withCredentials([usernamePassword(credentialsId: '9ff42b72-597e-49dd-a62f-2553d48304fc', 
                                            passwordVariable: 'SONAR_PASSWD', 
                                            usernameVariable: 'SONAR_USER')]) {
            sh """
                sonar-scanner \
                -Dsonar.login=${SONAR_USER} \
                -Dsonar.password=${SONAR_PASSWD} \
                -Dsonar.host.url=http://192.168.1.200:9000 \
                -Dsonar.branch.name=${env.branchName}
            """
        }
    }
}


// SonarScanner
def SonarScanner(){
    withCredentials([usernamePassword(credentialsId: '9ff42b72-597e-49dd-a62f-2553d48304fc', 
                                        passwordVariable: 'SONAR_PASSWD', 
                                        usernameVariable: 'SONAR_USER')]) {
        sh """
            sonar-scanner \
            -Dsonar.login=${SONAR_USER} \
            -Dsonar.password=${SONAR_PASSWD} \
            -Dsonar.host.url=http://192.168.1.200:9000 \
            -Dsonar.branch.name=${env.branchName}
        """
    }
}


