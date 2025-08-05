#!/bin/bash
# Ensure packages are up-to-date
apt-get update -y
apt-get upgrade -y

# Install the SSM Agent via .deb (recommended over snap for scripts)
curl -o /tmp/ssm-agent.deb https://s3.amazonaws.com/amazon-ssm-us-west-2/latest/debian_amd64/amazon-ssm-agent.deb
dpkg -i /tmp/ssm-agent.deb

# Start and enable the agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Optional hardening: disable root login via SSH
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd