# Build Your VPC and Launch a Web Server with Terraform

- This project demonstrates how to use **Terraform** to build a **Virtual Private Cloud (VPC)** and launch a simple web server on an **Amazon EC2** instance. It includes creating a VPC, subnets, route tables, an internet gateway, security groups, and an EC2 instance.

---

## Features
- **VPC Creation:** A custom VPC with a /16 CIDR block.
- **Subnets:** One public subnet with auto-assigned public IPs.
- **Internet Gateway:** To allow outbound internet traffic.
- **Route Table:** Public route for internet access.
- **Security Group:** Allows inbound HTTP and SSH traffic.
- **Web Server:** EC2 instance running Apache.

---

## Structure
my-web-server/
├── main.tf # Main Terraform configuration
├── variables.tf # Input variables
└── outputs.tf # Output variables



---

##  Prerequisites
- An AWS account
- Terraform installed ([Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
- An existing EC2 key pair in your AWS region

---

##  Usage

### 1. Clone the Repository**
```bash
git clone https://github.com/Copubah/VPC.git
cd my-web-server


2. Update Variables
Set your EC2 key pair name in variables.tf:

variable "key_pair_name" {
  description = "The name of the EC2 key pair"
  type        = string
}

3. Initialize Terraform
- terraform init

4. Validate the Configuration
- terraform validate

5. Plan the Deployment
- terraform plan -var="key_pair_name=YOUR_KEY_PAIR_NAME"


6. Deploy the Infrastructure
- terraform apply -var="key_pair_name=YOUR_KEY_PAIR_NAME" -auto-approve

7. Test the Web Server
- Get the Public IP or Public DNS from the output.

- Visit http://<Public IP> in your browser.

- You should see "Welcome to My Web Server!"


## Clean Up 
- To destroy the resources and avoid ongoing costs
  
    - terraform destroy -var="key_pair_name=YOUR_KEY_PAIR_NAME" -auto-approve


## Outputs
- After a successful deployment, you’ll see outputs like:

- instance_public_ip: The public IP of the EC2 instance.

- instance_public_dns: The public DNS of the EC2 instance


## License
- This project is licensed under the MIT License

