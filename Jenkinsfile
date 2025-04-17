node('master'){
    stage('Checkout'){
        checkout scm
    }

    stage('Build') {
        // sh 'mvn clean install'
        sh '/usr/bin/mvn clean install'
    }

//     stage('Static Code Analysis'){
//         withSonarQubeEnv('sonarqube') {
//             sh 'sonar-scanner -Dsonar.projectVersion=$BUILD_NUMBER -X '
//         }
//     }
}