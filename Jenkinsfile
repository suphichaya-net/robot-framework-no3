pipeline {
    agent any

    stages {
        stage('Checkout Code From Git') {
            steps {
                echo '📦 Checkout code from Git'
                git branch: 'main', url: 'https://github.com/suphichaya-net/robot-framework-no3.git'
            }
        }

        stage('Install Robot Dependencies') {
            steps {
                echo '🐍 Setting up Python & Robot Framework...'
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                echo '🤖 Running Robot Framework tests...'
                sh '''
                    . .venv/bin/activate
                    mkdir -p testsuite/results
                    robot --outputdir testsuite/results testsuite/
                '''
            }
        }

        stage('Publish Robot Reports') {
            steps {
                echo '📊 Publishing Robot Framework report...'
                archiveArtifacts artifacts: 'testsuite/results/**', allowEmptyArchive: true

                // ถ้าคุณติดตั้งปลั๊กอิน Robot Framework Plugin ใน Jenkins แล้ว
                robot outputPath: 'testsuite/results'
            }
        }
    }

    post {
        always {
            echo "✅ Pipeline finished (clean workspace)"
            cleanWs()
        }
    }
}
