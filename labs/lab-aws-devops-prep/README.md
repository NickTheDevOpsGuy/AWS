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
└── lab-aws-devops-prep
    ├── .github
    │   └── workflows
    │       └── deploy.yml
    ├── .gitignore
    ├── README.md
    ├── terraform
    │   └── modules
    │       ├── cloudwatch.tf
    │       ├── ec2.tf
    │       ├── iam.tf
    │       ├── keypair.tf
    │       ├── outputs.tf
    │       ├── providers.tf
    │       ├── security_groups.tf
    │       ├── user_data.sh
    │       ├── variables.tf
    │       └── vpc.tf
```

## 🔧 Tools Used
•	Terraform CLI
•	AWS EC2, VPC, IAM
•	CloudWatch Dashboards
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
