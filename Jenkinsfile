pipeline {
    agent any  // Use any available agent
    environment {
        PATH ="/opt/apache-tomcat-11.0.9/bin:$PATH"     
    }

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
                sh 'mvn clean install'  // Run Maven build
            }
        }
        stage('connect to server') {
            steps {
              sshagent(['tomcat']) {
                 sh "scp -o StrictHostKeyChecking=no first-project-0.0.1-SNAPSHOT.jar tomcat@ec2-54-82-23-0.compute-1.amazonaws.com:/opt/apache-tomcat-11.0.9/webapps"

                }
       
               }
         }        
         
    }
}