# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d ~/afs/bin ] ; then
	export PATH=~/afs/bin:$PATH
fi

if [ -d ~/.local/bin ] ; then
	export PATH=~/.local/bin:$PATH
fi

export LANG=en_US.utf8
export NNTPSERVER="news.epita.fr"

export EDITOR=vim
#export EDITOR=emacs

# Color support for less
#export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
#export LESS_TERMCAP_me=$'\E[0m'           # end mode
#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'           # end underline
#export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

setxkbmap -option ctrl:nocaps

# aliases
alias vim='nvim'
alias cls='clear'
alias ls='ls --color=auto'
alias grep='grep --color -n'
alias lsa='ls -a'
alias macron='sudo'
alias lock='i3lock -i /home/elena.souvay/afs/bg/bingus.png'
PS1='[\u@\h \W]\$'

#wallpaper
feh --bg-fill "/home/elena.souvay/afs/bg/howtoleavetown.png"
alias hervot='/home/elena.souvay/afs/.push.sh'

#neovim install
nix profile install nixpkgs\#neovim
#neovim plug install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
clear
