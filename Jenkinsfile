pipeline {
  environment {
    registry = "35.239.167.113.sslip.io/test1/test-repro"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/Isidrojhg/prisma-scan-repro.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":v1"
        }
      }
    }
    stage('Scan') {
            steps {
                // Scan the image | Input value from first script copied below, ''
                prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock', ignoreImageBuildTime: true, image: '35.239.167.113.sslip.io/test1/test-repro*', key: '', logLevel: 'info', podmanPath: '', project: '', resultsFile: 'prisma-cloud-scan-results.json'
            }
        }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
  post {
      always {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
      }
  }
}
