# My Nix Dotfiles

Reproducible development setup using:

- Nix (flakes)
- Home Manager
- Zsh
- Docker
- Node (Corepack + pnpm)
- Ansible
- Direnv

Works on:

- WSL
- Debian
- macOS

---

# Quick Setup (New Machine)

## 1️⃣ Install Zsh First

### Debian / WSL

```bash
sudo apt update
sudo apt install zsh -y
```

### macOS

```bash
# Install Homebrew first (required for zsh on macOS)
# Note: Homebrew is now installed automatically when you run the bootstrap script
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install zsh
brew install zsh

# Install Ollama (latest version) - download directly if Homebrew fails
# Option 1: Via Homebrew (recommended)
brew install ollama

# Option 2: Direct download (if Homebrew needs sudo)
curl -L -o ~/Downloads/ollama https://github.com/jmorganca/ollama/releases/download/v0.3.12/ollama-darwin
chmod +x ~/Downloads/ollama
```

Set Zsh as default shell:

```bash
chsh -s $(which zsh)
```

Restart terminal.

---

## 2️⃣ Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

Restart shell.

Enable flakes:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

---

## 3️⃣ Clone Dotfiles

```bash
git clone https://github.com/Architect-Riyaz/.dotfiles ~/.dotfiles
cd ~/.dotfiles
```

---

## 4️⃣ Generate User Config and Apply

Run the merged script (creates `home/user.nix` then applies the configuration):

```bash
./scripts/bootstrap.sh <wsl|debian|mac>
```

---

Restart terminal after switch.

---

# What Gets Installed

- git
- vim
- docker CLI
- ansible
- nodejs 24
- corepack
- pnpm
- direnv
- nix-direnv
- zsh (autosuggestions + syntax highlight)
- **homebrew** (package manager, installed automatically via Nix activation script)
- **ollama** (AI model runner, installed via Homebrew or direct download on macOS, runs as a service)

All managed by Nix.
Do not install packages manually.

---

# Git Rules (Very Important)

Never commit:

```
home/user.nix
```

Never push that file.

Always stage files like this:

```bash
git add filename
```

Never use:

```bash
git add .
```

Do not update `home/user.nix` in any commit. Ever.

---

# Docker App Aliases

Location:

```
docker/docker_app_aliases.sh
```

Auto loaded by Zsh.

---

# Docker Data Path

| System | Path                      |
| ------ | ------------------------- |
| WSL    | `/mnt/d/apps/docker_apps` |
| Debian | `~/apps/docker_apps`      |
| macOS  | `~/apps/docker_apps`      |

Check:

```bash
echo $DOCKER_APPS_DATA_PATH
```

---

# Zsh Prompt

Shows:

- Username
- Current directory
- Git branch
- Time

Managed by Nix.
Do not edit `.zshrc`.

---

# Updating System

```bash
home-manager switch --flake ~/.dotfiles#<system>
```

Example:

```bash
home-manager switch --flake ~/.dotfiles#wsl
```

---

# Repository Structure

```
.dotfiles
├── flake.nix
├── home/
│   ├── common.nix
│   ├── wsl.nix
│   ├── debian.nix
│   ├── mac.nix
│   └── user.nix
├── docker/
│   └── docker_app_aliases.sh
└── scripts/
    └── bootstrap.sh
```

---

# Reset Anytime

1. Install Zsh
2. Install Nix
3. Clone repo
4. Run update script
5. Apply config

System restored.

---

# Notes

- Docker daemon must be installed separately on Debian and macOS.
- On WSL, Docker Desktop (Windows) is expected.

---

# Philosophy

- No manual installs
- No manual config edits (except `home/user.nix` locally)
- Declarative setup
- Fully reproducible
- Safe to rebuild anytime

---

Built for reproducible infrastructure.
