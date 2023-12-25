@Library("devops06@main") _ 

//import  src/org/devops/Gitlab.groovy
def mygit = new org.devops.Gitlab()


//pipeline
pipeline{
    agent { label "build"}
    options {
        skipDefaultCheckout true
    }
    stages{
        stage("GetArtifact"){
            steps{
                script{
                    projectName = "${JOB_NAME}".split('_')[0] //devops6-maven-service
                    groupName = "${projectName}".split('-')[0]  //devops6
                    
                    projectID = mygit.GetProjectIDByName(projectName, groupName)
                    commitID = mygit.GetBranchCommitID(projectID, "${env.branchName}")
                    println(commitID)
                    appVersion = "${env.branchName}".split("-")[-1]  //9.9.9
                    println(appVersion)
                    currentBuild.description = "Version: ${appVersion}-${commitID}"

                    repoUrl = "http://192.168.1.200:8081/repository/${env.groupName}"  //nexus3
                    env.artifactName = "${projectName}-${appVersion}-${commitID}.jar"
                    artifactUrl = "${repoUrl}/${env.projectName}/${appVersion}-${commitID}/${env.artifactName}"
                    sh "wget --no-verbose ${artifactUrl} && ls -l"

                    env.releaseVersion = "${appVersion}-${commitID}"
                }
            }
        }

        stage("Deploy"){
            steps{
                script{
                    mydeploy.AnsibleDeploy()
                }
            }
        }
        stage("RollBack"){
            input {
                message "是否进行回滚？"
                ok "Yes"
                submitter ""
                parameters {
                    choice choices: ['NO','YES'], name: 'OPS'
                }
            }
            steps {
                echo "OPS  ${OPS}, doing......."

                script{
                    if ("${OPS}" == "YES"){
                        mydeploy.AnsibleRollBack()
                    }
                }
            }
        }
    }
}