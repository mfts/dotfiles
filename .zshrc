# Aliases
alias ll='ls -la'

# remove the need for 'cd' for change directory
setopt autocd

# Autocompletion
autoload -U colors && colors
setopt prompt_subst

# Get branch and open commits in prompt
function git-dirty() {
    [[ $(git status 2>/dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1$(git-dirty))/"
}

# Color for the zsh prompt (including git function)
PROMPT='%F{190}%~%b%F{021}$(parse_git_branch)%f $ '

test -d "$HOME/.tea" && source <("$HOME/.tea/tea.xyz/v*/bin/tea" --magic=zsh --silent)