package org.devops


def PushNexusArtifact(repoId, targetDir, pkgPath, sourcePkgName,targetPkgName){
    //nexus api 
    withCredentials([usernamePassword(credentialsId: '71cbafcb-6447-4213-b214-46535a2ef733', \
                                    passwordVariable: 'PASSWD', 
                                    usernameVariable: 'USERNAME')]) {
        sh """
            curl -X 'POST' \
              "http://192.168.1.200:8081/service/rest/v1/components?repository=${repoId}" \
              -H 'accept: application/json' \
              -H 'Content-Type: multipart/form-data' \
              -F "raw.directory=${targetDir}" \
              -F "raw.asset1=@${pkgPath}/${sourcePkgName};type=application/java-archive" \
              -F "raw.asset1.filename=${targetPkgName}" \
              -u ${USERNAME}:${PASSWD}
        """
    }
}

def PushArtifactByPluginPOM(){
    POM = readMavenPom file: 'pom.xml'
    println(POM)
    println("GroupID: ${POM.groupId}")
    println("ArtifactID: ${POM.artifactId}")
    println("Version: ${POM.version}")
    println("Packaging: ${POM.packaging}")

    env.artifactId = "${POM.artifactId}"
    env.packaging = "${POM.packaging}"
    env.groupId = "${POM.groupId}"
    env.art_version = "${POM.version}"
    env.art_name = "${env.artifactId}-${env.art_version}.${env.packaging}"
    nexusArtifactUploader   artifacts: [[artifactId: "${env.artifactId}", 
                                        classifier: '', 
                                        file: "target/${env.art_name}", 
                                        type: "${env.packaging}"]], 
                            credentialsId: '71cbafcb-6447-4213-b214-46535a2ef733', 
                            groupId: "${env.groupId}", 
                            nexusUrl: '192.168.1.200:8081', 
                            nexusVersion: 'nexus3', 
                            protocol: 'http', 
                            repository: 'maven-devops6-release', 
                            version: "${env.art_version}"
}

def PushArtifactByPlugin(){
    nexusArtifactUploader   artifacts: [[artifactId: 'demo-app', 
                                        classifier: '', 
                                        file: 'target/demo-0.0.1-SNAPSHOT.jar', 
                                        type: 'jar']], 
                            credentialsId: '71cbafcb-6447-4213-b214-46535a2ef733', 
                            groupId: 'com.devops6', 
                            nexusUrl: '192.168.1.200:8081', 
                            nexusVersion: 'nexus3', 
                            protocol: 'http', 
                            repository: 'maven-devops6-release', 
                            version: '1.1.1'

}
