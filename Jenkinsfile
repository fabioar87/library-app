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
                 -Dsonar.login=sqp_b0c8fd96f18f777be9ee3c620c073b29f4c05d1d
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

    stage("Test ansible connectivity") {
        sh 'ansible -i ansible/inventory/hosts ansible/playbook.yaml'
    }
}