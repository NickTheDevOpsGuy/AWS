# AWS DevOPS Lab

## 📝 Description
Brief description of what this project does and who it's for.

## 🚀 Getting Started
- Clone the repo
- Run `bicep build infra/main.bicep`
- Deploy using Azure CLI or GitHub Actions

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
- Azure Bicep
- Application Insights
- Log Analytics

## 🙋‍♂️ About the Author

Built with 💻 by [Nicholas Clark](https://www.linkedin.com/in/nickdoesdevops)

- Follow the journey: #NickDoesDevOPS

🧠 #NickDoesDevOps
🚀 #LearningInPublic
🔧 #WorldDominations

- GitHub: [NickTheDevOpsGuy](https://github.com/NickTheDevOpsGuy)

## 📄 License
MIT