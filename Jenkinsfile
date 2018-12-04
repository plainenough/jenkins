pipeline {
  agent any
  stages {
    stage('Setup'){
      steps {
        sh '/usr/bin/python setup.py'
      }
    }
    stage('Build') {
      steps { 
        sh 'build.py'
      }
    }
    stage('Test') {
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
