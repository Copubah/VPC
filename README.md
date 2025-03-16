# Build Your VPC and Launch a Web Server
## Objectives
After completing this lab, you should be able to:
- Create a Virtual Private Cloud (VPC)
- Create subnets
- Configure a security group
- Launch an Amazon Elastic Compute Cloud (Amazon EC2) instance into a VPC


## Scenario
In this lab, you will use Amazon Virtual Private Cloud (VPC) to create a customized network for a Fortune 100 customer. You will set up security groups and configure an EC2 instance to run a web server. The final architecture includes a VPC with public and private subnets, an internet gateway, NAT gateway, and a running web server instance.

## Architecture Overview
The final setup includes:
- **Two Availability Zones** with both public and private subnets
- **Route Tables** for public and private subnets
- **Internet Gateway** for public internet access
- **NAT Gateway** for outbound internet access from private subnets
- **Security Group** to allow HTTP traffic
- **EC2 Instance** running a web server in a public subnet

## Prerequisites
- An AWS account with access to VPC and EC2 services
- Familiarity with AWS Management Console

## Setup Instructions
### Task 1: Create a VPC
1. Navigate to the **VPC Dashboard**.
2. Click **Create VPC** and select **VPC and more**.
3. Configure the following settings:
   - **IPv4 CIDR:** `10.0.0.0/16`
   - **IPv6 CIDR:** None
   - **Tenancy:** Default
   - **AZs:** 1
   - **Public Subnet:** `10.0.0.0/24`
   - **Private Subnet:** `10.0.1.0/24`
   - **NAT Gateway:** Enabled
4. Click **Create VPC** and verify success.

### Task 2: Create Additional Subnets
1. Go to **Subnets**.
2. Click **Create Subnet**.
3. Configure:
   - **Public Subnet 2:** `10.0.2.0/24`
   - **Private Subnet 2:** `10.0.3.0/24`
4. Click **Create Subnet**.

### Task 3: Associate Subnets and Add Routes
1. Go to **Route Tables**.
2. Associate `Public Subnet 2` with the **Public Route Table**.
3. Associate `Private Subnet 2` with the **Private Route Table**.

### Task 4: Create a Security Group
1. Navigate to **Security Groups**.
2. Click **Create Security Group**.
3. Set:
   - **Name:** `Web Security Group`
   - **Description:** `Enable HTTP access`
4. Under **Inbound Rules**, add:
   - **Type:** HTTP
   - **Source:** Anywhere IPv4
   - **Description:** `Permit web requests`
5. Click **Create Security Group**.

### Task 5: Launch a Web Server Instance
1. Navigate to **EC2 Dashboard**.
2. Click **Launch Instance**.
3. Configure:
   - **Name:** `Web Server 1`
   - **AMI:** Amazon Linux 2
   - **Instance Type:** `t3.micro`
   - **Key Pair:** `vockey`
   - **Subnet:** `Public Subnet 2`
   - **Security Group:** `Web Security Group`
4. Under **Advanced Details**, add the following **User Data**:
```bash
#!/bin/bash
# Install Apache Web Server and PHP
yum install -y httpd mysql php
# Download Lab files
wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1/267-lab-NF-build-vpc-web-server/s3/lab-app.zip
unzip lab-app.zip -d /var/www/html/
# Start web server
chkconfig httpd on
service httpd start
```
5. Click **Launch Instance**.

### Task 6: Verify the Web Server
1. Wait for the instance **Status Check** to show `2/2 passed`.
2. Copy the **Public IPv4 DNS** of the instance.
3. Open a browser and navigate to `http://<Public-IPv4-DNS>`.
4. You should see the success page.

## Conclusion
You have successfully created a fully functional VPC, launched an EC2 instance, and set up a web server accessible via the internet. This architecture can be further extended with additional security, monitoring, and scalability features.

