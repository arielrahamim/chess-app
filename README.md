# Chess App

## Overview
The Chess App is a dynamic web application that allows users to play chess online. Built using JavaScript, it features a split architecture with separate frontend and backend components, along with a MongoDB database. The entire application is containerized using Docker, ensuring a consistent and isolated environment for each component.

## Technologies Used
- **JavaScript:** The core programming language for both frontend and backend.
- **MongoDB:** Our choice for the database, storing game data and user information.
- **Docker:** Utilized for containerizing the frontend, backend, and MongoDB database.
- **Helm:** Employed for installing and managing the application in Kubernetes clusters.
- **Terraform:** Used for provisioning and managing the AWS infrastructure, including VPC and EKS (Elastic Kubernetes Service).

## DevOps Practices
Our project incorporates several key DevOps methodologies and practices:
- **Containerization:** Using Docker to ensure consistency across different environments.
- **Continuous Integration/Continuous Deployment (CI/CD):** Implemented with GitHub Actions. The CI workflow is activated based on the chosen image (frontend, backend, or MongoDB), building the Docker image, uploading it to DockerHub, and tagging it using a '0.0.1-short SHA' logic.
- **Infrastructure as Code (IaC):** Terraform scripts are in place to bootstrap the AWS infrastructure, including setting up VPC and EKS, to ensure a repeatable and automated infrastructure provisioning process.
