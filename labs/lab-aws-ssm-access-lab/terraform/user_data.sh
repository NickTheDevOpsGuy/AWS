#!/bin/bash
# Basic EC2 bootstrap script

# Update packages
apt-get update -y

# Install AWS SSM Agent (already installed on Ubuntu 20.04+)
snap install amazon-ssm-agent --classic
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Optional: Disable root login over SSH
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd