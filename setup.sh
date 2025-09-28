#!/bin/bash
set -e

echo "🚀 Starting Glendor FlowerAI setup..."

# Check OS
OS=$(uname -s)
echo "Detected OS: $OS"

# --- Python 3.11.13 installation ---
if [[ "$OS" == "Linux" ]]; then
    echo "🔧 Installing Python 3.11.13 on Linux/WSL..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install -y python3.11 python3.11-venv python3.11-dev
elif [[ "$OS" == "Darwin" ]]; then
    echo "🍎 Installing Python 3.11.13 on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found. Please install Homebrew first: https://brew.sh/"
        exit 1
    fi
    brew install pyenv
    pyenv install -s 3.11.13
    pyenv global 3.11.13
else
    echo "❌ Unsupported OS: $OS"
    exit 1
fi

# --- Virtual environment ---
echo "📦 Creating virtual environment (glendor-env)..."
python3.11 -m venv glendor-env
source glendor-env/bin/activate

# --- Upgrade pip ---
echo "⬆️ Upgrading pip..."
pip install --upgrade pip setuptools wheel

# --- Install Flower ---
echo "🌸 Installing Flower..."
pip install -U flwr

# --- Install Ray (pinned to 2.31.0) ---
echo "⚡ Installing Ray 2.31.0..."
pip install ray==2.31.0

echo "✅ Setup completed!"
echo ""
echo "Next steps:"
echo "1. Run: source glendor-env/bin/activate"
echo "2. Initialize Flower app: flwr new  (choose PyTorch if prompted)"
echo "3. Install app: cd <your_app_name> && pip install -e ."
echo "4. Install and log into Tailscale: tailscale up"
echo "5. Enable Ray: export RAY_ENABLE_WINDOWS_OR_OSX_CLUSTER=1"
echo "6. Start Ray cluster: ray start --address=<tailscaleip>:<port>"
echo "7. Run Flower node: flwr run ."
