pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Gollajahnavi78-gj/devops-project.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building project..."
                sh 'ls -ltr'
                sh 'cat README.md'
            }
        }
    }
}
