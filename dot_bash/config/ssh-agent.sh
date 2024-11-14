if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval "$(ssh-agent -s)" >/dev/null
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
