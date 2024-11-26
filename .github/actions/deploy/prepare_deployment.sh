#!/bin/bash

# Arguments passed from action.yml
EC2_HOST=$1
SSH_KEY=$2
REPO_NAME=$3
SSH_KEY_PATH="$GITHUB_WORKSPACE/key.pem"
DEPLOY_ENV=$4

# Write SSH key to file
echo "$SSH_KEY" > $SSH_KEY_PATH
chmod 600 $SSH_KEY_PATH

# Add EC2 host key to known hosts
mkdir -p ~/.ssh
ssh-keyscan $EC2_HOST >> ~/.ssh/known_hosts

# Retry logic for SSH connection
RETRIES=10
for i in $(seq 1 $RETRIES); do
  echo "Attempt $i: Checking SSH connection..."
  ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" ec2-user@$EC2_HOST 'echo SSH Connection Successful'
  if [ $? -eq 0 ]; then
    echo "SSH connection established."
    break
  else
    echo "SSH connection failed, retrying in 10 seconds..."
    sleep 10
  fi
done

if [ $i -eq $RETRIES ]; then
  echo "Failed to establish SSH connection after $RETRIES attempts."
  exit 1
fi

# Create git archive from the repository root
echo "Creating git archive from the repository root..."
cd $GITHUB_WORKSPACE
git archive --format=tar.gz HEAD > repo.tar.gz
echo "Contents of repo.tar.gz:"
tar -tzf repo.tar.gz

# Copy repository to EC2 instance
echo "Copying repo.tar.gz to EC2 instance..."
scp -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" repo.tar.gz ec2-user@$EC2_HOST:/home/ec2-user/

# Ensure the target directory exists and extract the archive
echo "Extracting repo.tar.gz on EC2 instance..."
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" ec2-user@$EC2_HOST << EOF
  mkdir -p /home/ec2-user/$REPO_NAME
  tar -xzf /home/ec2-user/repo.tar.gz -C /home/ec2-user/$REPO_NAME
  echo "Contents of /home/ec2-user/$REPO_NAME/src/templates:"
  ls -l /home/ec2-user/$REPO_NAME/src/templates
EOF

# Install Ansible on EC2 instance
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" ec2-user@$EC2_HOST << EOF
  sudo yum update -y
  sudo yum install python3-pip -y
  pip3 install ansible
EOF

# Execute the master Ansible playbook on EC2 instance
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" ec2-user@$EC2_HOST << EOF
  cd /home/ec2-user/$REPO_NAME/ansible
  ansible-playbook master_playbook.yml --extra-vars "repo_name=$REPO_NAME deploy_env=$DEPLOY_ENV"
EOF
