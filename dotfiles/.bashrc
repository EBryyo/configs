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

export EDITOR=nvim
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

#wallpaper
feh --bg-fill "/home/elena.souvay/afs/bg/howtoleavetown.png"
alias hervot='/home/elena.souvay/afs/.push.sh'

#neovim install
nix profile install nixpkgs\#neovim
#neovim plug install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#neofetch install
nix profile install nixpkgs#neofetch
#asciinema install
nix profile install nixpkgs#asciinema
cp afs/clang-format .clang-format

#aliases
alias vim='nvim'
alias cls='clear'
alias ls='ls --color=auto'
alias grep='grep --color -n'
alias lsa='ls -a'
alias macron='sudo'
alias lock='i3lock -i /home/elena.souvay/afs/bg/bingus.png'
PS1='[\u@\h \W]\$'


#git aliases

alias pt='git push --follow-tags'

commit() { #commit function
    if [ "$#" = "1" ]
    then
        git add .
        git commit -m "$1"
    else
        echo 'commit: only 1 parameter as argument'
    fi
}

tag() { #tag function
    if [ "$#" = "2" ]
    then
        git add .
        git commit -m "$1"
        git tag -ma "$2"-`date | sed -e 's/[^a-zA-Z0-9]/-/g'`
    else
        echo 'tag: only 2 parameters as arguments'
    fi
}

export -f commit
export -f tag

#piscine toolkit

init() { #create makefile with tags and
    rm main.c
    tags=""
    for tag in "$@";
    do
        if [ $tag != "$1" ]
        then
            tags+=$tag'.c '
            headername=$tag'.h'
            filename=$tag'.c'
            touch ${headername}
            touch ${filename}
            echo '#ifndef '${tag^^}'_H' > ${headername}
            echo '#define '${tag^^}'_H' >> ${headername}
            echo '' >> ${headername}
            echo '#endif' >> ${headername}
            echo '#include"'${headername}'"' >> main.c
            echo '#include"'${headername}'"' >> ${filename}
        fi
    done
    touch Makefile
    touch main.c
    echo '' >> main.c
    echo 'int main(int argc, char **argv){ return 0; }' >> main.c
    echo 'main: main.c '${tags} > Makefile
    echo '  gcc -o main main.c '${tags} "$1" >> Makefile
    chmod +rw *
}

export -f init

#finish
clear
neofetch
