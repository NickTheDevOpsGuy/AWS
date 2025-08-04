# AWS DevOPS Lab

## 📝 Description
A hands-on AWS lab for DevOps infrastructure provisioning with Terraform. This project includes a modular setup for VPC, EC2, IAM, remote state management, and CloudWatch monitoring. Ideal for DevOps engineers looking to upskill in AWS IaC workflows.

## 🚀 Getting Started
1. Clone the repo
2. Configure your AWS credentials:

   ```bash   
   Export AWS_ACCESS_KEY_ID="your-access-key-id"
   Export AWS_SECRET_ACCESS_KEY="your-secret-access-key" ```

4. Initialize and apply the Terraform configuration:
   
   ```bash
   terraform init
   terraform apply```

💡 You must have an existing S3 bucket and DynamoDB table set up for remote state if you’re using backend.tf.

## 📁 Project Structure
```plaintext
.
├── terraform/
│   ├── modules/               # VPC, EC2, IAM, EKS (modularized)
│   ├── main.tf                # Root configuration
│   └── backend.tf             # (optional) Remote state config
├── .github/
│   └── workflows/
│       └── deploy.yml         # GitHub Actions pipeline
├── monitoring/
│   └── cloudwatch-dashboard.json
├── app/                       # Sample app to deploy (static or containerized)
└── README.md
```

## 🔧 Tools Used
•	Terraform CLI
•	AWS EC2, VPC, IAM
•	CloudWatch Dashboards
•	S3 + DynamoDB (Remote State)
•	GitHub Actions (optional)

## 🙋‍♂️ About the Author

Built with 💻 by [Nicholas Clark](https://www.linkedin.com/in/nickdoesdevops)

- Follow the journey: #NickDoesDevOPS

🧠 #NickDoesDevOps
🚀 #LearningInPublic
🔧 #WorldDominations

- GitHub: [NickTheDevOpsGuy](https://github.com/NickTheDevOpsGuy)

## 📄 License
MIT
