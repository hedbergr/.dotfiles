# dotfiles

Managed as a **bare git repository** with `$HOME` as the work tree. No stow, no
chezmoi, no symlinks — files live where they belong and git tracks them in place.

## Setup on a new machine

```bash
git clone --bare https://github.com/hedbergr/.dotfiles.git ~/.dotfiles.git
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
dotfiles checkout
```

`dotfiles checkout` fails if a tracked file already exists in `$HOME`. Move the
conflicting files aside and re-run — the error lists them.

Use SSH (`git@github.com:hedbergr/.dotfiles.git`) instead of HTTPS if you want
to push from that machine.

## Daily use

Same as git, with `dotfiles` in place of `git`:

```bash
dotfiles status
dotfiles add ~/.vimrc
dotfiles commit -m "vim: ..."
dotfiles push
```

Make the alias permanent by adding it to `~/.zshrc` or `~/.bashrc`.

## Why `status.showUntrackedFiles no`

Without it the work tree is all of `$HOME`, so `dotfiles status` lists every
file in the home directory. With it, only tracked files are reported — add new
ones explicitly by path.

## What's here

| File | For |
|---|---|
| `.vimrc` | vim |
| `.tmux.conf` | tmux — `C-a` prefix, 1-indexed windows, `\` / `-` splits |
| `.emacs.d/` | emacs |
