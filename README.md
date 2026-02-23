# ❄️ My Nix Dotfiles

Reproducible development environment using:

- Nix (flakes)
- Home Manager
- Zsh
- Docker
- Node (Corepack + pnpm)
- Ansible
- Direnv

Works on:

- ✅ WSL
- ✅ Debian
- ✅ macOS

---

# 🚀 Quick Setup (New Machine)

## 1️⃣ Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

Restart your shell.

Enable flakes:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

---

## 2️⃣ Clone Dotfiles

```bash
git clone https://github.com/Architect-Riyaz/.dotfiles ~/.dotfiles
cd ~/.dotfiles
```

---

## 3️⃣ Apply Configuration

For WSL:

```bash
nix run home-manager/master -- switch --flake ~/.dotfiles#wsl
```

For Debian:

```bash
nix run home-manager/master -- switch --flake ~/.dotfiles#debian
```

For macOS:

```bash
nix run home-manager/master -- switch --flake ~/.dotfiles#mac
```

---

## 4️⃣ Set Zsh as Default Shell

```bash
chsh -s $(which zsh)
```

Restart terminal.

---

# ✅ What Gets Installed

- git
- vim
- docker (CLI)
- ansible
- nodejs 24
- corepack
- pnpm
- direnv
- nix-direnv
- zsh (with autosuggestions + syntax highlight)

---

# 🐳 Docker App Aliases

Stored in:

```
docker/docker_app_aliases.sh
```

Automatically sourced by zsh.

---

# 📁 Docker Data Path

Different per system:

| System | Path |
|--------|------|
| WSL | `/mnt/d/apps/docker_apps` |
| Debian | `~/apps/docker_apps` |
| macOS | `~/apps/docker_apps` |

Available as:

```bash
echo $DOCKER_APPS_DATA_PATH
```

---

# 🖥 Zsh Prompt

Custom prompt shows:

- Username (green)
- Current directory
- Git branch
- Time
- New line prompt

Fully managed by Nix.  
Do not edit `.zshrc` manually.

---

# 🔁 Updating System

To update packages:

```bash
home-manager switch --flake ~/.dotfiles#<system>
```

Example:

```bash
home-manager switch --flake ~/.dotfiles#wsl
```

---

# 🧠 Philosophy

- No manual package installs
- No manual config edits
- Fully declarative
- Reproducible on any machine
- Safe to reinstall anytime

---

# 📂 Repository Structure

```
.dotfiles
├── flake.nix
├── home/
│   ├── common.nix
│   ├── wsl.nix
│   ├── debian.nix
│   └── mac.nix
├── docker/
│   └── docker_app_aliases.sh
└── scripts/
    └── bootstrap.sh
```

---

# 🔥 Reset & Rebuild Anytime

Delete your system.

Reinstall Nix.

Run 3 commands.

You are back exactly where you were.

---

# ⚠ Notes

- Docker daemon must be installed separately on Debian/macOS.
- On WSL, Docker Desktop (Windows) is expected.

---

# 📌 Future Improvements

- Starship prompt
- Neovim config via Nix
- Full NixOS migration
- Dev shells per project

---

Built for reproducible infrastructure.
