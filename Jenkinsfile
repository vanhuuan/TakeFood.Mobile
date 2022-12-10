/* groovylint-disable LineLength */
void setBuildStatus(String message, String state) {
    step([
      $class: 'GitHubCommitStatusSetter',
      /* groovylint-disable-next-line LineLength */
      reposSource: [$class: 'ManuallyEnteredRepositorySource', url: 'https://github.com/vanhuuan89/TakeFood.Mobile.git'],
      contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: 'ci/jenkins/build-status'],
      errorHandlers: [[$class: 'ChangingBuildStatusErrorHandler', result: 'UNSTABLE']],
      statusResultSource: [ $class: 'ConditionalStatusResultSource', results: [[$class: 'AnyBuildResult', message: message, state: state]] ]
  ])
}

pipeline {
    agent any
    environment {
        NEXUSACCOUNT = 'admin'
        NEXUSPASSWORD = '254a6d6e-9ab2-4548-8ee4-66ec037f8514'
    }

    stages {
        stage('Git Checkout') {
            steps {
                cleanWs()
                setBuildStatus('Pending', 'PENDING')
                git branch: 'main', credentialsId: 'takefoodmobile', url: 'git@github.com:vanhuuan89/TakeFood.Mobile.git'
                sh 'cd TakeFood.Mobile'
            }
        }
        stage('Test') {
            steps {
                sh "echo ${env:BUILD_NUMBER}"
                sh 'cd '
                sh 'flutter test'
            }
        }
        stage('Build APK') {
            steps {
                sh 'flutter build apk'
            }
        }
        stage('Publish to Nexus repository') {
            steps {
                sh 'curl -u admin:254a6d6e-9ab2-4548-8ee4-66ec037f8514 -v --upload-file app-release.apk http://20.205.40.63:8081/repository/maven-releases/TakeFoodMobile/0.0.3/0.0.3/0.0.3-0.0.3.apk'
            }
        }
    }
    post {
        failure {
            setBuildStatus('Build Failed', 'FAILURE')
        }
        success {
            setBuildStatus('Build complete', 'SUCCESS')
        }
    }
}
