#!/bin/bash
set -e

# Update system and install required packages
apt-get update -y
apt-get install -y nodejs npm git wget

# Disable root SSH login
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Create devops user with sudo access
useradd -m -s /bin/bash devops
usermod -aG sudo devops
mkdir -p /home/devops/.ssh
cp /home/ubuntu/.ssh/authorized_keys /home/devops/.ssh/
chown -R devops:devops /home/devops/.ssh

# Clone sample Node.js app
git clone https://github.com/heroku/node-js-sample.git /opt/node-app
cd /opt/node-app
npm install

# Use PM2 to run the app
npm install -g pm2
pm2 start index.js
pm2 startup systemd
pm2 save

# Optional: still run it in background with nohup as a fallback
nohup npm start &

# Install CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb

# Write CloudWatch Agent config
cat <<EOC > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "metrics": {
    "namespace": "NickDevOpsLab",
    "append_dimensions": {
      "InstanceId": "\${aws:InstanceId}"
    },
    "metrics_collected": {
      "cpu": {
        "measurement": ["cpu_usage_idle", "cpu_usage_iowait"],
        "metrics_collection_interval": 60
      },
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 60
      }
    }
  }
}
EOC

# Start CloudWatch Agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s