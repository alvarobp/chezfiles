if which batcat &> /dev/null; then
  alias bat='batcat'
  alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
else
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi

# Only create pbcopy/pbpaste aliases on Linux (macOS has native commands)
if [[ "$(uname -s)" == "Linux" ]] && which xclip &> /dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

alias ccd='cd $HOME/code'
alias curlo='curl -O'
alias gf="git log --oneline | fzf --toggle-preview-wrap --preview 'git show --color=always {+1}' | awk '{print $1}' | xargs -I {} git show {}"
alias lg="lazygit"
alias n='nvim'
alias open='xdg-open'
alias rssh='rsync -avvurP -e ssh --delete '
alias rshell='exec $SHELL' # reload shell
alias trc='truncate -s0'
alias wgetn='wget --no-check-certificate '
