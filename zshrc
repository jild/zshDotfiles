# zshDotfiles github directory
zshDotfilePath=~/gitTest/zshDotfiles

cd $zshDotfilePath

# pwd

# relevant git submodule load
## Load  z  for  fast  access  of  recent  folders
# ./z/z.sh  # the same as ./ ?
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
antigen theme jdavis/zsh-files themes/jdavis
# problem antigen theme forces me to press enter to see prompt
# antigen theme bira # pure is nice too
# antigen theme pure
antigen bundle colorize #cat syn highlighting (funzt nicht?)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle vi-mode
antigen bundle tarruda/zsh-autosuggestions
antigen bundle junegunn/fzf.git
# the next line is now in plugins=(... fzf-zsh ...)
antigen bundle Treri/fzf-zsh # used to make fzf work with zsh autosuggestions
# plugin made unnecessary:
# use fuzzy file finder with <ctrl>-T/R or <alt>-C
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# muss oberste Zeile sein, da PATH hier überschrieben wird
# wenn andere die nun erweitern wollen, muss das danach geschehen
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Plattformen für mobile Systeme
# source /home/jakob/public/mobile-project/mobile-project-shell-config-cochlovius.zsh

# Export section
export github_user=jjjeykey # used for dotfiles deployment github app
export PATH=$PATH:"$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

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
bindkey '^R' history-incremental-search-backward

export KEYTIMEOUT=1 # kills the lag, may cause probs


# Start Tmux either with one terminal and attack to it, or normal
# if this fails remove -t option restart terminal and add it again
#if command -v tmux>/dev/null; then
    #[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec $(tmux attach -t base || tmux new -s base)
#fi
if [ "$TMUX" = "" ]; then tmux; fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, compleat, z)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias up="cd .."
alias cl="clear"
alias :q="exit"
alias vi="nvim"
alias vim="nvim"
alias e="emacs -nm"
alias quit="exit"

# my files
alias todo

# Aliases for xclip:
# http://stackoverflow.com/questions/5130968/how-can-i-copy-the-output-of-a-command-directly-into-my-clipboard
alias "c=xclip"
alias "v=xclip -o"
   
#   cat   with   syn   highlighting
alias ccat='pygmentize -g -O style=colorful,linenos=1'

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

# for the next one you have to read readme of fzf-zsh and then move the fzf
# folder to the antigen repos (see error when sourcing this file)
# autosuggest-toggle # toggle the suggestions # deprecated???
bindkey '^f' vi-end-of-line # for the suggestions
#antigen bundle https://github.com/zsh-users/zsh-autosuggestions.git
#bindkey <enter> vi-forward-blank-word
#antigen bundle colored-man-page
#antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
#antigen theme spaceship #frisk #flazz #bira #amuse #af-magic #fishy
# antigen theme fishy #https://github.com/denysdovhan/spaceship-zsh-theme spaceship



####
# xcape to map functionality to shift_l = esc, ctrl = ctrl + o (in vim similar
# to esc for one command) and space = strg (see below)
####

# xcape -e 'Shift_L=Escape' # put this in brackets for mapping like explained above ;Control_L=Control_L|O'

# Map an unused modifier's keysym to the spacebar's keycode and make it a
# control modifier. It needs to be an existing key so that emacs won't
# spazz out when you press it. Hyper_L is a good candidate.
#spare_modifier="Hyper_L"
#xmodmap -e "keycode 65 = $spare_modifier"
#xmodmap -e "remove mod4 = $spare_modifier" # hyper_l is mod4 by default
#xmodmap -e "add Control = $spare_modifier"
#
## Map space to an unused keycode (to keep it around for xcape to
## use).
#xmodmap -e "keycode any = space"
#
## Finally use xcape to cause the space bar to generate a space when tapped.


# check if shell is interactive shell (solution when scping to... dunno)http://askubuntu.com/questions/591937/no-value-for-term-and-no-t-specified
# if [[ $- == *i* ]]; then
  # fgRed=$(tput setaf 1)     ; fgGreen=$(tput setaf 2)  ; fgBlue=$(tput setaf 4)
  # fgMagenta=$(tput setaf 5) ; fgYellow=$(tput setaf 3) ; fgCyan=$(tput setaf 6)
  # fgWhite=$(tput setaf 7)   ; fgBlack=$(tput setaf 0)
  # bgRed=$(tput setab 1)     ; bgGreen=$(tput setab 2)  ; bgBlue=$(tput setab 4)
  # bgMagenta=$(tput setab 5) ; bgYellow=$(tput setab 3) ; bgCyan=$(tput setab 6)
  # bgWhite=$(tput setab 7)   ; bgBlack=$(tput setab 0)
# fi


# OTHER #

# bindkey "^r" history-search-backward

# Auto ls after cd
# http://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
# function chpwd() {
  # emulate -L zsh
  # ls -a
# }

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="bullet-train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


# 'antigen theme' forces me to press enter (bug?) doesnt work (delete me)
# echo generates implicit newline
# see: http://stackoverflow.com/questions/6264596/simulating-enter-keypress-in-bash-script
# echo 
