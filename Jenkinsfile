pipeline {
    agent any

    stages {
        stage('Create bash.sh') {
            steps {
                script {
                    writeFile file: 'bash.sh', text: '''#!/bin/bash
echo "Hello from Jenkins!"
echo "Current Date and Time: $(date)"
echo "Current User: $(whoami)"
echo "Files in current directory:"
ls -alh
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

        // ✅ New stage to create dummy build.sh
        stage('Create build.sh') {
            steps {
                script {
                    writeFile file: 'build.sh', text: '''#!/bin/bash
echo "🛠️ Simulating APK build..."

mkdir -p build
echo "This is a dummy APK for testing purposes. Generated at: $(date)" > build/app-debug.apk

echo "✅ Dummy APK created at build/app-debug.apk"
'''
                }
                sh 'chmod +x build.sh'
            }
        }

        stage('Build APK') {
            steps {
                sh './build.sh'
            }
        }

        stage('Upload APK to S3') {
            steps {
                echo "📦 Uploading APK to S3 (simulated)..."
                // Add real AWS CLI command here if needed
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'build/app-debug.apk', fingerprint: true
                echo "📁 APK archived successfully."
            }
        }
    }

    post {
        always {
            echo "🔁 Pipeline completed."
        }
        failure {
            echo "❌ Build failed. Check logs."
        }
    }
}
