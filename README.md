# Mac Onboarding Setup Script
This repository provides an automated setup script to bootstrap a complete development environment on macOS within minutes. No more headaches for new team members!

### What's Included?

The script automates the installation and configuration of the following:

- Package Manager: Homebrew
- Shell Environment: Zsh, Starship (Custom Prompt), Zsh-plugins (Autosuggestions, Syntax Highlighting)
- Development Tools: Node.js (via NVM), Docker, VS Code, Postman
- Modern CLI Utilities: fzf, zoxide, bat, eza, tldr, ripgrep, gh (GitHub CLI)
- Terminal & UI: iTerm2, JetBrains Mono Nerd Font
- Git Configuration: Global user setup, default branch (main), pull rebase, etc.

---
### Quick Start
Simply open your Terminal and run the following command.

```Bash
curl -s https://raw.githubusercontent.com/eugenelee-vocovo/onboarding/main/setup.sh | bash
```

Note: You might be prompted to enter your macOS password during the Homebrew installation process.

#### ⚠️ Font Setup (Required for Icons)
The script installs **JetBrains Mono Nerd Font**, but you must manually apply it to your terminal:

1. **iTerm2**: `Settings` -> `Profiles` -> `Text` -> `Font` -> Select **JetBrainsMono Nerd Font**.
2. **VS Code**: `Settings` -> Search `terminal font` -> Add `'JetBrainsMono Nerd Font'` to the front of the list.

*Without this, your prompt (Starship) and file icons (eza) will appear as broken squares!*

---

### Modern CLI Aliases
The setup script configures several powerful aliases to supercharge your terminal experience. You can use these intuitive commands:

| Tool | Standard Command | Alias / Usage | Description |
| :--- | :--- | :--- | :--- |
| **eza** | `ls` | `ls` | Enhanced file listing with icons and colors |
| **eza** | `ls -lah` | `ll` | Detailed list with permissions, sizes, and Git status |
| **eza** | `ls --tree` | `lt` | **Tree view** of the directory structure (2 levels deep) |
| **bat** | `cat` | `cat [file]` | `cat` with syntax highlighting and line numbers |
| **zoxide** | `cd` | `cd` or `z` | **Smart Jump**: Instantly navigate to learned folders |
| **ripgrep**| `grep` | `grep [term]` | Blazing fast text search (Rust-based) |
| **tldr** | `man` | `tldr [command]` | **Practical Examples**: Simple help pages for any command |

> **💡 Tip:** Once you have visited a directory, you can jump back to it by typing `cd` or `z` followed by just a part of the folder name!

### Essential Keyboard Shortcuts
Master these shortcuts to navigate your terminal like a pro:

| Tool | Shortcut | Action |
| :--- | :--- | :--- |
| **fzf** | `Ctrl + R` | **Command History**: Search and reuse past commands |
| **fzf** | `Ctrl + T` | **File Finder**: Search files and paste paths instantly |
| **zsh-autosuggestions** | `Right Arrow (→)` | **Auto-complete**: Accept the full suggestion |
| **zsh-autosuggestions** | `Alt/Opt + →` | **Partial Accept**: Accept only the next word |
| **Terminal** | `Ctrl + L` | **Clear Screen**: Keep your workspace clean and tidy |


---
### ✍️ Author
Eugene Lee (@[eugenelee-vocovo])

Feel free to open an Issue or submit a Pull Request for any tool additions or improvements.