pipeline {
  agent any
  environment {
    REPO_URL = 'https://github.com/Gollajahnavi78-gj/devops-project.git'
    IMAGE    = "demo-app"
    TAG      = "build-${env.BUILD_NUMBER}"
  }
  stages {
    stage('Checkout') { steps { git branch: 'main', url: "${env.REPO_URL}" } }
    stage('Build Docker Image') { steps { sh 'docker build -t ${IMAGE}:${TAG} ./app' } }
    stage('Smoke Test') {
      steps {
        sh '''
          CID=$(docker run -d -p 3999:3000 ${IMAGE}:${TAG})
          sleep 3 && curl -fsS http://127.0.0.1:3999 >/dev/null
          docker rm -f "$CID"
        '''
      }
    }
    stage('Blue-Green Deploy') {
      steps {
        sh '''
          chmod +x scripts/deploy.sh scripts/rollback.sh || true
          sudo scripts/deploy.sh ${IMAGE}:${TAG}
        '''
      }
    }
  }
  post {
    failure {
      sh 'sudo scripts/rollback.sh || true'
    }
  }
}
