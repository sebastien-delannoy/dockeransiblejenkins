def dockerHubPwd = "Test12345"

pipeline{
    agent any
    tools {
      maven 'MAVEN'
    }
    environment {
      DOCKER_TAG = getVersion()
      
    }
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'git', 
                    url: 'https://github.com/sebastien-delannoy/dockeransiblejenkins.git'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        
        stage('Building our image') {
            steps{
            script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
            }
        
     
        
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u sebastiendelannoy -p ${dockerHubPwd}"
                }
                
                sh "docker push sebastiendelannoy/helloapp:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
