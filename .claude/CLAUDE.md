# Git Workflow

- Keep commits to a minimum — squash related changes into single commits rather than committing every small step. Amend or fixup into the relevant existing commit when fixing something on an unmerged branch.
- Never push directly to main. Always create a feature branch.
- Use Conventional Commits format: `type(scope): message` (e.g. `feat(auth): add login endpoint`, `fix: resolve null pointer on empty input`). Keep the subject line short.
- Keep issue descriptions, PR descriptions, and READMEs short and to the point.
- Create a GitHub issue before starting non-trivial work. Small, self-evident fixes don't need one. Link the PR to its issue (`Closes #N`).

# Supply Chain Security

- Pin dependencies and container images by SHA digest, not mutable tags (e.g. `image@sha256:abc...`, not `image:latest`).
- Verify checksums/signatures when downloading binaries or packages.
- In Dockerfiles, use `FROM image@sha256:...` — never `:latest` or a bare tag alone.
- Never commit secrets, credentials, or API keys. Use environment variables or a secret manager. Ensure `.gitignore` covers `.env`, key files, etc.
- Apply least privilege: CI/CD tokens, IAM roles, and service accounts should have the minimum permissions needed. Flag overly broad grants.
- Run containers as non-root. Add a `USER` directive in Dockerfiles and avoid `--privileged`.

# Python

- Use `uv` for dependency management, not pip. Projects use `pyproject.toml` + `uv.lock`, not `requirements.txt`.
- Always work inside a virtual environment. `uv sync` creates `.venv` automatically.
- Run scripts via `uv run python3 script.py`.
- Use `python-dotenv` for loading `.env` files — never hardcode secrets or require manual `source .env`.
- Pin dependency versions in `pyproject.toml`.

# Git and parallel sessions

Several Claude sessions may share a repo. A checkout's HEAD, index and files are shared by
everything working in it, so isolate work in worktrees.

- Never switch branches in the main checkout (`git checkout <branch>`, `git switch`). Leave it on main.
- For a feature branch, create a worktree and work only there:
  `git worktree add ../<repo>-<branch> -b <branch>` (or start the session with `claude -w <name>`).
  In the new worktree, run `uv sync` and copy `.env` into it.
- Run `git status` before starting. Don't touch changes you didn't make.
- Stage explicit paths. Never `git add -A`, `git add .` or `git commit -a`.
- Only amend, rebase or force-push branches you created in this session.
- After a PR merges: `git worktree remove ../<repo>-<branch>`, then delete the local branch.
  PRs are squash-merged, so `git branch -d` won't recognise them as merged. Before `git branch -D`,
  confirm `gh pr view <branch> --json state,headRefOid` shows MERGED and a `headRefOid` equal to
  `git rev-parse <branch>` (no unpushed commits). Remote branches are auto-deleted on merge.

# Dotfiles

- This file, `~/.tmux.conf`, `~/.vimrc` and `~/.emacs.d/` are version-controlled in a **bare git repo** at `~/.dotfiles.git` with `$HOME` as work tree (remote `hedbergr/.dotfiles`). There is no `.git` dir or symlink, so a plain `git` check won't find it.
- Use `git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME <cmd>` from `~` (the `dotfiles` alias isn't available in non-interactive shells). See `~/README.md`.
- `main` requires a PR. Never check out another branch (the work tree is all of `$HOME`): commit on local `main`, push with `push origin HEAD:refs/heads/<branch>`, then `gh pr create --repo hedbergr/.dotfiles --head <branch>`. After the squash-merge, `fetch` and `reset --keep origin/main`.
