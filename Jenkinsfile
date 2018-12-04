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
        sh 'python build.py'
      }
    }
    stage('Test') {
      steps { 
        sh 'python build.py'
      }
    }
    stage('Deploy') {
     steps {
        sh 'cat /proc/loadavg'
      }
    }
  }
}
