pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
        AWS_REGION = 'us-east-1'
        S3_BUCKET = 'uma-apk-artifacts'
        APK_OUTPUT_PATH = 'build/app/outputs/flutter-apk/app-release.apk'
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

        stage('Check Flutter') {
            steps {
                sh '''
                    echo "Checking Flutter installation..."
                    if ! command -v flutter &> /dev/null; then
                        echo "❌ Flutter not found. Please install Flutter on the Jenkins agent."
                        exit 1
                    fi
                    flutter --version
                '''
            }
        }

        stage('Build APK') {
            steps {
                sh '''
                    echo "🔧 Cleaning and building APK..."
                    flutter clean
                    flutter pub get
                    flutter build apk --release
                '''
            }
        }

        stage('Upload APK to S3') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds-id']]) {
                    sh '''
                        echo "☁️ Uploading APK to S3..."
                        if [ -f "$APK_OUTPUT_PATH" ]; then
                            aws s3 cp "$APK_OUTPUT_PATH" "s3://$S3_BUCKET/app-release.apk" --region $AWS_REGION
                            echo "✅ APK uploaded successfully."
                        else
                            echo "❌ APK file not found at: $APK_OUTPUT_PATH"
                            exit 1
                        fi
                    '''
                }
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
