
# **🌍 Hetzner Cloud Kubernetes Deployment**  

## **📌 Overview**  

This project provides an **automated approach** to deploying a **Kubernetes cluster** on **Hetzner Cloud** using **[Terragrunt](https://terragrunt.gruntwork.io/)** and **OpenTofu/Terraform**.  

🔹 **Includes** custom **Terraform modules** for managing various Kubernetes objects.  
🔹 **Provides** configuration for **AWS authentication**, **Hetzner Cloud API integration**, and more.  

---

## **⚙️ Prerequisites**  

Make sure you have the following tools installed:  

- ✅ **Terraform** or **OpenTofu**  
- ✅ **Packer** *(used for snapshot creation)*  
- ✅ **kubectl** CLI *(for Kubernetes management)*  
- ✅ **hcloud** CLI *(for Hetzner Cloud interaction)*  

### **📥 Install via Homebrew (MacOS/Linux)**  

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform  # OR brew install opentofu
brew install packer
brew install kubectl
brew install hcloud
```

---

## **💡 [Must-Read] OpenSUSE MicroOS Snapshot**  

1️⃣ **Create a project** in your **[Hetzner Cloud Console](https://console.hetzner.cloud/)**.  
2️⃣ **Generate an SSH key pair** *(ed25519, no passphrase required)*.  
3️⃣ **Initialize a new project folder** and create a **MicroOS snapshot**:  

```sh
mkdir /path/to/your/new/folder
cd /path/to/your/new/folder
curl -sL https://raw.githubusercontent.com/kube-hetzner/terraform-hcloud-kube-hetzner/master/packer-template/hcloud-microos-snapshots.pkr.hcl -o hcloud-microos-snapshots.pkr.hcl
export HCLOUD_TOKEN="your_hcloud_token"
packer init hcloud-microos-snapshots.pkr.hcl
packer build hcloud-microos-snapshots.pkr.hcl
hcloud context create <project-name>
```

---

## **🔐 AWS Authentication Setup**  

Set your AWS credentials as environment variables:  

```sh
export AWS_ACCESS_KEY_ID="your_access_key_id"
export AWS_SECRET_ACCESS_KEY="your_secret_access_key"
export AWS_SESSION_TOKEN="your_session_token"  # if required
```

---

## **🚀 How to Deploy the Infrastructure**  

### **⚠️ Prerequisites**  

1. Install **OpenTofu v1.6.0+** and **Terragrunt v0.52.0+**.  
2. Update the `bucket` parameter in the **root `terragrunt.hcl`**.  
   - **S3 is used** for Terraform state storage.  
   - Ensure your S3 bucket name is **globally unique**.  
   - Alternatively, set the `TG_BUCKET_PREFIX` environment variable.  
3. Set up **Hetzner Cloud projects & DNS zones**.  
4. Generate **Hetzner API tokens** and add them to `env.hcl`.  
5. Fill in all **environment-specific** values.  
6. Configure your **AWS credentials**.  

---

## **📦 Deploying Infrastructure**  

### **🚀 Deploying a Single Module**  

```sh
cd live/non-prod/eu-central/dev/cluster  # Navigate to the module folder
terragrunt plan   # Preview changes
terragrunt apply  # Deploy if plan looks good
```

### **🌎 Deploying All Modules in a Region**  

```sh
cd live/non-prod/eu-central  # Navigate to the region folder
terragrunt run-all plan      # Preview all changes
terragrunt run-all apply     # Deploy all modules
```

---

## **📂 Repository Structure**  

```
account
 └ _global
 └ region
    └ _global
    └ environment
       └ resource
```

### **📌 Explanation:**  

- **Account Level** 🏢  
  - Each folder represents a **Hetzner Cloud account** (`stage-account`, `prod-account`, `mgmt-account`).  
  - If all resources are in a single account, there will be only **one folder** (e.g., `main-account`).  

- **Region Level** 🌎  
  - Contains **regional deployments** (e.g., `eu-central`, `us-east`).  
  - The `_global` folder contains **shared resources** across all regions.  

- **Environment Level** 🌱  
  - Defines **project environments** (`dev`, `stage`, `prod`).  
  - `_global` contains **resources shared** within a region.  

- **Resource Level** ⚙️  
  - Each **Terraform module** corresponds to a **resource** in the cluster.  

---

## **🔧 Using Root-Level Variables (Account-Level Configuration)**  

When managing multiple **accounts/regions**, avoid duplicating common variables by defining them **in the root `terragrunt.hcl`** file.  

---

## **🛠 Custom Terraform Modules**  

This project includes a collection of **custom Terraform modules** for **Kubernetes objects**.  

| 📦 Module Name          | 🔧 Purpose |
|-------------------------|-----------|
| `grafana/prometheus`    | **Monitoring & Metrics** 📊 |
| `percona-ps-operator`  | **Database Operator for Percona** 💾 |
| `percona-ps`           | **Percona Database Deployment** 🔄 |
| `external-dns-hetzner` | **Automated DNS Management** 🌐 |

---

## **📜 License & Contribution**  

💡 **This project is open-source. Contributions are welcome!**  

If you have **feature requests**, **improvements**, or **bug fixes**, feel free to **submit a PR**! 🚀  

🔗 **GitHub Repository:** [coldsummerstape](https://github.com/coldsummerstape) 