alias g='git'
alias ga='git add'
__git_complete ga _git_add
alias gam='git amend'
__git_complete gam _git_commit
alias gci='git ci'
__git_complete gci _git_commit
alias gco='git checkout'
__git_complete gco _git_checkout
alias gcp='git cherry-pick'
__git_complete gcp _git_cherry_pick
alias gdc='git dc'
__git_complete gdc _git_diff
alias gdi='git di'
__git_complete gdi _git_diff
alias gf="git log --oneline | fzf --preview 'git show --color=always {+1}' | awk '{print $1}' | xargs -I {} git show {}"
__git_complete gf _git_log
alias gfapu='git fapu'
alias gl='git l'
__git_complete gl _git_log
alias gla='git la'
__git_complete gla _git_log
alias gpuf='git push --force-with-lease'
__git_complete gpuf _git_push
alias gr='git rebase'
__git_complete gr _git_rebase
alias grb='git branch -D'
__git_complete grb _git_branch
alias grc='git rebase --continue'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gri='git rebase -i'
__git_complete gri _git_rebase
alias gst='git st'
__git_complete gst _git_status

alias ggpull='git pull origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'

alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'

function git_current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function gc {
  git commit -m "$*"
}

function gcn {
  git commit -n -m "$*"
}
