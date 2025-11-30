# dotfiles

## Setup mise-en-place & chezmoi

```bash
sudo dnf copr enable jdxcode/mise
sudo dnf install mise
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```

## Clone dotfiles

```bash
chezmoi init https://github.com/noppomario/dotfiles.git
```

## Apply dotfiles

```bash
chezmoi apply
mise install
```
