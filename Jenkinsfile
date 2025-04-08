pipeline {
    agent any

    environment {
        NODE_VERSION = '12'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Node Version') {
            steps {
                sh 'node -v || (echo "Node.js not found. Installing Node.js..." && sudo apt update && sudo apt install -y nodejs npm)'
                sh 'node -v' // Confirm Node.js version
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build APK') {
            steps {
                sh './build.sh' // Adjust this based on your build script
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: '**/*.apk', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed. Check logs.'
        }
    }
}
