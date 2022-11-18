pipeline{
    agent any
    tools {
      maven 'MAVEN'
    }
    environment {
      DOCKER_TAG = getVersion()
    }
    stages{
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
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
