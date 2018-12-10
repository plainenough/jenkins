
pipeline {
  agent any
  stages {
    stage('Setup'){
      steps {
        notifyBuild('STARTED')
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
        sh 'python test.py'
      }
    }
    stage('Cleanup') {
     steps {
        sh 'cat /proc/loadavg'
      }
    }
  }
  post {
    failure {
      //result = 'failed'
      notifyBuild(currentBuild.result)
    }
    success {
      //result = 'SUCCESS'
      notifyBuild(currentBuild.result)
    }
  }
}

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'
  
  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def channelName = '#random'
  def details = """STARTED: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}
  Check console output at ${env.BUILD_URL}${env.JOB_NAME} ${env.BUILD_NUMBER}"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
    details = """SUCCESS (${env.BUILD_URL})"""
  } else {
    color = 'RED'
    colorCode = '#FF0000'
    details = """FAILED: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}
  Check console output at ${env.BUILD_URL}${env.JOB_NAME} ${env.BUILD_NUMBER}"""
  }
  // Send notifications
  slackSend (color: colorCode, message: detailsi, channel: channelName)
}
