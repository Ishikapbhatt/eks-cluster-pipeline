pipeline {
    agent any

    environment {
        AWS_REGION = 'us-west-2'
        CLUSTER_NAME = 'my-eks-cluster'
        TF_VERSION = '1.6.2'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Setup Terraform') {
            steps {
                sh '''
                curl -sLo terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
                unzip terraform.zip
                sudo mv terraform /usr/local/bin/
                terraform -version
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Configure Kubectl') {
            steps {
                sh '''
                aws eks update-kubeconfig \
                  --region ${AWS_REGION} \
                  --name ${CLUSTER_NAME}
                kubectl get svc
                '''
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed!"
        }
        success {
            echo "EKS cluster provisioned successfully!"
        }
    }
}
