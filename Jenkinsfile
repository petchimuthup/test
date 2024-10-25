
  node(label: 'jendock') {
  environment {
    // DOCKERHUB_CREDENTIALS = credentials('dockerhublogin')
    ANSIBLE_HOST_KEY_CHECKING = 'False'
    KUBE_CONFIG = credentials('aws-kubeconfig')
    ANSIBLE_INVENTORY = '/home/jenkins/workspace/gitdocker/k8inventory.ini'
  }
    stage('connect git repo') {
        git([url: 'https://github.com/petchimuthup/test.git', branch: 'master'])
             }
    stage('build docker image') {
        sh 'docker build -t 826316/ansubuntu .'
      }
    stage('dockerhub login') {
        script {
        withDockerRegistry(credentialsId: 'dockerhublogin', toolName: 'docker') {
         sh 'docker push 826316/ansubuntu' 
        }
        }
    }
    
  }
