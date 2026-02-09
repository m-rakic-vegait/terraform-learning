## Terraform Learning Tasks - Infrastructure as Code

### TASK 1: Terraform Basics - S3 Bucket Management
**To Do:**
1. Initialize Terraform project - Create a new directory and set up AWS provider configuration
2. Create S3 bucket - Use Terraform resource to create bucket named student-terraform-learning-[your-initials]-[date]
3. Add versioning - Configure bucket versioning through Terraform resources
4. Apply bucket policy - Create and attach a policy that allows public read access to objects
5. Execute workflow - Learn terraform init, plan, apply commands
6. Inspect state - Examine terraform.tfstate file and understand state management
7. Clean up - Use terraform destroy to remove resources

### TASK 2: IAM Resources with Dependencies and Outputs
**To Do:**
1. Create IAM user - Build IAM user named terraform-test-student
2. Use data sources - Reference AWS managed S3ReadOnlyAccess policy using data source
3. Create custom policy - Define a policy that only allows access to buckets starting with student-terraform-learning-*
4. Attach both policies - Use policy attachments to link managed and custom policies
5. Output values - Export user ARN and relevant information
6. Local values - Use locals block for reusable values across resources

### TASK 3: EC2 Infrastructure with Variables and Dynamic Data
**To Do:**
1. Define variables - Create variables for instance type, key pair name, environment tags
2. Dynamic AMI lookup - Use data sources to automatically find latest Amazon Linux AMI
3. Create security group - Build security group named terraform-learning-sg with SSH access
4. Launch instance - Deploy t2.micro EC2 instance using variables and data sources
5. Conditional logic - Use count or for_each for optional resource creation
6. Variable validation - Add validation rules and descriptions for input variables
7. Multiple environments - Use .tfvars files for dev/prod configurations

### TASK 4: VPC Network Infrastructure and Modules
**To Do:**
1. Create VPC module - Build a reusable module for complete VPC infrastructure
2. Module structure - Organize with main.tf, variables.tf, outputs.tf files
3. Network components - Create VPC (10.0.0.0/16), subnet (10.0.1.0/24), Internet Gateway
4. Route table setup - Configure routing for internet access (0.0.0.0/0 → IGW)
5. Use for_each - Create multiple subnets using iteration techniques
6. Module consumption - Use your VPC module in a root configuration
7. Module outputs - Export VPC ID, subnet IDs, route table IDs for other resources
8. Resource tagging - Implement consistent tagging strategy across all resources

### TASK 5: Serverless Infrastructure with Lambda
**To Do:**
1. Lambda function resource - Create Python Lambda function that returns event data
2. IAM role creation - Build Lambda execution role with proper trust policy
3. Package management - Handle Lambda deployment package creation (ZIP file)
4. CloudWatch permissions - Attach basic execution role for logging capabilities
5. Add API Gateway - Create REST API endpoint that triggers Lambda function
6. CloudWatch integration - Set up log groups and monitoring
7. Environment variables - Pass configuration to Lambda through Terraform
8. Test endpoint - Create outputs to access and test your API

### TASK 6: State Management and Advanced Patterns
**To Do:**
1. Remote state backend - Configure S3 backend for state storage
2. State locking - Implement DynamoDB table for state locking
3. Workspace management - Create separate workspaces for different environments
4. Data source references - Reference resources from other Terraform states
5. State manipulation - Practice terraform state commands (list, show, mv)
6. Backend migration - Migrate from local to remote state safely
7. Sensitive values - Handle sensitive data and outputs appropriately



