#!/usr/bin/env bash
#
#                                        _
#    ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
#   / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
#   \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
#   |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
#       |_|
#
#   Streamlined version for local repository installation (Vim only)

set -eo pipefail

app_name="space-vim"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use current directory as space-vim home
repo_path="$CURRENT_DIR"
_update=

help() {
  cat << EOF
usage: $0 [OPTIONS]

    --help               Show this message
    --update             Update space-vim (git pull)
EOF
}

for opt in "$@"; do
  case $opt in
    --help)
      help
      exit 0
      ;;
    --update)
      cd "$repo_path" && git pull
      exit 0
      ;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done

###############################
## Basic tools
###############################
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
    msg "\33[32m[✔]\33[0m ${1}${2}"
  fi
}

error() {
  msg "\33[31m[✘]\33[0m ${1}${2}"
  exit 1
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

install_plugins() {
  vim +PlugInstall +qall
  ret="$?"
  success "Successfully installed plugins via vim-plug"
}

generate_vimrc_bundle() {
  if [ ! -f "$HOME/.vimrc.bundle" ]; then
    ln -sf "$repo_path/init.spacevim" "$HOME/.vimrc.bundle"
    ret="$?"
    success "Successfully generated .vimrc.bundle in your home directory"
  fi
}

backup() {
  if [ -e "$1" ]; then
    echo
    msg "\033[1;34m==>\033[0m Attempting to back up your original vim configuration"
    today=$(date +%Y%m%d_%s)
    mv -v "$1" "$1.$today"
    ret="$?"
    success "Your original vim configuration has been backed up"
  fi
}

check_git() {
  if ! exists "git"; then
    error "You must have 'git' installed to continue"
  fi
}

check_vim() {
  if ! exists "vim"; then
    error "You must have 'vim' installed to continue"
  fi
}

###############################
##  main
###############################
check_git
check_vim

msg "\033[1;34m==>\033[0m Installing space-vim from $repo_path"

# Backup existing config
backup "$HOME/.vimrc"

# Download vim-plug
msg "\033[1;34m==>\033[0m Trying to download vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ret="$?"
success "Successfully downloaded vim-plug"

# Create symlinks
ln -sf "$repo_path/init.vim" "$HOME/.vimrc"
generate_vimrc_bundle

# Install plugins
install_plugins

msg "\nThanks for installing \033[1;31m$app_name\033[0m. Enjoy!"
