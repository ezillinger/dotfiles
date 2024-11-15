#! /bin/bash

#vi -> vim
alias vi="vim"

#git
alias gs="git status"
alias gapi="git add --patch --interactive"
alias gsu="git submodule update --init --recursive"

unalias ll
alias ll="ls -lah"

alias tm="tmux attach || tmux new"
alias gpristine="git reset --hard && git clean -dfx"
