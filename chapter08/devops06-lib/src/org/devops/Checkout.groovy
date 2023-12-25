package org.devops

def GetCommitID(){
    ID = sh returnStdout: true, script: "git rev-parse HEAD" 
    commitID = ID[0..7]
    return commitID
}
