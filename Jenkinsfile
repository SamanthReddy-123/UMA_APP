pipeline {
    agent any

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

        stage('Verify Node Environment') {
            steps {
                sh '''
                    echo "Node.js Version:"
                    node -v
                    echo "npm Version:"
                    npm -v
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    if (fileExists('package-lock.json')) {
                        sh 'npm ci'
                    } else {
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
