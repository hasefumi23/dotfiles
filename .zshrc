umask 002

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

#set -x DISPLAY localhost:0.0
export DOCKER_HOST=tcp://localhost:2375
export GOPATH=$HOME
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:"/mnt/c/Program Files/Oracle/VirtualBox"
export PATH=$PATH:$GOPATH/bin
export VAGRANT_PREFER_SYSTEM_BIN=0
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1
export NO_PROXY=127.0.0.1
export MANPAGER="/bin/sh -c \"col -b -x | vim -R -c 'set ft=man nolist nonu noma' -\""
export LANG=ja_JP.UTF-8
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export MANPAGER="/bin/sh -c \"col -b -x | vim -R -c 'set ft=man nolist nonu noma' -\""
export GOPATH=$HOME
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS='
  --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
  --color=fg+:#d0d0d0,bg+:#9620b3,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#ffffff
  --color=marker:#87ff00,spinner:#ae88d4,header:#87afaf
'

eval "$(starship init zsh)"

stty stop undef

### Added by Zplugin's installer
#source '/home/fumi/.zplugin/bin/zplugin.zsh'
#autoload -Uz _zplugin
#(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# Two regular plugins loaded without tracking.
#zplugin light zsh-users/zsh-autosuggestions
#zplugin light zdharma/fast-syntax-highlighting

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

bindkey -e

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoreboth

function fkill () {
  local pid=$(ps -xf | sed 1d | fzf -m | awk '{print $1}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill
  fi
}

function peco-src () {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^g' peco-src

bindkey '^[u' undo
bindkey '^[r' redo

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ap='ansible-playbook'
alias b='brew'
alias be='bundle exec'
alias bi='bundle install'
alias br='bundle exec rspec'
alias c='code-insiders'
alias cl='clip.exe'
alias d='docker'
alias e='explorer.exe .'
alias f='fisher'
alias fkill="ps aux | fzf -m | awk '{print $2}' | xargs kill"
alias frm="ls -a | fzf -m | xargs rm"
alias g='git'
alias gh="open $(git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e 's/ssh:\/\///' -e's/git@/http:\/\//' -e's/\.git\$//' | sed -E 's/(\/\/[^:]*):/\1\//')"
alias i='sudo apt install --yes'
alias l='ls -al'
alias open='explorer.exe'
alias p='pa aux'
alias p='powershell.exe'
alias rl='readlink -f'
alias v='vim'
alias vi='vim'
alias vimc='vim --clean'
alias vimr='vim -R -'

# edit
alias vimfish='vim ~/.config/fish/config.fish'
alias vimzsh='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias vimssh='vim ~/.ssh/config'
alias vimgit='vim ~/.gitconfig'
alias refish='source ~/.config/fish/config.fish'
alias rezsh='source ~/.zshrc'

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# below lines are from ZSH BOOK
setopt histignorealldups sharehistory
setopt auto_cd
setopt auto_remove_slash
setopt auto_name_dirs
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt prompt_subst
setopt extended_glob
setopt list_types no_beep
setopt always_last_prompt
setopt cdable_vars
setopt sh_word_split auto_param_keys
setopt pushd_ignore_dups
setopt share_history
setopt inc_append_history
# comment out these are to much sideeffect
# setopt auto_menu
# setopt correct rm_star_silent
# setopt sun_keyboard_hack

[ -f ~/.local/config.fish ] && source ~/.local/.zshrc
