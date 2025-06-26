pipeline {
    agent any

    stages {
        stage("Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Ishikapbhatt/eks-cluster-pipeline.git'
            }
        }

        stage("Build") {
            steps {
                sh '''
                    terraform init
                    terraform validate
                '''
            }
        }

        stage("Test") {
            steps {
                sh 'terraform plan'
            }
        }

        stage("Deploy") {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}
