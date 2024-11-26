#!/bin/bash

# Install necessary packages
sudo apt-get install tree -y

# Create version file
echo "1.0.0" > Version.txt

# Create terraform directory structure
mkdir -p terraform/instances/{staging,production} terraform/infrastructure

# Create terraform files
touch terraform/instances/staging/{main.tf,variables.tf,outputs.tf}
touch terraform/instances/production/{main.tf,variables.tf,outputs.tf}
touch terraform/infrastructure/{main.tf,variables.tf,outputs.tf}

# Create source code directories and files
mkdir -p src/{templates,static}
touch src/app.py src/requirements.txt
touch src/templates/index.html
touch src/static/{styles.css,script.js}

# Create GitHub workflows and actions directories and files
mkdir -p .github/{workflows,actions/deploy}
touch .github/workflows/{ci.yml,cd.yml}
touch .github/actions/deploy/{prepare_deployment.sh,action.yml}

# Create Ansible directories and files
mkdir -p ansible
touch ansible/{hosts,ansible.cfg,setup_environment.yml,deploy_application.yml,master_playbook.yml}

# Populate Ansible master_playbook.yml with content
echo -e "---\n- import_playbook: setup_environment.yml\n- import_playbook: deploy_application.yml" > ansible/master_playbook.yml

# Create configuration files
mkdir -p config
cat <<EOF > config/prod_config.yml
aws:
  environment: 
  region: 
  ami: 
  instance_type: 
  key_name: 
EOF

cat <<EOF > config/staging_config.yml
aws:
  environment: 
  region: 
  ami: 
  instance_type: 
  key_name: 
EOF

# Create README and .gitignore files
echo "This is the readme.md file" > README.md
touch .gitignore

# Move baseline.sh to scripts directory
mkdir -p scripts
mv baseline.sh scripts

# Optional: Display directory structure
tree
