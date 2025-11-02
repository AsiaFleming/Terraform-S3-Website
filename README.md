# Terraform AWS Website Infrastructure 🧩

## Project Overview
This project provisions a **2-tier AWS web environment** using **Terraform**. It automates the setup of an S3 static website and EC2-based backend within a custom VPC providing a foundational Infrastructure-as-Code example for cloud and DevOps roles.

---

## AWS Services Used
- **Amazon S3** — Static website hosting for `index.html` and `error.html`.
- **Amazon EC2** — Hosts web or app server instance.
- **Amazon VPC** — Custom virtual network with subnet and route configurations.
- **Security Groups** — Defines inbound and outbound rules for EC2 access.
- **IAM** — (Optional) Service roles and permissions for resource management.

---

## 📂 Project Structure
```
AWS-website/
│── provider.tf               # AWS provider configuration
│── vpc.tf                    # VPC setup and networking
│── ec2.tf                    # EC2 instance provisioning
│── security-groups.tf        # Security group configurations
│── bucket.tf                 # S3 bucket setup for website hosting
│── variable.tf               # Input variables
│── index.html                # Main website page
│── error.html                # Custom error page
```

---

## Deployment Instructions
1. **Initialize Terraform**
   ```bash
   terraform init
   ```
2. **Preview the execution plan**
   ```bash
   terraform plan
   ```
3. **Apply changes**
   ```bash
   terraform apply
   ```
4. **Access your hosted site**
   - Navigate to the S3 static website endpoint or EC2 public IP.

---

## Architecture Diagram
Below is a simplified overview of the infrastructure:

```
          ┌─────────────────────┐
          │      Internet       │
          └─────────┬───────────┘
                    │
             ┌──────┴──────┐
             │   VPC (CIDR) │
             └──────┬──────┘
                    │
           ┌────────┴────────┐
           │  EC2 Instance   │
           │ (Web/App Tier)  │
           └────────┬────────┘
                    │
           ┌────────┴────────┐
           │   S3 Bucket     │
           │(Static Website) │
           └─────────────────┘
```

---

## Skills Demonstrated
- Infrastructure-as-Code (IaC) with **Terraform**
- AWS networking and resource provisioning
- S3 website configuration and permissions
- Cloud automation fundamentals

---

## Room for Growth
- Add **CloudFront + SSL (ACM)** for HTTPS domain support  
- Integrate **CloudWatch** for logging and monitoring  
- Build CI/CD with GitHub Actions for automatic deployment  
- Add Terraform **outputs.tf** for cleaner resource referencing  

---

Created by **Asia Fleming**   
