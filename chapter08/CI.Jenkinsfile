//加载共享库 
@Library("devops06@main") _
//导入模块
def build = new org.devops.Build()
def sonar = new org.devops.Sonar()
def artifact = new org.devops.Artifact() 
def checkout = new org.devops.Checkout()
//使用 git 参数需要格式化 
//删除分支前面的“origin/”字符
env.branchName = "${env.branchName}" - "origin/" 
println(env.branchName)

//持续集成流水线 
pipeline {
   agent { label "build"}
   options {
      skipDefaultCheckout true
   } 
   stages{
      stage("CheckOut"){
         steps{
            script{
               build.CheckOut()
            }
         }
      } 

      stage("Build"){
         steps{
            script{
               build.Build()
            } 
         }
      }

      stage("CodeScan"){
         steps{
            script{
               sonar.SonarScannerByPlugin()
            } 
         }
      }
      stage("PushArtifact"){
         steps{
            script{
               //PushArtifactByPlugin()
               //PushArtifactByPluginPOM()
               //init package info
               appName = "${JOB_NAME}".split('_')[0] //devops6-maven-service 
               repoName = appName.split('-')[0] //devops6
               //获取 commitID
               commitID = checkout.GetCommitID()
               println(commitID)
               appVersion = "${env.branchName}".split("-")[-1]
               appVersion = "${appVersion}-${commitID}" targetDir="${appName}/${appVersion}"
               //通过 pom 文件获取包名称
               POM = readMavenPom file: 'pom.xml'
               env.artifactId = "${POM.artifactId}"
               env.packaging = "${POM.packaging}"
               env.groupId = "${POM.groupId}"
               env.art_version = "${POM.version}"
               sourcePkgName = "${env.artifactId}-${env.art_version}.${env.packaging}"
               pkgPath = "target"
               targetPkgName = "${appName}-${appVersion}.${env.packaging}" 
               
               //上传制品
               artifact.PushNexusArtifact(repoName, targetDir, pkgPath,sourcePkgName,targetPkgName)
               
            } 
         }
      }
   }
}