package org.devops

//发起HTTP请求
def HttpReq(method, apiUrl){
    withCredentials([string(credentialsId: '79f07070-bca3-4294-bcb4-c066449d6ffc', 
                            variable: 'gitlabtoken')]) {
        response = sh  returnStdout: true, 
        script: """ 
            curl --location --request ${method} \
            http://192.168.1.200:8076/api/v4/${apiUrl} \
            --header "PRIVATE-TOKEN: ${gitlabtoken}"
        """
    }
    response = readJSON text: response - "\n"
    return response
}

//获取ProjectID
def GetProjectIDByName(projectName, groupName){
    apiUrl = "projects?search=${projectName}"
    response = HttpReq("GET", apiUrl)
    if (response != []){
        for (p in response) {
            if (p["namespace"]["name"] == groupName){
                return response[0]["id"]
            }
        }
    }
}

//获取分支CommitID
def GetBranchCommitID(projectID, branchName){
    apiUrl = "projects/${projectID}/repository/branches/${branchName}"
    response = HttpReq("GET", apiUrl)
    return response.commit.short_id
}
