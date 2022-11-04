pipeline {
    agent any
    stages {
        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply'){
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        stage('terraform output'){
            steps {
                sh 'sh file.sh ubuntu /home/ubuntu/kubernetes.pem'
            }
        }
        stage('Copy data'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/kubernetes.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "rm -rf Invnetory kubernetes.pem"
                scp -i "/var/lib/jenkins/kubernetes.pem" -o StrictHostKeyChecking=no -r /var/lib/jenkins/workspace/Tool-infra/Invnetory ubuntu@$IP:~
                scp -i "/var/lib/jenkins/kubernetes.pem" -o StrictHostKeyChecking=no -r /var/lib/jenkins/kubernetes.pem ubuntu@$IP:~
                '''
            }
        }
        stage('terraform output'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/kubernetes.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "rm -rf cassandra"
                ssh -i "/var/lib/jenkins/kubernetes.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "git clone https://github.com/aakash894/cassandra.git"
                '''
            }
        }
        stage('Cluster setup'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/kubernetes.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "ansible-playbook -i Invnetory ~/cassandra/Cassandra_review/test/cassandra.yml"
                '''
            }
        }
    }    
}
