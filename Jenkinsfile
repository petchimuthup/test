pipeline {
    agent any

    environment {
        // Jenkins environment variables
        ANSIBLE_HOST_KEY_CHECKING = 'False'
        KUBE_CONFIG = credentials('kubeconfig')  // kubeconfig file stored as a Jenkins credential
        ANSIBLE_INVENTORY = '/var/lib/jenkins/workspace/ansible-kube/k8s_inventory.ini'  // Ansible inventory for targeting Kubernetes pods
        // WORKSPACE = '/home/jenkins/workspace/ansible-kube'
    }

    stages {
        
        stage('Run Ansible Playbook on Kubernetes Pods') {
            steps {
                script {
                    // Ensure kubeconfig is available for Ansible to interact with Kubernetes
                    // writeFile file: 'kubeconfig', text: KUBE_CONFIG
                    
                    // Define the Ansible command to install packages inside Kubernetes pods
                    sh '''
                    ansible-playbook -i ${ANSIBLE_INVENTORY} install_packages.yml \
                    --extra-vars "kubeconfig_path=${WORKSPACE}/kubeconfig"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Ansible playbook executed successfully!"
        }
        failure {
            echo "Ansible playbook execution failed."
        }
    }
}
