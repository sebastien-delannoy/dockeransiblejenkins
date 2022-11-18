pipeline {
  environment {
    registry = "sebastiendelannoy/dockhelloapp"
    registryCredential = 'git'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/sebastien-delannoy/dockeransiblejenkins.git'
      }
    }
    stage('Building image') {
      steps{
       
         sh "sudo docker build ."
       
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
