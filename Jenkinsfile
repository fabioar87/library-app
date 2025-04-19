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

    stage('Build artifact') {
        sh '/opt/maven/bin/mvn clean install'

    }

    stage('Build and push image') {
        def commitHash = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        def tag = "${commitHash}-${env.BUILD_NUMBER}"
        def image_name = 'fabiomatcomp/library-service'

        withCredentials([usernamePassword(credentialsId: 'docker-hub',
            usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
            sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
            sh "docker build -t ${image_name}:${tag} ."
            sh "docker push ${image_name}:${tag}"
            sh "docker tag ${image_name}:${tag} ${image_name}:latest"
            sh "docker push ${image_name}:latest"
        }
    }

    stage("Deployment") {
        ansiblePlaybook credentialsId: 'library-server',
                        installation: 'Ansible',
                        inventory: 'ansible/inventory/hosts',
                        playbook: 'ansible/playbook.yaml'
    }
}