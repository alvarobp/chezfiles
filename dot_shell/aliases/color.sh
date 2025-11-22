# Color support for ls
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: use -G flag for colored output
    alias ls='ls -G'
    export CLICOLOR=1
    export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
else
    # Linux: use --color flag and dircolors if available
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

    if command -v dircolors &>/dev/null; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'
    fi
fi

# Grep color support (works on both macOS and Linux)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
