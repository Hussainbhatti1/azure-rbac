pipeline {
  agent any

  stages {

    stage('Terraform Deploy') {
        steps {
            // Access Azure Service Principal credentials
            withCredentials([azureServicePrincipal('azure-sp')]) {
                sh '''
                    # Terraform uses ARM_* environment variables
                    export ARM_CLIENT_ID="$AZURE_CLIENT_ID"
                    export ARM_CLIENT_SECRET="$AZURE_CLIENT_SECRET"
                    export ARM_TENANT_ID="$AZURE_TENANT_ID"
                    export ARM_SUBSCRIPTION_ID="$AZURE_SUBSCRIPTION_ID"

                    # Run Terraform commands
                    terraform init
                    terraform apply -auto-approve
                '''
            }
        }
    }

    stage('Post-Deployment Validation') {
      steps {
        script {
          // Implement post-deployment checks (e.g., using Azure CLI or Terraform)
          sh 'az role assignment list --assignee 29ec2766-fb35-4c65-858f-04237669591d'
        }
      }
    }
  }
}
