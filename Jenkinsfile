pipeline{
    agent any
    environment{
        PREFIX= 'terraform/'
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
                    sh 'cd terraforn-cicd'
                    sh 'terraform -chdir=$PREFIX init'
                    sh 'terraform -chdir=$PREFIX apply -auto-approve'
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
