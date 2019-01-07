pipeline {
  agent any
  environment {
    registry = "derrickwalton/jenkins"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  stages {
    stage('Setup'){
      steps {
        notifyBuild('STARTED')
        sh 'echo "Begin setup"'
        git 'https://github.com/plainenough/test-pipelines'
      }
    }
    stage('Build') {
      steps {
        sh 'echo "Begin build"'
        sh 'docker build -t  derrickwalton/jenkins":$BUILD_NUMBER" '
        sh 'echo "Build complete"'
        sh 'echo "we moved out of the script"'
      }
    }
    stage('Test') {
      steps { 
        sh 'echo "Begin test"'
        // This portion will render test results. We can use this block to 
        // also post those results on tickets, in channels, or via email to
        // stakeholders for the products. 
      }
    }
    stage('Cleanup') {
     steps {
        sh 'echo "Begin cleanup"'
        script {
          docker.withRegistry( ‘’, registryCredential ) {
            dockerImage.push()
          }
        }
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
  def channelName = '#jenkins_alerts' // This is where you would set your custom channel. 
  def details = """STARTED: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}
  Check console output at ${env.BUILD_URL}${env.JOB_NAME} ${env.BUILD_NUMBER}"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#2E9022'
    details = """SUCCESS (${env.BUILD_URL})"""
  } else {
    color = 'RED'
    colorCode = '#FF0000'
    details = """FAILED: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}
  Check console output at ${env.BUILD_URL}${env.JOB_NAME} ${env.BUILD_NUMBER}"""
  }
  // Send notifications
  slackSend (color: colorCode, message: details, channel: channelName )
}

// TODO: Add some Disclaimers and document the pipeline
// TODO: Add controlled functionality for emailing users
// TODO: Accommodate the idea of posting to multiple slack channges. 
