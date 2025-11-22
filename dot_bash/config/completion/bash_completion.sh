# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    # Check for macOS Homebrew bash completion (Apple Silicon)
    if [ -f /opt/homebrew/etc/bash_completion ]; then
        . /opt/homebrew/etc/bash_completion
    # Check for macOS Homebrew bash completion (Intel)
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    # Check for Linux bash completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
