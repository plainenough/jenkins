pipeline {
  agent any
  stages {
    stage('Setup'){
      steps {
        def notifySlack(String buildStatus = 'STARTED') {
            // Build status of null means success.
            buildStatus = buildStatus ?: 'SUCCESS'
            def msg = "${buildStatus}: `${env.JOB_NAME}` #${env.BUILD_NUMBER}:\n${env.BUILD_URL}"
            slackSend(color: '#D4DADF', message: msg)
            }

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
