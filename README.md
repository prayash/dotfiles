# dotfiles

Utilitarian files for general usage.

## Setup

Clone the repo and create symlinks:

```bash
git clone <repo-url> ~/Developer/dotfiles
cd ~/Developer/dotfiles

# Symlink zshrc
ln -sf ~/Developer/dotfiles/.zshrc ~/.zshrc

# Symlink gitconfig
ln -sf ~/Developer/dotfiles/.gitconfig ~/.gitconfig
```

## Git Config

The `.gitconfig` uses an include pattern to keep machine-specific settings (name, email, signing) out of version control.

**After symlinking, create `.gitconfig.local`:**

```bash
cat > ~/Developer/dotfiles/.gitconfig.local << 'EOF'
[user]
    name = Your Name
    email = your@email.com

# Optional: GPG signing (remove if not needed)
[commit]
    gpgsign = true

[gpg]
    format = x509

[gpg "x509"]
    program = /usr/local/bin/ac-sign
EOF
```

This file is gitignored and won't be committed.
