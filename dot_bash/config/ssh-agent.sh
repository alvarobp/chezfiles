# Skip if 1Password SSH agent is available (macOS or Linux)
case "$(uname)" in
  Darwin) onepassword_agent_sock="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ;;
  *)      onepassword_agent_sock="${HOME}/.1password/agent.sock" ;;
esac

if [ -S "$onepassword_agent_sock" ]; then
  return 0
fi

# Fallback: start a regular ssh-agent
command -v ssh-agent >/dev/null 2>&1 || return 0
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval "$(ssh-agent -s)" >/dev/null
  mkdir -p ~/.ssh
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
