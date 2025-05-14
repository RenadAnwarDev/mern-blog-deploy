# MERN Stack Blog App Deployment with Terraform & Ansible

This project demonstrates the deployment of a full-stack MERN blog application using **Terraform** and **Ansible** on **AWS Cloud**.

## Goal

The goal was to fully automate the deployment of both frontend and backend services of a MERN blog application using Infrastructure as Code (IaC) tools: **Terraform** for infrastructure provisioning and **Ansible** for backend configuration and setup.

---

## What Was Configured & Deployed

### Using **Terraform**:
- Created an IAM user with programmatic access and policy for S3 uploads.
- Provisioned an EC2 instance with SSH key, AMI, and security group.
- Created two S3 buckets:
  - One for **frontend hosting** (static site).
  - One for **media file uploads**.
- Outputs for access keys and bucket info.

### Using **Ansible**:
- Connected to the EC2 backend server via SSH.
- Installed **Node.js**, **npm**, and **PM2**.
- Cloned the blog repo.
- Injected `.env` file using a Jinja2 template.
- Installed backend dependencies and started the app with PM2.

### Frontend:
- Built the React frontend.
- Uploaded build files to S3.
- Configured S3 bucket policy and static hosting settings.

---

## Tools & Services Used

- **Terraform**
- **Ansible**
- **AWS EC2**
- **AWS S3**
- **IAM**
- **MongoDB Atlas**
- **PM2**
- **Ubuntu 22.04**
- **Git & GitHub**

---

## Screenshots

> Located in `/screenshots/` folder:

- `pm2-backend.png`: PM2 showing the backend running on EC2.
- `mongodb-cluster.png`: MongoDB Atlas database view.
- `media-upload-success.png`: Successful media upload in blog post.
- `s3-frontend.png`: Frontend rendered through S3 static hosting.

---

## Cleanup Steps

- Ran `terraform destroy` to delete all provisioned AWS resources.
- Revoked AWS IAM user and access keys.
- Removed sensitive files like `.env` from the repository.

---

## Blockers & Solutions (Optional)

> Some challenges I encountered:

- **S3 ACL error** when uploading: fixed by using `ObjectOwnership` and removing `--acl public-read`.
- **MongoDB connection errors**: solved by setting IP whitelist to `0.0.0.0/0` and using correct URI format.
- **Frontend 403/404**: resolved by uploading from `dist/` instead of `build/`, and ensuring `index.html` was present.

---

## Final Notes

This project helped me apply real-world cloud automation techniques using Terraform and Ansible. I understood the flow from infrastructure provisioning to configuration management and continuous deployment.
