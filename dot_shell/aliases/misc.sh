which batcat &> /dev/null && alias bat='batcat'
alias ccd='cd $HOME/code'
alias curlo='curl -O'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias n='nvim'
alias open='xdg-open'
which xclip &> /dev/null && alias pcopy='xclip -selection clipboard'
alias rssh='rsync -avvurP -e ssh --delete '
alias rshell='exec $SHELL' # reload shell
alias trc='truncate -s0'
alias wgetn='wget --no-check-certificate '
