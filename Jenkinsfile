pipeline {
    agent any

    environment {
        IMAGE_NAME   = "demo-apps"
        COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                dir('app') {
                    sh 'npm install'
                }
            }
        }

        stage('Unit Tests') {
            steps {
                dir('app') {
                    sh 'npm test'
                }
            }
        }

        stage('Package Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh "docker-compose -f ${COMPOSE_FILE} down || true"
                sh "docker-compose -f ${COMPOSE_FILE} up -d"
            }
        }

        stage('Health Check') {
            steps {
                sh 'chmod +x healthcheck.sh'
                sh './healthcheck.sh'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo '✅ Build → Test → Package → Deploy → Health OK'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
