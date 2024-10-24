pipeline {
  agent none
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhublogin')
    ANSIBLE_HOST_KEY_CHECKING = 'False'
    KUBE_CONFIG = credentials('aws-kubeconfig')
    ANSIBLE_INVENTORY = '/home/jenkins/workspace/anskubedock/k8inventory.ini'
  }
  stages {
    stage('connect git repo') {
    agent {
        label'jendock'
      }
      steps {
        git([url: 'https://github.com/petchimuthup/test.git', branch: 'master'])
             }
    }
    stage('build docker image') {
      agent {
        label'jendock'
      }
      steps {
        sh 'docker build -t 826316/ansubuntu .'
      }
    }
    stage('dockerhub login') {
      agent {
        label 'jendock'
      }
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('push image to dockerhub') {
      agent {
        label 'jendock'
      }
      steps {
        sh 'docker push -u 826316/ansubuntu .'
      }
    }
    stage('kubernets deploy') {
      agent { 
        label 'kube'}
      steps {
        sh 'kubectl create -f deploy01.yml'
      }
    }
    
    
        
        
      
          
             
