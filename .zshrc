# Aliases
alias ll='ls -la'
alias virtphp='virtphp.phar'
alias vsc='code .'

# remove the need for 'cd' for change directory
setopt autocd

# Autocompletion
autoload -Uz compinit && compinit
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

autoload -U colors && colors
setopt prompt_subst

# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:$PATH

# Get branch and open commits in prompt
function git-dirty() {
    [[ $(git status 2>/dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1$(git-dirty))/"
}

# Color for the zsh prompt (including git function)
PROMPT='%F{057}%n%f@%F{118}%m:%B%F{190}%~%b%F{021}$(parse_git_branch)%f $ '

# Python VirtualEnvs Wrapper
export VIRTUALENVWRAPPER_PYTHON=/Users/mfts/.pyenv/shims/python
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Ruby Version Manager "rnebv"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Python Version Manager "pyenv"
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Node Version Manager "nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"