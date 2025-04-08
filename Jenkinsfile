pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/SamanthReddy-123/UMA_APP.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Node.js dependencies
                    sh 'npm install'

                    // Ensure Android Gradle Wrapper is executable
                    sh 'chmod +x android/gradlew'
                }
            }
        }

        stage('Build APK') {
            steps {
                script {
                    // Build the APK in release mode
                    dir('android') {
                        sh './gradlew assembleRelease'
                    }
                }
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'android/app/build/outputs/apk/release/app-release.apk', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed. Check logs for details.'
        }
    }
}
