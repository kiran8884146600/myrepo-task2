
name: Terraform Deployment

on:
  push:
    branches:
      - main  # This will trigger the workflow on pushing to the main branch

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up Terraform
      uses: hashicorp/setup-terraform@v1
      with:
        terraform_version: 1.4.0  # Specify the Terraform version you need

    - name: aws credentials
      uses: aws-actions/configure-aws-credentials@v4
      with:
        aws-region: us-west-2
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
       

    - name: Terraform Init
      run: terraform init

    - name: Terraform Plan
      run: terraform plan -out=tfplan

    - name: Terraform Apply
      run: terraform apply -auto-approve tfplan
    - name: Run Destroy Script
      run: bash destroy.sh
