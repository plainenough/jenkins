
pipeline {
  agent any
  
  //try { 
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
          sh 'python build.py'
        }
      }
      stage('Cleanup') {
       steps {
          sh 'cat /proc/loadavg'
       //notifyBuild(currentBuild.result)
        }
    //  } catch (e) {
      // If there was an exception thrown, the build failed
    //  currentBuild.result = "FAILED"
     // throw e
    //} finally {
      // Success or failure, always send notifications
     // notifyBuild(currentBuild.result)
    }
  }
}

//node {
//    try {
//        notifyBuild('STARTED')

//        stage('Prepare code') {
//            sh 'python setup.py'
//        }
//
//        stage('Build') {
//            sh 'python build.py'
//        }

//        stage('Testing') {
//            sh 'python test.py'
//        }
        // @todo add checkpoint
//        stage('Deploy') {
//            echo 'python deploy.py'
//        }
//  } catch (e) {
    // If there was an exception thrown, the build failed
//    currentBuild.result = "FAILED"
//    throw e
//  } finally {
    // Success or failure, always send notifications
//    notifyBuild(currentBuild.result)
//  }
//}


def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)

  emailext(
      subject: subject,
      body: details,
      recipientProviders: [[$class: 'DevelopersRecipientProvider']]
    )
}
