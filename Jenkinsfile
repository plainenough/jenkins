pipeline {
  agent any

  environment {
    // You can create environment variables here.
    registryCredential = 'dockerhub'
    jenkinsMaster = ''
    version = "lts"
    linuxSlave = ''
    linuxLatest = ''
  }

  stages {
    stage('Setup'){
      steps {
        sh 'echo "Begin setup"'
        git 'https://github.com/plainenough/jenkins'
        // You can also create those same variables here. 
        env.DOCKER_REPO = "derrickwalton" // This should be changed to your username or private repo
        env.DOCKER_BASE_NAME = "jenkins"
        env.DOCKER_SLAVE_NAME = "jnlp-slave-linux"
        }
      }
    }

    stage('Build') {
      steps {
        sh 'echo "Begin build"'
        // Build job just leverages the master to build the docker containers as defined by the docker files in the repo.
        script {
            masterName = "${env.DOCKER_REPO}/${env.DOCKER_BASE_NAME}:${version}"
            jenkinsMaster = docker.build(masterName, "-f ./Dockerfile.Master --no-cache .")
        }
        script {
            slaveName = "${env.DOCKER_REPO}/${env.SOCKER_SLAVE_NAME}:${version}"
            linuxSlave = docker.build(slaveName, "-f ./Dockerfile.Slave --no-cache .")
        }
      }
    }

    stage('Publish') {
      steps {
        // Simple usage of a store credential to post to dockerhub.
        script {
          docker.withRegistry( '', registryCredential ) {
            jenkinsMaster.push()
            jenkinsMaster.push('latest')
            linuxSlave.push()
            linuxSlave.push('latest')
          }
        }
      }
    }

  post {
    success {
      lastChanges since: 'LAST_SUCCESSFUL_BUILD', format:'SIDE',matching: 'LINE'
    }
  }
}
