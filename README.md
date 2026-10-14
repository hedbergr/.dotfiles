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

### Windows

The steps above work in Git Bash (`~` is `C:\Users\<you>`). Two additions:

- Run `dotfiles config core.autocrlf false` before `dotfiles checkout`, so files
  keep LF endings and diff cleanly against the Linux hosts.
- For PowerShell, add a function to `$PROFILE` instead of the alias:

  ```powershell
  function dotfiles { git --git-dir="$HOME\.dotfiles.git" --work-tree="$HOME" @args }
  ```

  Windows PowerShell ships with execution policy `Restricted`, which blocks
  profiles. Allow them with `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.

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
| `.claude/CLAUDE.md` | Claude Code — global instructions |
| `.claude/agents/` | Claude Code — global subagents (`supply-chain-auditor`, `architecture-reviewer`) |
