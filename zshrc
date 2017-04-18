# muss oberste Zeile sein, da PATH hier überschrieben wird
# wenn andere die nun erweitern wollen, muss das danach geschehen
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# latex distribution
# make sure to uninstall all texlive distributions installed with package
# manager. Test if correct path is set with 'kpsewhich latex.ltx'
# kpsewhich is in texlive path/bin
# check the following paths for correctness
export PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2016/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2016/texmf-dist/doc/info:$INFOPATH
unset TEXINPUTS
unset TEXMFCONFIG

# Plattformen für mobile Systeme
# source /home/jakob/public/mobile-project/mobile-project-shell-config-cochlovius.zsh

# Export section
export github_user=jjjeykey # used for dotfiles deployment github app
export PATH=$PATH:"$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export VISUAL="vi"
export EDITOR="vi"

# zshDotfiles github directory
zshDotfilePath=/home/mm/mygit/zshDotfiles
cd $zshDotfilePath

# relevant git submodule load
## Load antigen
## Path to your oh-my-zsh installation.
export ZSH=./oh-my-zsh
source ./oh-my-zsh/oh-my-zsh.sh
# source /usr/local/share/compleat-1.0/compleat_setup
## Load command line completions with tab like -l -s etc. for ls 
# bash compatibility mode for "compleat" a plugin for auto completition
autoload -Uz compinit bashcompinit
compinit
bashcompinit
source ./compleat/compleat_setup

# this must be the last submodule at least before oh-my-zsh
source ./antigen/antigen.zsh

cd - # return to original dir after submodule load (see cd above)

# Antigen
antigen use oh-my-zsh
# problem antigen theme forces me to press enter to see prompt
antigen theme bira
antigen bundle colorize #cat syn highlighting (funzt nicht?)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle vi-mode
antigen bundle tarruda/zsh-autosuggestions
antigen bundle junegunn/fzf.git
antigen bundle Treri/fzf-zsh # used to make fzf work with zsh autosuggestions
antigen bundle z
antigen bundle colored-man-pages
antigen bundle jira
# antigen bundle extract
antigen bundle Pitometsu/zsh-github # copy of oh-my-zsh, hub is the shortcut command \
  # needs hub installed (and ruby?)
#Todo: jira plus, github plugin

#DISABLE SCROLL LOCK, does not work?
#(http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator)
stty -ixon

# should add fuzzy completion to zsh
# http://superuser.com/questions/415650/does-a-fuzzy-matching-mode-exist-for-the-zsh-shell
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'

# use vi mode (access via esc)
bindkey -v # use vi mod
# make ctrl-r work in vi mode
#bindkey '^R' history-incremental-search-backward

export KEYTIMEOUT=1 # kills the lag, may cause probs

# start tmux
if [ "$TMUX" = "" ]; then tmux; fi

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias up="cd .."
alias cl="clear"
alias :q="exit"
alias q="exit"
alias e="emacs -nm"
alias quit="exit"
alias todo="vi ~/todo.md"
alias skripte="okular ~/documents/skripte/* &"
alias buildDataAgent="cd ~/build/dataAgent/ && qmake ~/documents/dataAgent/trunk/Implementation/Source/ptxproj/src/DataAgent.pro && make"
alias buildDataAgentUnitTestsAndRun="cd ~/build/dataAgentUnitTests/ && qmake ~/documents/dataAgent/trunk/Implementation/Source/ptxproj/tests/unit/DataAgent_UnitTests.pro && make && ./unittests"
alias copyImplementationToUbuntu="rsync -avpPh --delete -e ssh ~/documents/dataAgent/trunk/Implementation/ ubuntu0815:~/documents/workspace/dataAgent"
alias fzf="[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh"
alias buildmodul="cd ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/tools && ./build.sh && cd ../build"
alias runmodul="cd ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/build && ./samples/smallHello2/smallHello_sample2 ../samples/smallHello2/src/smallHello2.json"
alias gdbmodul="cd ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/build && gdb ./samples/smallHello2/smallHello_sample2"

Runmodul() {
  #cd ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/tools && ./build.sh && cd ../build;
  echo "cd ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/build && ./samples/$1/${1/Hello/Hello_sample} ../samples/$1/src/$1.json;"
  cd ~/programme/azure-iot-gateway-sdk/azure-iot-gateway-sdk/build && ./samples/$1/${1/Hello/Hello_sample} ../samples/$1/src/$1.json
}

# Aliases for xclip:
# http://stackoverflow.com/questions/5130968/how-can-i-copy-the-output-of-a-command-directly-into-my-clipboard
alias "c=xclip"
alias "v=xclip -o"
   
# mkdir, cd into it
mkcd () {
  mkdir -p "$*"
  cd "$*"
}

# quickly open file for editing
choose () {
    local PS3="Choose a file to edit: "
    select opt in $(locate "$1") quit
    do
        if [[ $opt = "quit" ]]
        then
            break
        fi
        ${EDITOR:-vi} "$opt"
    done
  }

# Todo: quickly open directory of file

bindkey '^ ' vi-end-of-line  # for the suggestions
bindkey '^f' vi-forward-word # for the suggestions
#bindkey '^r' fzf


