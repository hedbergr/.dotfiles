# Manage dotfiles with GNU stow

* Install stow `sudo apt install stow`
* Clone this repo
* Create symbolic links:
  ``` bash
  cd ~/.dotfiles
  stow vim
  ```
* Look at home directory to show symbolic link
  ``` bash
  $ ls -la ~ | grep vimrc
  .vimrc -> .dotfiles/vim/.vimrc
  ```
