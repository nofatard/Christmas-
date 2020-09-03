pipeline {
  agent any
  triggers {
  pollSCM '* * * * *'
}

  tools {
     maven 'M2_HOME'
  }
  environment {
    registry = "nofatard/christ"
    registryCredential = 'dockerID'
  }
  stages {
    stage('Build'){
      steps {
       sh 'mvn clean'
       sh 'mvn install'
       sh 'mvn package'
      }
    }
    stage('test'){
      steps {
       echo "test step"
       sh 'mvn test'
      }
    }
    stage ('build and publish image') {
      steps {
        script {
          checkout scm
          docker.withRegistry('', 'DockerID') {
          def customImage = docker.build("nofatard/christ:${env.BUILD_ID}")
          def customImage1 = docker.build("nofatard/christ")
          customImage.push()
          customImage1.push()

          }
    }
}
    }
    stage('deploy'){
        steps {
          sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible-host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /etc/ansible/kube.yml ;', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
     
      }
    }
  }
}
 