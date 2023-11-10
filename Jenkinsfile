pipeline {
  agent {
    kubernetes {
      yaml '''
              apiVersion: v1
              kind: Pod
              spec:
                containers:
                - name: node
                  image: node:18.14.2-alpine3.17
                  volumeMounts:
                    - name: docker-socket
                      mountPath: /var/run/docker.sock
                  env:
                   - name: MONGO_URI
                     value: $MONGO_URI
                  securityContext:
                    privileged: true
                  command:
                  - sleep
                  args:
                  - 99d
                - name: mongo
                  image: mongo:latest
                  ports:
                   - containerPort: 27017
                volumes:
                 - name: docker-socket
                   hostPath:
                     path: /var/run/docker.sock
                tolerations:
                    - key: "tool"
                      operator: "Equal"
                      value: "chess"
                      effect: "NoSchedule"
                affinity:
                  nodeAffinity:
                    requiredDuringSchedulingIgnoredDuringExecution:
                      nodeSelectorTerms:
                      - matchExpressions:
                        - key: kubernetes.io/hostname
                          operator: In
                          values:
                          - tool-chess
              

      '''
    }
  }
  environment {
    Frontend_Image = "omerandori/chess-client:latest"
    Backend_Image = "omerandori/chess-server:latest"
    MONGO_URI="mongodb://127.0.0.1:27017/"
    DOCKER_USERNAME="omerandori"
    DOCKER_PASSWORD="Hanegbiomer2"
  }
  stages {
    stage('pull and test') {
      steps {
       git branch: 'main', url: "https://github.com/Omer-Ori-Devops/chess-ops.git"
        container('node') {
            
          dir('Chess-front-end'){
              sh 'npm install'
              sh 'npm run test'
          }
          dir('Chess-back-end'){
              sh 'npm install'
              sh 'npm run test'
          }
        }
        
      }
    }
    stage('Build and push '){
        steps{
            container('node') {
             sh '''
             apk add --update docker openrc
             docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD
             '''
                dir('Chess-back-end') {
                sh 'docker build -f back-end-alpine.dockerfile -t $Backend_Image .'
                sh 'docker push $Backend_Image'
                sh 'docker rmi -f $(docker images -q)'
                }
                dir('Chess-front-end') {
                sh 'docker build -f front-end-alpine.dockerfile -t $Frontend_Image .'
                sh 'docker push $Frontend_Image'
                sh 'docker rmi -f $(docker images -q)'
                }
            
            }
            }
            
        }
    
    stage('Deploy'){
      agent{
          label 'home'
      }
       steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                 sh '~/kubectl rollout restart deployment deploy-frontend -n kube-tool'
                 sh '~/kubectl rollout restart deployment deploy-backend -n kube-tool'
             }
            } 
    }
    
  }}


