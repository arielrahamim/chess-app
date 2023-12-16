Chess App
Overview
The Chess App is a dynamic web application that allows users to play chess online. It is built using JavaScript and features a split architecture with separate frontend and backend components, along with a MongoDB database. The entire application is containerized using Docker, ensuring a consistent and isolated environment for each component.

Technologies Used
JavaScript: Core programming language for both frontend and backend.
MongoDB: Database for storing game data and user information.
Docker: Used for containerizing the frontend, backend, and MongoDB database.
Helm: Utilized for installing and managing the application in Kubernetes clusters.
Terraform: Employed for provisioning and managing the AWS infrastructure, including VPC and EKS (Elastic Kubernetes Service).
DevOps Practices
This project incorporates several DevOps methodologies and practices:

Containerization: Docker is used to containerize each component of the application, ensuring consistency across different environments.
Continuous Integration/Continuous Deployment (CI/CD): Implemented using GitHub Actions. The CI workflow is triggered based on the image chosen (frontend, backend, or MongoDB). It builds the Docker image, uploads it to DockerHub, and tags it using a '0.0.1-short SHA' logic.
Infrastructure as Code (IaC): Terraform scripts are used to bootstrap the AWS infrastructure, including the setup of VPC and EKS, ensuring a repeatable and automated process for infrastructure provisioning.
The application can be installed and set up using Helm charts.
