pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
        AWS_REGION = 'us-east-1'
        S3_BUCKET = 'uma-apk-artifacts'
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
                script {
                    writeFile file: 'build.sh', text: '''#!/bin/bash
#!/bin/bash
echo "🔧 Cleaning and fetching dependencies..."
flutter clean
flutter pub get

echo "📦 Building release APK..."
flutter build apk --release

echo "✅ APK built at: build/app/outputs/flutter-apk/app-release.apk"
'''
                    sh 'chmod +x build.sh && ./build.sh'
                }
            }
        }

        stage('Upload APK to S3') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds-id']]) {
                    sh '''
                        echo "☁️ Uploading APK to S3..."
                        aws s3 cp build/app/outputs/flutter-apk/app-release.apk s3://$S3_BUCKET/app-release.apk --region $AWS_REGION
                    '''
                }
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', allowEmptyArchive: false
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
