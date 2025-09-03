stage('Blue-Green Deploy') {
  steps {
    sh '''
      chmod +x scripts/deploy.sh scripts/rollback.sh || true
      scripts/deploy.sh ${IMAGE}:${TAG}
    '''
  }
}

post {
  failure {
    sh 'scripts/rollback.sh || true'
  }
}
