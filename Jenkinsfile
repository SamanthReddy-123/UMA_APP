pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
        AWS_REGION = 'us-east-1'
        S3_BUCKET = 'your-s3-bucket-name' // 🔁 Replace with actual bucket
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

        stage('Create bash.sh') {
            steps {
                script {
                    writeFile file: 'bash.sh', text: '''#!/bin/bash
echo "Hello from Jenkins!"
echo "Current Date and Time: $(date)"
echo "Current User: $(whoami)"
echo "Files in current directory:"
ls -la
'''
                }
                sh 'chmod +x bash.sh'
            }
        }

        stage('Run bash.sh') {
            steps {
                sh './bash.sh'
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

        stage('Upload to S3') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id' // 🔁 Replace with your Jenkins AWS credentials ID
                ]]) {
                    sh '''
                        echo "Uploading APK to S3..."
                        aws s3 cp build/app-debug.apk s3://$S3_BUCKET/ --region $AWS_REGION
                    '''
                }
            }
        }
    }

    post {
        always {
            echo '🔁 Pipeline completed.'
        }
        success {
            echo '✅ Build succeeded!'
        }
        failure {
            echo '❌ Build failed. Check logs.'
        }
    }
}
