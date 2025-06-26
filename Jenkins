pipeline {
    agent any
}

stages {
    stage ("checkout") {
        steps {
            git branch: 'main', url: 'https://github.com/Ishikapbhatt/eks-cluster-pipeline.git'
        }
    }

    stage ("build") {
        steps {
            sh ''''
            terraform init
            terraform validate
            ''''
        }
    }

    stage ("Test") {
        steps {
            sh "terraform plan"
        }
    }

    stage ("Deploy") {
        steps {
            sh "terraform apply --auto-approve"
        }
    }
}
