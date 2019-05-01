pipeline {
  agent any
  environment {
    registryCredential = 'dockerhub'
    jenkinsMaster = ''
    version = "2.164.2-$BUILD_NUMBER"
    linuxSlave = ''
    windowsSlave = ''
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
        script {
            masterName = String.format("derrickwalton/jenkins:%s", version)
            jenkinsMaster = docker.build(masterName, "-f ./container/linux/Dockerfile.Master --no-cache .")
            docker.withRegistry( '', registryCredential ) {
                jenkinsMaster.push()
            }
        }
        script {
            slaveName = String.format("derrickwalton/jnlp-slave-linux:%s", version)
            linuxSlave = docker.build(slaveName, "-f ./container/linux/Dockerfile.Slave --no-cache .")
            docker.withRegistry( '', registryCredential) {
                linuxSlave.push()
            }
            slaveLatest  = String.format("derrickwalton/jnlp-slave-linux:latest")
            linuxSlave = docker.build(slaveLatest, "-f ./container/linux/Dockerfile.Slave .")
            docker.withRegistry( '', registryCredential) {
                linuxSlave.push()
            }
        }
        //script {
            //windowSlave = docker.build("derrickwalton/jnlp-slave-windows:$BUILD_NUMBER", "--no-cache .")
        //}
        sh 'echo "Completed the build and push process."'
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
      lastChanges since: 'LAST_SUCCESSFUL_BUILD', format:'SIDE',matching: 'LINE'
      notifyBuild('NOTIFY')
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
  } else if (buildStatus == 'NOTIFY') {
    color = 'GREEN'
    colorCode = '#2E9022'
    channelName = '#dev-deployment'
    details = """ Built ${env.BUILD_NUMBER} in ${env.JOB_NAME} has run (${env.BUILD_URL}last-changes/)"""
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
