# 🌸 Glendor FlowerAI Setup

This repository provides standardized resources and instructions for deploying and configuring **FlowerAI nodes** within the Glendor environment. It is designed to ensure consistency, reliability, and ease of setup across all team members' devices.

## 🚀 Getting Started

You may set up your FlowerAI node in one of two ways:

* **Option 1 (Recommended)**: Automated Setup → one script handles most of the process.
* **Option 2**: Manual Setup → follow detailed step-by-step instructions.

## ✅ Option 1: Automated Setup (Recommended)

This script supports **Linux/WSL** and **macOS**.

1. **Clone this repository:**
   ```bash
   git clone https://github.com/glendor/glendor-flowerai-setup.git
   cd glendor-flowerai-setup
   ```

2. **Make the setup script executable:**
   ```bash
   chmod +x setup.sh
   ```

3. **Run the script:**
   ```bash
   ./setup.sh
   ```

4. **Complete the final manual steps:**
   ```bash
   cd <your_app_name> && pip install -e .
   tailscale up   # log in with your Glendor email
   ```

5. **Start the Ray cluster:**
   ```bash
   ray start --address=100.107.151.128:6379
   ```

6. **Run Flower node:**
   ```bash
   flwr run .
   ```

## 🔧 Option 2: Manual Setup (Step-by-Step)

### 🐧 Linux / WSL Users

1. **Install WSL2** (Windows only)
   * [Microsoft Docs: Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install)

2. **Install Python 3.11.13:**
   ```bash
   sudo apt update
   sudo apt install -y software-properties-common
   sudo add-apt-repository -y ppa:deadsnakes/ppa
   sudo apt update
   sudo apt install -y python3.11 python3.11-venv python3.11-dev
   ```

3. **Create and activate a virtual environment:**
   ```bash
   python3.11 -m venv glendor-env
   source glendor-env/bin/activate
   ```
   
4. **Install Flower:**
   ```bash
   pip install -U flwr
   ```

5. **Initialize Flower app** (choose PyTorch when prompted):
   ```bash
   flwr new
   ```

6. **Install the generated app:**
   ```bash
   cd <your_app_name> && pip install -e .
   ```

7. **Install and log into Tailscale** with your Glendor email:
   ```bash
   curl -fsSL https://tailscale.com/install.sh | sh
   sudo tailscale up
   ```

8. **Enable Ray and start cluster:**
   ```bash
   export RAY_ENABLE_WINDOWS_OR_OSX_CLUSTER=1
   ray start --address=100.107.151.128:6379
   ```

9. **Run Flower node:**
    ```bash
    flwr run .
    ```

### 🍎 macOS Users

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Python 3.11.13:**
   ```bash
   brew install python@3.11
   ```
   
3. **Create and activate a virtual environment:**
   ```bash
   python3.11 -m venv glendor-env
   source glendor-env/bin/activate
   ```

4. **Install Flower:**
   ```bash
   pip install -U flwr
   ```

5. **Initialize Flower app** (choose PyTorch when prompted):
   ```bash
   flwr new
   ```

6. **Install the generated app:**
   ```bash
   cd <your_app_name> && pip install -e .
   ```

7. **Install and log into Tailscale** with your Glendor email:
   ```bash
   brew install tailscale
   sudo tailscale up
   ```

8. **Enable Ray and start cluster:**
   ```bash
   export RAY_ENABLE_WINDOWS_OR_OSX_CLUSTER=1
   ray start --address=100.107.151.128:6379
   ```

9. **Run Flower node:**
    ```bash
    flwr run .
    ```

## 🛠 Troubleshooting

* **Virtual Environment**: Ensure you are inside `glendor-env` before running any `pip` or `flwr` commands.

* **Flower Installation Issues**: If `flwr new` fails, try upgrading pip again:
  ```bash
  pip install --upgrade pip setuptools wheel
  ```

* **Tailscale Connection**: Confirm Tailscale is connected before starting Ray:
  ```bash
  tailscale status
  ```

* **Ray Configuration**: Verify Ray is enabled:
  ```bash
  echo $RAY_ENABLE_WINDOWS_OR_OSX_CLUSTER   # should print 1
  ```

## 📋 Requirements

* Python 3.11.13
* FlowerAI
* Tailscale (with Glendor email access)
* Ray 2.31.0 (for distributed computing)
* WSL2 (Windows users only)
* Homebrew (macOS users only)
