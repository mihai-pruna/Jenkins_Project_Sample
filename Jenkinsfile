pipeline {
   // agent any
   agent  { label 'jenkins_node' }

   environment {
       // Please update your own registry here
       REGISTRY = 'registry.hub.docker.com'
       REGISTRY_IMAGE = "$REGISTRY/mpruna/webapp"
       DOCKERFILE_PATH = 'Dockerfile'
       // docker = '/usr/local/bin/docker'

       REGISTRY_USER = credentials('registryUser')
       REGISTRY_PASSWORD = credentials('registryPassword')

       CURRENT_BUILD_NUMBER = "${currentBuild.number}"
       GIT_COMMIT_SHORT = sh(returnStdout: true, script: "git rev-parse --short ${GIT_COMMIT}").trim()
   }

   stages {
       stage('Build') {
           steps {
               sh 'sudo docker build -t $REGISTRY_IMAGE:$GIT_COMMIT_SHORT-jenkins-$CURRENT_BUILD_NUMBER -f $DOCKERFILE_PATH .'
           }
       }
       stage('Push') {
           steps {
               sh 'sudo docker login -u $REGISTRY_USER -p $REGISTRY_PASSWORD $REGISTRY'
               sh 'sudo docker push $REGISTRY_IMAGE:$GIT_COMMIT_SHORT-jenkins-$CURRENT_BUILD_NUMBER'
           }
       }
   }
}
