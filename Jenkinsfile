pipeline {
  environment {
    registry = “derrickwalton/jenkins”
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Setup'){
      steps {
        git 'https://github.com/plainenough/test-pipeline.git'
      }
    }
    stage('Building image'){
      steps {
        script {
          dockerImage = docker.build registry + “:$BUILD_NUMBER”
        }
      }
    }
    stage('Deploy Image'){
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
  }
}
