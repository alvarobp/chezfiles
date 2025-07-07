if command -v eza &> /dev/null; then
 alias ls='eza -lh --group-directories-first --icons=auto'
 alias lt='eza --tree --level=2 --long --icons --git'
 alias lsa='ls -a'
 alias lta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
