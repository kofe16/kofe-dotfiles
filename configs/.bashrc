#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
# ~/.bashrc o ~/.zshrc
# Solo mostrar fastfetch si es terminal interactiva
if [[ $- == *i* ]]; then
    fastfetch
fi
