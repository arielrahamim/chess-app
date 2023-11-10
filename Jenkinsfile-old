pipeline {
  agent none
   environment {
    Frontend_Image = "omerandori/chess-client:latest"
    Backend_Image = "omerandori/chess-server:latest"
    MONGO_URI= "mongodb://localhost:27017"
  }
  stages {
    stage('Pull and test') {
      agent { node {label 'test' } }
      steps {
       sh "git init ;git pull git@github.com:Omer-Ori-Devops/chess.git"
       nodejs(nodeJSInstallationName: 'chess') {
           dir('mongo') {
          sh 'sudo docker run -d -p 27017:27017 mongo '
        }
        dir('Chess-front-end') {
          sh 'npm install'
          sh 'npm run test'
        }
        dir('Chess-back-end') {
          sh 'npm install'
          sh 'echo MONGO_URI=$MONGO_URI>.env'
          sh 'npm run test'
        }}
        sh 'pwd'
      }
    }

    stage('build and push ') {
        agent { node {label 'test' } }
      steps {
        dir('Chess-back-end') {
          sh 'sudo docker buildx build -f back-end-alpine.dockerfile -t $Backend_Image .'
          sh 'sudo docker push $Backend_Image'
        }
        dir('Chess-front-end') {
          sh 'sudo docker buildx build -f front-end-alpine.dockerfile -t $Frontend_Image .'
          sh 'sudo docker push $Frontend_Image'
        }
        dir('/jenkins-agent/workspace') {
          sh 'rm -rf *'
          sh 'sudo docker rm -f $(docker ps -aq)'
          sh 'sudo docker rmi -f $(docker images -q)'
        }
      }
    }

    stage('Deploy') {
        agent { node {label 'kube-cp' } }
      steps {
          dir('/home/ubuntu/manifest/deployments') {
          sh 'kubectl rollout restart deployment deploy-frontend '
          sh 'kubectl rollout restart deployment deploy-backend -n=kube-tool'
          sh 'kubectl rollout restart deployment deploy-mongo -n=kube-tool '
        }
      }
    }

  }
}