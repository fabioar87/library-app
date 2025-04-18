node('master'){

    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN')
    }

    stage('Checkout'){
        checkout scm
    }

    stage('Quality analysis') {
        withSonarQubeEnv('sonarqube') {
            sh '/opt/maven/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=library-app'
        }
    }

    stage('Unit tests') {
        sh '/opt/maven/bin/mvn test'
    }

    stage('Security check') {
        sh '/opt/maven/bin/mvn org.owasp:dependency-check-maven:check'
    }

    stage('Build') {
        sh '/opt/maven/bin/mvn clean install'
    }
}