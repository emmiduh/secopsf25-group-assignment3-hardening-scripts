# Upanzi Matrix Hardening Scripts

This repository contains the baseline Ubuntu hardening scripts provided for the Upanzi Matrix environment, as well as new incident-driven security modules developed in response to attacker behaviors observed during the recent Blue Team investigation.

---

## Purpose
The enhanced modules extend the existing security baseline to address attack vectors discovered during the Blue Team assessment, including:

- Large-scale directory brute-forcing  
- Login API brute-force attempts  
- SQL injection probing  
- Unauthorized internal SSH probing  
- Multi-port lateral reconnaissance bursts  
- Attempts to extract sensitive `.map` files  

---

## Deployment Workflow

### 1. Clone the repository
```bash
git clone https://github.com/emmiduh/secopsf25-group-assignment3-hardening-scripts.git
cd <your-repo-name>
```

### 2. Make all scripts executable
```bash
sudo chmod +x modules/*.sh
```

### 3. Run the enhanced modules
```bash
sudo ./modules/enforce_ssh_key_only.sh
sudo ./modules/restrict_ssh_to_admin_subnet.sh
sudo ./modules/block_ioc_ips.sh
sudo ./modules/nginx_hardening.sh
sudo ./modules/fail2ban_matrix_login.sh
sudo ./modules/install_psad.sh
```
