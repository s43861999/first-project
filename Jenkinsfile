pipeline {
    agent any  // Use any available agent

    tools {
        maven 'maven'  // Ensure this matches the name configured in Jenkins
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/s43861999/first-project.git'
            }
        }

        stage('Build') {
            steps {
                
                sh 'mvn clean package'  // Run Maven build
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['root']) {
                scp -o StrictHostkeyChecking=no Firstproject-1.0-SNAPSHOT.jar' root@ec2-54-160-132-51.compute-1.amazonaws.com:/opt/apache-tomcat-11.0.9/webapps
                }
               } 
         }

        stage('Test') {
            steps {
                sh 'mvn test'  // Run unit tests !!
            }
        }
       
        
        
       
        stage('Run Application') {
            steps {
                // Start the JAR application
                sh 'java -jar target/Firstproject-1.0-SNAPSHOT.jar'
            }
        }

        
    }

    post {
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build failed!' !! !
        }
    }
}
