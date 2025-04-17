node('master'){
    stage('Checkout'){
        checkout scm
    }

    stage('Quality analysis') {
        steps {
            withSonarQubeEnv('sonarqube') {
                sh '/opt/maven/bin/mvn clean verify sonar:sonar'
            }
        }
    }

    stage('Unit tests') {
        steps {
            sh '/opt/maven/bin/mvn test'
        }
    }

    stage('Security check') {
        steps {
            sh '/opt/maven/bin/mvn org.owasp:dependency-check-maven:check'
        }
    }

    stage('Build') {
        sh '/opt/maven/bin/mvn clean install'
    }
}