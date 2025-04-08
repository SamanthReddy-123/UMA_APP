pipeline {
    agent any

    environment {
        NODE_VERSION = '16' // Update Node version here
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Node Version') {
            steps {
                sh 'nvm install $NODE_VERSION'
                sh 'nvm use $NODE_VERSION'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build APK') {
            steps {
                sh 'chmod +x android/gradlew'
                sh './android/gradlew assembleRelease'
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'android/app/build/outputs/apk/release/*.apk', allowEmptyArchive: true
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
