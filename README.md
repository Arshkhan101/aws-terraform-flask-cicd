# Cloud Engineer Hands-On Project: AWS Terraform Flask CI/CD Pipeline

## 🚀 Project Overview & Architecture
This project implements a 100% Free Tier safe, production-style cloud deployment pipeline. The core objective is to achieve **zero-touch continuous deployment (CD)**—meaning whenever code is pushed to the repository, it automatically builds, tests, packages, and deploys itself to a cloud server without any manual intervention, utilizing Infrastructure as Code (IaC).

---

## 🛠️ Tech Stack & Components
* **Cloud Infrastructure & IaC:** AWS Free Tier (`t3.micro` EC2 instance, VPC, Security Groups) managed via **Terraform**
* **Application Framework:** Python Flask (Lightweight web server)
* **Containerization:** Docker & Docker Hub (For environment consistency)
* **CI/CD Automation:** GitHub Actions (Automated build and deploy pipelines)
* **Cost Assurance:** 100% Free Tier compliant (Zero billing risk)

---

## 🔄 End-to-End Architecture Flow
1. **Infrastructure Provisioning (Terraform):** AWS resources (VPC, Subnet, Security Groups, and EC2 instance) are provisioned cleanly using HashiCorp Terraform.
2. **Developer Push:** Code changes (Python app or configuration) are committed and pushed to the `main` branch of the GitHub repository.
3. **CI/CD Pipeline Trigger (GitHub Actions):** 
   * Checks out the code.
   * Logs into Docker Hub securely using encrypted repository secrets.
   * Builds an optimized Docker image from the custom `Dockerfile`.
   * Pushes the final Docker image to Docker Hub (`latest` tag).
4. **Automated Server Deployment:** 
   * GitHub Actions securely connects to the AWS EC2 instance via SSH.
   * Pulls the latest Docker image from Docker Hub.
   * Gracefully stops any older running container and launches the new container mapped to port 80.
5. **Live Access:** Users can visit the EC2 Public IP address in their browser to view the live, containerized web application.

---

## 📂 Project Directory Structure
```text
aws-terraform-flask-cicd/
│
├── .github/
│   └── workflows/
│       └── deploy.yml          # Automated CI/CD pipeline configuration
├── terraform/                  
│   ├── index.html              # HTML Template file
|
├── terraform/                  # Infrastructure as Code (IaC) files
│   ├── main.tf                 # AWS Provider & EC2/VPC resources         
│          
├── app.py                      # Main Python Flask web application
├── Dockerfile                  # Instructions to containerize the Flask app
├── requirements.txt            # Python dependency packages
└── README.md                   # Project documentation