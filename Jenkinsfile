pipeline {
    agent any

    tools {
        nodejs "NodeJS_12" // Make sure this version is defined in Jenkins > Global Tool Configuration
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    retry(2) {
                        sh 'npm install'
                    }
                }
            }
        }

        stage('Build APK') {
            steps {
                sh 'chmod +x build.sh && ./build.sh'
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
