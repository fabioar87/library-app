node('master'){

    environment {
        LIBRARY_APP_TOKEN = credentials('LIBRARY_APP_TOKEN')
    }

    stage('Checkout'){
        checkout scm
    }

    stage('Quality analysis') {
        withSonarQubeEnv('sonarqube') {
            sh '''
                /opt/maven/bin/mvn clean verify sonar:sonar \
                 -Dsonar.projectKey=library-app \
                 -Dsonar.host.url=http://sonar-lb-447063675.us-east-1.elb.amazonaws.com \
                 -Dsonar.login=$LIBRARY_APP_TOKEN
                '''
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