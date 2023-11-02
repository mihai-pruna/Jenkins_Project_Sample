pipeline {
    environment {
        dockerRepo = "<dockerhub-username>/<repo-name>"
        registryCredential = '<dockerhub-credential-name>'
    }

    agent any

    stages {
        //Getting the source code and a Dockerfile
        stage('Getting Source Code From GitHub') {
            steps {
                checkout([
                 $class: 'GitSCM',
                 branches: [[name: 'master']],
                 userRemoteConfigs: [[
                    url: 'https://github.com/*****.git',
                    credentialsId: 'github-key'
                 ]]
                ])
            }
        }

        //Building image using the Dockerfile in the source code above
        //env.BUILD_ID tags the image with a unique build number
        stage("Building docker image"){
            steps{
                script{
                        dockerImage = docker.build dockerRepo + ":${env.BUILD_ID}"

                }
            }
        }

        //Pushing the image built in the previous step to DockerHub
        stage('Push Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push("latest")
                    dockerImage.push("${env.BUILD_ID}")
                    }   
                }
            }
        }

    }
}
