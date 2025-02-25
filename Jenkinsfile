pipeline {
  environment {
    registry = "35.239.167.113.sslip.io/test1/test-repro"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    // stage('Cloning Git') {
    //   steps {
    //     git ([url: 'https://github.com/Isidrojhg/prisma-scan-repro.git', branch: 'master])
    //   }
    // }
    stage('Building image') {
      steps{
        sh "docker pull public.ecr.aws/spotinst/spotinst-kubernetes-controller:support-skip-tls-validation"
      }
    }
    stage('Scan') {
            steps {
                sh "docker images" 
                // Scan the image | Input value from first script copied below, ''
                prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock', ignoreImageBuildTime: true, image: 'public.ecr.aws/spotinst/spotinst-kubernetes-controller:support-skip-tls-validation', key: '', logLevel: 'debug', podmanPath: '', project: '', resultsFile: 'prisma-cloud-scan-results.json'
            }
        }
    // stage('Deploy Image') {
    //   steps{
    //     script {
    //       docker.withRegistry( '', registryCredential ) {
    //         dockerImage.push()
    //       }
    //     }
    //   }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi public.ecr.aws/spotinst/spotinst-kubernetes-controller:support-skip-tls-validation"
      }
    }
  }
  post {
      always {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
      }
  }
}

