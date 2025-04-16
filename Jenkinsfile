node('master'){
    stage('Checkout'){
        checkout scm
    }

    stage('Static Code Analysis'){
        withSonarQubeEnv('sonarqube') {
            sh 'sonar-scanner -Dsonar.projectVersion=$BUILD_NUMBER -X'
        }
    }
}