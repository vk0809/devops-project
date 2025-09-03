Blue-Green Deployment Project 🚀
This project demonstrates a Blue-Green Deployment strategy using Jenkins, GitHub, Docker, NGINX, and AWS for zero-downtime application releases.
🔹 What is Blue-Green Deployment?
Blue-Green Deployment is a technique that reduces downtime and risk by running two identical production environments (Blue & Green). At any time, only one environment is live. Updates are deployed to the inactive environment and then traffic is switched seamlessly.
🔹 Project Workflow
	1. Code is managed in Git/GitHub.
	2. Jenkins Pipeline automates the build, test, and deployment process.
	3. Application runs on two environments:
		○ Blue → Port 3000
		○ Green → Port 3001
	4. NGINX Load Balancer manages traffic routing between Blue and Green.
	5. Deployments are made on AWS EC2 instances.
	6. Containerization with Docker ensures consistency across environments.
	7. Terraform can be used for infrastructure provisioning.
🔹 Features
	• Zero downtime deployments
	• Easy rollback strategy
	• CI/CD with Jenkins pipelines
	• Load balancing with NGINX
	• Fully automated infrastructure setup
🔹 Repository Structure

.
├── Jenkinsfile           # CI/CD pipeline definition
├── Dockerfile            # Docker image build instructions
├── nginx.conf            # Load balancer configuration
├── scripts/              # Helper shell scripts
└── docs/                 # Project documentation

🔹 Prerequisites
	• Git & GitHub account
	• Jenkins installed & configured
	• Docker & DockerHub account
	• AWS EC2 instance with security groups configured
	• NGINX installed
	• Terraform (optional, for infra automation)
🔹 How to Run
	1. Fork this repo → Blue-Green Deployment Repo
	2. Clone your fork:

git clone https://github.com/<your-username>/devops-project.git

	3. Build & run using Jenkins pipeline.
	4. Access the app via:
		○ http://<EC2-IP>:3000 → Blue
		○ http://<EC2-IP>:3001 → Green
🔹 Screenshots / Demo
(Add screenshots of Jenkins pipeline stages, NGINX switching, etc.)
🔹 Author
👤 Jahnavi Yadav
	• LinkedIn: www.linkedin.com/in/jahnavi-golla987
	• Feel free to reach out if you get stuck!

<img width="792" height="1403" alt="image" src="https://github.com/user-attachments/assets/1ef51ea3-aea0-49f4-8a75-1a64df041bf8" />
