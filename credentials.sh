#!/bin/bash
echo '''
apiVersion: v1
kind: Secret
metadata:
  name: "jenkins-kub"
  namespace: jenkins
  labels:
    "jenkins.io/credentials-type": "secretText"
    "jenkins.io/credentials-scope": "global"
  annotations:
    "jenkins.io/credentials-description" : "chess"
type: Opaque
stringData:
  text:
'''> /home/ec2-user/credentials-format.yaml

echo '''
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: jenkins-deploy-role
rules:
- apiGroups:
  - "apps"
  resources:
  - "deployments"
  verbs:
  - "*"
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins-deploy-sa

---
apiVersion: v1
kind: Secret
metadata:
  name: secret-token-jenkins-secret

  annotations:
    kubernetes.io/service-account.name: jenkins-deploy-sa 
type: kubernetes.io/service-account-token
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: rolebinding-jenkins-deploy

roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: jenkins-deploy-role
subjects:
- kind: ServiceAccount
  name: jenkins-deploy-sa
''' > /home/ec2-user/jenkins-deploy.yaml

echo '''
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: jenkins-master
  namespace: jenkins
rules:
- apiGroups:
  - "*"
  resources:
  - "*"
  verbs:
  - "*"
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins
  namespace: jenkins
---
apiVersion: v1
kind: Secret
metadata:
  name: secret-token-jenkins
  namespace: jenkins
  annotations:
    kubernetes.io/service-account.name: jenkins 
type: kubernetes.io/service-account-token
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: rolebinding-jenkins
  namespace: jenkins
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: jenkins-master
subjects:
- kind: ServiceAccount
  name: jenkins
  namespace: jenkins
''' > /home/ec2-user/jenkins-service-account.yaml




kubectl apply -f /home/ec2-user/jenkins-service-account.yaml
kubectl apply -f /home/ec2-user/jenkins-deploy.yaml
sleep 5

TOKEN=$(kubectl get secret secret-token-jenkins -n jenkins -o jsonpath='{.data.token}'| base64 -d )

# Read the YAML file
yaml=$(cat /home/ec2-user/credentials-format.yaml)

# Append the token value to the 'text' field
updated_yaml=$(echo "$yaml" | awk -v token="$TOKEN" '/^  text:/ {sub(/$/, " " token)} 1')

# Overwrite the YAML file with the updated content
echo "$updated_yaml" > "credentials-format.yaml"
kubectl apply -f credentials-format.yaml
rm /home/ec2-user/jenkins-deploy.yaml
rm /home/ec2-user/jenkins-service-account.yaml
