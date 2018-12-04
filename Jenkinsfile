pipeline {
  agent any
  stages {
    stage('Setup'){
      steps {
        sh 'setup.py' 
      }
    }
    stage('Build') {
      steps { 
        sh 'build.py'
      }
    }
    stage('test') {
      steps { 
        sh 'build.py'
      }
    }
    stage('Deploy') {
     steps {
        sh 'deply.py'
      }
    }
  }
}
