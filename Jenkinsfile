pipeline {
  agent any
  stages {
    stage('Setup'){
      steps {
        notifyBuild('STARTED')
        // Some example of code here. This section is for the setup steps
        // Like refreshing the AMI stuff so on it is good to break this bit
        // out so that we are able to identify environment based issues.
      }
    }
    stage('Build') {
      steps { 
        // Knowing that we have a good build environment is crucial before
        // actually attempting a build. This section should only build an 
        // application and place it "locally' to be tested and should 
        // prepare that build to be deployed into a repository of some sort. 
      }
    }
    stage('Test') {
      steps { 
        // This portion will render test results. We can use this block to 
        // also post those results on tickets, in channels, or via email to
        // stakeholders for the products. 
      }
    }
    stage('Cleanup') {
     steps {
        // This cleanup stage should be for tagging all of the correct repos
        // with the jenkins build number, it should also actually deliver the
        // the artifact into the repository for consumption by future jobs. 
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
  def channelName = '#test' // This is where you would set your custom channel. 
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
