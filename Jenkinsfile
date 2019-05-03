pipeline {
  agent {
    label 'jenkins-slave'
  }
  environment {
    registryCredential = 'dockerhub'
    jenkinsMaster = ''
    version = "2.164.2-$BUILD_NUMBER"
    linuxSlave = ''
    linuxLatest = ''
    windowsSlave = ''
  }
  stages {
    stage('Setup'){
      steps {
        sh 'echo "Begin setup"'
        notifyBuild('STARTED')
        sh 'echo "CONTAINER VERSION: $(cat /slaveversion)"'
        git 'https://github.com/plainenough/test-pipelines'
        withCredentials([
          file(credentialsId: 'minikube', variable: 'kubeconfig'),
          file(credentialsId: 'minikube-client-key', variable: 'clientkey'),
          file(credentialsId: 'minikube-client-cert', variable: 'clientcert'),
          file(credentialsId: 'minikube-ca-cert', variable: 'cacert')
        ]) {
          sh 'cp $kubeconfig ./kubeconfig'
          sh 'cp $clientkey ./client.key && chmod 600 ./client.key'
          sh 'cp $clientcert ./client.crt'
          sh 'cp $cacert ./ca.crt'
        }
      }
    }
    stage('Build') {
      steps {
        sh 'echo "Begin build"'
        script {
            masterName = String.format("derrickwalton/jenkins:%s", version)
            jenkinsMaster = docker.build(masterName, "-f ./container/linux/Dockerfile.Master --no-cache .")
        }
        sh "echo \"${version}\" > ./slaveversion"
        script {
            slaveName = String.format("derrickwalton/jnlp-slave-linux:%s", version)
            linuxSlave = docker.build(slaveName, "-f ./container/linux/Dockerfile.Slave --no-cache .")
            slaveLatest  = String.format("derrickwalton/jnlp-slave-linux:latest")
            linuxLatest = docker.build(slaveLatest, "-f ./container/linux/Dockerfile.Slave .")
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
      notifyBuild(currentBuild.result)
    }
    success {
      //result = 'SUCCESS'
      sh "kubectl --kubeconfig ./kubeconfig get pods"
      lastChanges since: 'LAST_SUCCESSFUL_BUILD', format:'SIDE',matching: 'LINE'
      notifyBuild('NOTIFY')
      notifyBuild(currentBuild.result)
      script {
        docker.withRegistry( '', registryCredential ) {
          jenkinsMaster.push()
          linuxSlave.push()
          linuxLatest.push()
        }
      }
      sh "kubectl --kubeconfig ./kubeconfig set image deployment/jenkins -n jenkins-ns jenkins=derrickwalton/jenkins:\"${version}\""
    }
  }
}

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESS'
  
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
  } else if (buildStatus == 'SUCCESS') {
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

