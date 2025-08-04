#!/bin/bash

# Update and install dependencies
apt-get update -y
apt-get install -y nodejs npm git curl

# Disable root SSH login
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Add devops user
useradd -m -s /bin/bash devops
usermod -aG sudo devops
mkdir -p /home/devops/.ssh
cp /home/ubuntu/.ssh/authorized_keys /home/devops/.ssh/
chown -R devops:devops /home/devops/.ssh

# Clone app
git clone https://github.com/heroku/node-js-sample.git /opt/node-app
cd /opt/node-app
npm install

# Install pm2 globally
npm install -g pm2

# Start app with correct port and save process
PORT=5000 pm2 start index.js --name node-app
pm2 save
pm2 startup systemd -u ubuntu --hp /home/ubuntu

# Optional: fallback start (for debugging only)
nohup npm start &

# Install CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb

# CloudWatch config
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