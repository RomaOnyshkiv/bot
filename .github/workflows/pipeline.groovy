pipeline {
    agent {
        label 'github'
    }
    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Pick OS')
        choice(name: 'arch', choices: ['arm46', 'amd64'], description: 'Select arch')

    }
    stages {

        stage('test') {
            steps {
                script {
                    sh 'make test'
                }
            }
        }


        stage('create image') {
            steps {
                script {
                    sh 'make image'
                }

            }
        }

        
    }
}