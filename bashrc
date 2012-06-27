esc="\033"
clear="\[$esc[0;00m\]"
white="\[$esc[0;01m\]"
black="\[$esc[0;30m\]"

red1="\[$esc[0;31m\]"
red2="\[$esc[1;31m\]"
green1="\[$esc[0;32m\]"
green2="\[$esc[1;32m\]"
yellow1="\[$esc[0;33m\]"
yellow2="\[$esc[1;33m\]"
blue1="\[$esc[0;34m\]"
blue2="\[$esc[1;34m\]"
purple1="\[$esc[0;35m\]"
purple2="\[$esc[1;35m\]"
grey1="\[$esc[0;36m\]"
grey2="\[$esc[1;36m\]"
grey3="\[$esc[0;37m\]"
grey4="\[$esc[1;37m\]"


# Get current git branch if any
function current_branch {
    BRANCH=$(git branch 2> /dev/null | sed -n 's/^* \(.*\)/\1/p')
    if [ ! -z "${BRANCH}" ]; then
        echo "${BRANCH} "
    fi
}

# OS specific
case $(uname) in
    Darwin)
        export CLICOLOR=1
    ;;
    Linux)
        eval "`dircolors`"
        export LS_OPTIONS='--color=auto'
    ;;
    *)
esac

# Bash aliases
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color --exclude="*.pyc"'

# Environment flags
PS1="$green1\u@\h $blue1\w $red1\`current_branch\`$purple1\$ $clear"
PATH=$PATH:~/bin
EDITOR="vim"
export PS1 PATH EDITOR

# Git alias
alias commit='git commit'
alias status='git status --ignore-submodules'
alias diff='git diff --ignore-submodules --color'
alias add='git add'
alias push='git push origin $(current_branch)'
alias log="git log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) <%an>%Creset' --abbrev-commit --color"
