pipeline{
    agent any
    environment{
        PREFIX= 'terraform/'
        CLOUDSDK_CORE_PROJECT = 'tech-rnd-project' 
        GCLOUD_CREDS=credentials('gcloud-creds')
        CLIENT_EMAIL='faz-722@tech-rnd-project.iam.gserviceaccount.com'
    }
    tools {
        terraform 'terraform'
    }
    stages{
        stage('Initialize...'){
            steps{
                git branch: 'main', credentialsId: 'gitlab', url: 'https://gitlab.com/eekngen/infras-prov-conf'
            }
        }
        stage('Provisioning infrastucture...'){
            steps{
                script{
                    
                    sh 'terraform init'
                    sh 'terraform  apply -auto-approve'
                }
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
