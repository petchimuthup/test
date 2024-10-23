pipeline {
  agent { label 'jendock' }
    environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhublogin')
  }
  stages {
	stage('Git repo') {
	  steps {
	   git([url: 'https://github.com/petchimuthup/test.git', branch: 'master'])
	  }
	}
    stage('Build') {
      steps {
        sh 'docker build -t 826316/ubuntu:latest .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push 826316/ubuntu:latest'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
