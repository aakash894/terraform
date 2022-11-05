pipeline {
    agent any
    parameters {
        choice choices: ['us-west-2a', 'us-west-2b', 'us-west-2c', 'us-west-2d'], description: 'Select the availability zone in which you want to create your subnet', name: 'AZ1'
        choice choices: ['us-west-2a', 'us-west-2b', 'us-west-2c', 'us-west-2d'], description: 'Select the availability zone for higher availibity of your resources', name: 'AZ2'
        string defaultValue: 'ami-017fecd1353bcc96e', description: 'Input amazon image id', name: 'AMI'
        string defaultValue: 't2.medium', description: 'Input instance type', name: 'instance_type'
        string defaultValue: 'oregon', description: 'Input key pair name which you want to provide to your machine & ensure it will be pre-generated', name: 'key_name'
        string defaultValue: '3', description: 'Input node count for your database cluster', name: 'node_count'
        choice choices: ['4.0.7', '3.11.14', '3.0.28'], description: 'Select your cassandra database version', name: 'version'
    }
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
                sh 'terraform apply --auto-approve -var="AZ1=${AZ1}" -var="AZ2=${AZ2}" -var="ami=${AMI}" -var="instance_type=${instance_type}" -var="key_name=${key_name}" -var="node_count=${node_count}"'
            }
        }
        stage('terraform output'){
            steps {
                sh'''
                chmod +x file.sh
                ./file.sh ubuntu /home/ubuntu/oregon.pem
                '''
            }
        }
        stage('Copy data'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "rm -rf Invnetory oregon.pem"
                scp -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -r Invnetory ubuntu@$IP:~
                scp -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -r /var/lib/jenkins/oregon.pem ubuntu@$IP:~
                '''
            }
        }
        stage('Configure ansible'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "sudo apt update -y && sudo apt-add-repository ppa:ansible/ansible -y && sudo apt install ansible -y"
                '''
            }
        }
        stage('Git clone'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "rm -rf cassandra"
                ssh -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "git clone https://github.com/aakash894/cassandra.git"
                '''
            }
        }
        stage('Cluster setup'){
            steps {
                sh'''
                IP=$(terraform output -json Intance_public_ip | jq -r)
                echo $IP
                ssh -i "/var/lib/jenkins/oregon.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "ansible-playbook -e version=${version} -i Invnetory ~/cassandra/Cassandra_review/test/cassandra.yml"
                '''
            }
        }
    }    
}
