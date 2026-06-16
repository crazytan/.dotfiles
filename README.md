# Dotfiles

Personal macOS setup for bash, Starship, and Ghostty.

## What Is Managed

- `~/.bash_profile`
- `~/.bashrc`
- `~/.config/starship.toml`
- `~/.config/ghostty/config`
- `~/.config/ghostty/shaders/cursor_tail.glsl`

The repo also keeps older Emacs/zsh files that were already here, but the installer only links the extracted bash, Starship, and Ghostty files above.

## New Mac Setup

```bash
git clone https://github.com/crazytan/.dotfiles.git ~/src/.dotfiles
cd ~/src/.dotfiles
./install.sh --brew --npm
```

Use `./install.sh --dry-run` first to preview symlinks and backups.
The `--brew` path also runs fzf's installer with `--no-update-rc` so `~/.fzf.bash` exists without fzf editing shell startup files.

## Notes

- Existing target files are backed up with a timestamped `.backup.YYYYMMDDHHMMSS` suffix before symlinking.
- Put private or machine-specific shell settings in `~/.bashrc.local`; it is sourced at the end of `~/.bashrc` and intentionally not tracked here.
- The active Ghostty settings were extracted from `~/.config/ghostty/config`. The old `~/Library/Application Support/com.mitchellh.ghostty/config` file only contained the generated template, so it is not linked.
- `~/.config/.bashrc` was an older duplicate of the current bash config and is not linked.
- The `cc` alias appears only when `claude` is installed. Install Claude separately if you want that alias active on a fresh Mac.
