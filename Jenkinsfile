pipeline {
    agent none
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
        KUBE_CONFIG = credentials('aws-kubeconfig') 
        ANSIBLE_INVENTORY = '/home/jenkins/workspace/ansible-kube/k8s_inventory.ini' 
        DOCKERHUB_CREDENTIALS = credentials('dockhub_id')
        }
    stages {
        stage('Github Connect') {
            agent {label 'jendock'}
            steps {
                sh git([url: 'https://github.com/petchimuthup/test.git', branch: 'master'])
            }
        }
        stage('Build Docker Image') {
            agent {
                label 'jendock'
            }
            steps {
                sh 'docker build -t 826316/ansubuntu .'
            }
        }
        stage('Docker hub login'){
            agent {
                label 'jendock'
            }
            steps {
               sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                
                    }
            }
        }
        stage('push image to dockerhub'){
            agent {
                label 'jendock'
            }
            steps {
                sh 'docker push 826316/ansubuntu'
            }
        }
                                                      
        stage('Run Ansible Playbook on Kubernetes Pods') {
            agent {
                label 'kube'
            }
            steps {
                script {
                    // Ensure kubeconfig is available for Ansible to interact with Kubernetes
                    // writeFile file: 'kubeconfig', text: KUBE_CONFIG
                    
                    // Define the Ansible command to install packages inside Kubernetes pods
                    sh '''
                    ansible-playbook -i ${ANSIBLE_INVENTORY} install_packages.yml \
                    --extra-vars "kubeconfig_path=${WORKSPACE}/aws-kubeconfig"
                    '''
                }
            }
        }
    }
