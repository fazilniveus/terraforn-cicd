pipeline{
    agent any
    environment{
        CLOUDSDK_CORE_PROJECT = 'tech-rnd-project' 
        GCLOUD_CREDS=credentials('gcloud-creds')
        CLIENT_EMAIL='faz-722@tech-rnd-project.iam.gserviceaccount.com'
    }
    tools {
        terraform 'terraform'
    }
    stages{
        stage('checkout'){
            steps{
                script{
                    checkout scm
                }
            }
        }
        stage('Initialize'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Plan'){
            steps{
                sh 'terraform plan'
            }
        }
        stage('Apply'){
            steps{
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Confgiure infrastucture...'){
            steps{
                retry(count: 10){
                    sh 'ansible-playbook -i /opt/ansible/inventory/simple-devops-ci-cd/gcp.yml ./ansible/docker-setup.yaml'
                }
            }
        }
    }
}
