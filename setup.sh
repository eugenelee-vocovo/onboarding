#!/bin/bash

# =====================================================================
# Team Onboarding Setup Script
# Description: Automated environment setup for new developers
# Author: Eugene Lee
# =====================================================================

echo "🚀 Starting Team Onboarding Setup..."

# 1. Install Homebrew (The foundation)
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # [Important] Path for M1/M2 Mac Users
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed."
fi

# 2. Install Core Development Tools (VScode, Docker, nvm, starship etc) 
echo "📦 Installing Code Development Tools..."

cli_tools=(starship fzf zoxide bat eza tldr ripgrep nvm gh zsh-autosuggestions zsh-syntax-highlighting)
cask_apps=(docker visual-studio-code iterm2 postman font-jetbrains-mono-nerd-font)

for pkg in "${cli_tools[@]}"; do
    if brew list "$pkg" &>/dev/null; then
        echo "⏭️ $pkg: Already installed. Skipping..."
    else
        echo "📦 $pkg: Installing..."
        brew install "$pkg"
    fi
done

for app in "${cask_apps[@]}"; do
    if brew list --cask "$app" &>/dev/null; then
        echo "⏭️ $app: Already installed. Skipping..."
    else
        echo "📦 $app: Installing..."
        brew install --cask "$app"
    fi
done

# 3. Setup NVM & Install Latest Node.js
echo "🔧 Setting up Node.js Environment..."
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"

[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

if command -v nvm &> /dev/null; then
    if node -v &> /dev/null; then
        echo "⏭️ Node.js: Already installed ($(node -v)). Skipping..."
    else
        echo "📦 Node.js: Installing LTS version..."
        nvm install --lts
        nvm use --lts
        nvm alias default 'lts/*'
        echo "✅ Node $(node -v) & NPM $(npm -v) installed!"
    fi
fi

# 4. Setup Shell Environment (.zshrc)
echo "🔧 Configuring .zshrc for core tools..."

# skip if it's already there
if ! grep -q "Core Tool Initializations" ~/.zshrc; then
cat << 'EOF' >> ~/.zshrc

# --- VS Code 'code' command ---
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# --- NVM (Lazy Loading) ---
load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}
nvm()  { unset -f nvm;  load_nvm; nvm "$@"; }
node() { unset -f node; load_nvm; node "$@"; }
npm()  { unset -f npm;  load_nvm; npm "$@"; }
npx()  { unset -f npx;  load_nvm; npx "$@"; }

# --- Modern CLI Aliases ---
alias ls="eza --icons --group-directories-first"
alias ll="eza -lah --icons --group-directories-first"
alias lt="eza --tree --level=2 --icons"
alias cat="bat"
alias cd="z"
alias grep="rg"

# --- Core Tool Initializations ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# --- Zsh Plugins (Homebrew) ---
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF
    echo "✅ Configuration added to .zshrc"
else
    echo "⏭️ .zshrc configuration already exists. Skipping..."
fi

# 5. Final Configurations (Git & GitHub)
echo "🔧 Finalizing Git & GitHub configuration..."

# 5-1. Git Global Config
if [ -z "$(git config --global user.name)" ] || [ -z "$(git config --global user.email)" ]; then
    read -p "Enter your Git User Name: " git_user_name
    read -p "Enter your Git User Email: " git_user_email
    git config --global user.name "$git_user_name"
    git config --global user.email "$git_user_email"
fi

git config --global core.editor "nano" 
git config --global init.defaultBranch main 
git config --global pull.rebase true
git config --global core.ignorecase false 

echo "✅ Git configured as: $(git config --global user.name) ($(git config --global user.email))"

# 5-2. GitHub Auth
if command -v gh &>/dev/null; then
    if ! gh auth status &>/dev/null; then
        echo "🔑 Logging in to GitHub CLI..."
        gh auth login
    else
        echo "✅ GitHub: Already authenticated."
    fi
fi

# TODO: GPG key configuration

# 6. Success Message
echo "--------------------------------------------------"
echo "✅ Setup Complete!"
echo "🚀 Applying changes... Please wait."
echo "--------------------------------------------------"

# tldr init update
tldr --update &>/dev/null &

exec zsh -l