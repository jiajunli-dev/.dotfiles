#!/usr/bin/env bash

set -e

echo "======================================"
echo "Installing dotfiles dependencies"
echo "======================================"
echo ""

# Update package lists
echo "📦 Updating package lists..."
sudo apt update

# Install basic dependencies
echo ""
echo "📦 Installing basic dependencies..."
sudo apt install -y \
    curl \
    wget \
    git \
    unzip \
    gpg

# Install tmux
echo ""
echo "📦 Installing tmux..."
sudo apt install -y tmux

# Install fzf
echo ""
echo "📦 Installing fzf..."
if ! command -v fzf &> /dev/null; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo "fzf is already installed"
fi

# Install fd (fd-find on Debian)
echo ""
echo "📦 Installing fd..."
sudo apt install -y fd-find
sudo ln -s $(which fdfind) ~/.local/bin/fd

# Install bat
echo ""
echo "📦 Installing bat..."
sudo apt install -y bat
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install eza (modern replacement for ls)
echo ""
echo "📦 Installing eza..."
if ! command -v eza &> /dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
else
    echo "eza is already installed"
fi

# Install zoxide
echo ""
echo "📦 Installing zoxide..."
if ! command -v zoxide &> /dev/null; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
    echo "zoxide is already installed"
fi

# Install oh-my-posh
echo ""
echo "📦 Installing oh-my-posh..."
if ! command -v oh-my-posh &> /dev/null; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
else
    echo "oh-my-posh is already installed"
fi

# Install TPM (Tmux Plugin Manager)
echo ""
echo "📦 Installing TPM (Tmux Plugin Manager)..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM is already installed"
fi

echo ""
echo "======================================"
echo "✅ Installation complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Create symlinks for your config files"
echo "2. Source your .zshrc: source ~/.zshrc"
echo "3. Install tmux plugins: tmux source ~/.tmux.conf and press prefix + I"
echo "4. Make sure to copy fzf-git.sh to ~/scripts/"
echo ""
