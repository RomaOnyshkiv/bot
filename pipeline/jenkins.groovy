pipeline {
    agent {
        label 'github'
    }
    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Pick OS')
        choice(name: 'arch', choices: ['arm64', 'amd64'], description: 'Select arch')

    }
    stages {

        stage('test') {
            steps {
                script {
                    sh 'make test'
                }
            }
        }

        stage("build") {
            steps {
                echo "BUILD PROJECT"
                sh "make build TARGETOS=${OS} TARGETARCH=${arch}"
            }
        }

        stage('create image') {
            steps {
                script {
                    sh "make image TARGETOS=${OS} TARGETARCH=${arch}"
                }

            }
        }

        stage("push") {
            steps {
                script {
                    docker.withRegistry("", "dockerhub") {
                        sh "make push"
                    }
                }
            }
        }



        
    }
}