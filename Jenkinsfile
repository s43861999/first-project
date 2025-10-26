pipeline {
    agent any

    environment {
        // Define remote connection variables
        DOCKER_HOST_USER = 'ec2-user' // e.g., 'ubuntu' or 'ec2-user'
        DOCKER_HOST_IP = 'ec2-54-147-22-5.compute-1.amazonaws.com'
        DOCKER_APP_DIR = '/opt/' // Remote directory for your app files
        WAR_FILE_NAME = 'devopsnew.war'
    }

    stages {
        stage('Build Application') {
            steps {
                // Ensure Maven is correctly configured in Jenkins Tool Installations
                sh 'mvn clean install'
            }
        }

        stage('Deploy to Docker Host') {
            steps {
                script {
                    // Connect to the remote Docker host using the stored SSH credentials
                    sshagent(['docker']) {

                        // --- 1. Copy necessary files to the remote machine
                        // The `scp` command copies the WAR file and Dockerfile
                        sh "scp target/*.war ${DOCKER_HOST_USER}@${DOCKER_HOST_IP}:${DOCKER_APP_DIR}/"
                        sh "scp Dockerfile ${DOCKER_HOST_USER}@${DOCKER_HOST_IP}:${DOCKER_APP_DIR}/"

                        // --- 2. Execute Docker commands on the remote machine
                        // The `ssh` command runs commands on the remote machine
                        echo 'Stopping and removing old container and image...'
                        sh "ssh -tt ${DOCKER_HOST_USER}@${DOCKER_HOST_IP} 'cd ${DOCKER_APP_DIR} && docker stop tomcat_container || true && docker rm tomcat_container || true && docker rmi tomcat_app_image || true'"

                        echo 'Building new Docker image...'
                        sh "ssh -tt ${DOCKER_HOST_USER}@${DOCKER_HOST_IP} 'cd ${DOCKER_APP_DIR} && docker build -t tomcat_app_image .'"

                        echo 'Running new container...'
                        sh "ssh -tt ${DOCKER_HOST_USER}@${DOCKER_HOST_IP} 'docker run -d --name tomcat_container -p 8080:8080 tomcat_app_image'"
                    }
                }
            }
        }
    }
}
