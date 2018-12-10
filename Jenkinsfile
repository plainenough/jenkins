pipeline {
  agent any
  stages {
    stage('Setup'){
      steps {
        slackSend "Build Started - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
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
