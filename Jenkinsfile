node('master'){
    stage('Checkout'){
        checkout scm
    }

    stage('Build') {
        sh 'mvn clean install'
    }

    stage('Static Code Analysis') {
        withSonarQubeEnv('sonarqube') {
            sh 'mvn sonar:sonar'
        }
    }

    stage('Static Code Analysis'){
        withSonarQubeEnv('sonarqube') {
            sh 'sonar-scanner -Dsonar.projectVersion=$BUILD_NUMBER -X '
        }
    }
}