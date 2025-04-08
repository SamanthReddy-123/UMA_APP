pipeline {
    agent any
    tools {
        nodejs 'NodeJS_18' // Ensure this is configured in Jenkins global tools
    }
    environment {
        PATH = "${tool 'NodeJS_18'}/bin:${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SamanthReddy-123/UMA_APP.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Verify Android Directory') {
            steps {
                sh 'pwd'
                sh 'ls -la android' // Check if gradlew exists
            }
        }
        stage('Build APK') {
            steps {
                script {
                    if (fileExists('android/gradlew')) {
                        sh 'chmod +x android/gradlew'
                        sh './android/gradlew assembleRelease'
                    } else {
                        error "gradlew not found in android directory!"
                    }
                }
            }
        }
        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'android/app/build/outputs/apk/release/app-release.apk', allowEmptyArchive: true
            }
        }
    }
    post {
        failure {
            echo 'Build failed. Check logs for details.'
        }
    }
}
