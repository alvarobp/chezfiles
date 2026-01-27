command -v ssh-agent >/dev/null 2>&1 || return 0

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval "$(ssh-agent -s)" >/dev/null
  mkdir -p ~/.ssh
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
