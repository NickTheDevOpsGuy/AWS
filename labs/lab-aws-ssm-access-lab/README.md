# Lab: AWS EC2 Access via SSM Session Manager

This lab demonstrates how to securely access an EC2 instance using AWS Systems Manager (SSM) Session Manager, replacing traditional SSH access.

## 🔍 Objectives

- Provision EC2 instance without public IP
- Attach IAM role with necessary SSM permissions
- Enable SSM Agent on the instance via `user_data`
- Access the instance securely through AWS Systems Manager

## 📦 Structure

```
lab-aws-ssm-access-lab/
├── terraform/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── user_data.sh
│   └── modules/
│       ├── ec2/
│       ├── iam/
│       └── vpc/
```

## 🚀 Usage

1. Fill in your `terraform.tfvars` (if used)
2. Run:
```bash
terraform init
terraform apply
```

3. Access the instance via:
```bash
aws ssm start-session --target <instance-id>
```

## 🧼 Cleanup

```bash
terraform destroy
```

## 📚 Resources

- [SSM Session Manager Docs](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html)
- [IAM Policy Reference](https://docs.aws.amazon.com/systems-manager/latest/userguide/security_iam_id-based-policy-examples.html)
