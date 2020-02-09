# 遅くなったら zprof 使って原因を特定する
# zmodload zsh/zprof && zprof
# easy way to calculate launch time
# time (zsh -i -c exit)

umask 002

#eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"; export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"; export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"; export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"; export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"; export INFOPATH="/home/linuxbrew/.linuxbrew/share/info${INFOPATH+:$INFOPATH}";

eval "$(starship init zsh)"

#export DOCKER_HOST=tcp://localhost:2375
export EDITOR=vim
export THOR_MERGE=vim
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:"/mnt/c/Program Files/Oracle/VirtualBox"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/opt/ghc/bin/
export VAGRANT_PREFER_SYSTEM_BIN=0
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1
export NO_PROXY=127.0.0.1
export LANG=ja_JP.UTF-8
export LESS="-R"
export MANPAGER="/bin/zsh -c \"col -b -x | view -c 'set ft=man nolist nonu noma' -\""
export RUBYOPT=-EUTF-8
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS='
  --color=fg+:#d0d0d0,bg+:#9620b3,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#ffffff
  --color=marker:#87ff00,spinner:#ae88d4,header:#87afaf
  --height 100% --reverse --border
'
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/highlighters
stty stop undef

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

function fhistory () {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

function fcode () {
  local selected_files=$(fgit_files)
  if [ -n "$selected_files" ]; then
    code $selected_files
  fi
}

function fkill () {
  local pid=$(ps -xf | sed 1d | fzf -m | awk '{print $1}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill
  fi
}

function fgit_files () {
  local files=$(git ls-files)
  echo "$files" | sed 's/ /\n/g' |
    fzf --preview '
      highlight -O ansi {} ||
      coderay {} ||
      rougify {} ||
      cat {} 2> /dev/null | head -500
    '
}

function fssh () {
  local sshLoginHost=$(cat ~/.ssh/config | grep "^Host" | grep -v '*' | awk '{print $2}' | fzf)
  if [ "$sshLoginHost" = "" ]; then
    # ex) Ctrl-C.
    return 1
  fi
  ssh $sshLoginHost
}
zle -N fssh
bindkey '^js' fssh

function ftree () {
  tree -N -a --charset=o -f -I '.git|.idea|resolution-cache|target/streams|node_modules' | \
    fzf --preview '
      local target=$(echo {} | grep -o "\./.*\$" | xargs)
      if [ -d $target ]
        ls -lh $target
      else
        highlight -O ansi $target ||
        coderay $target ||
        cat $target 2> /dev/null | head -100
      fi' | \
      sed -e "s/ ->.*\$//g" | \
      tr -d '\||`| ' | \
      tr '\n' ' ' | \
      sed -e "s/--//g" | \
      xargs echo
}

function vim_from_tree () {
  local selected_file=$(ftree)
  if [ -n "$selected_file" ]; then
    vim "$selected_file"
  fi
}

function vim_from_git_files () {
  local selected_files=$(fgit_files)
  if [ -n "$selected_files" ]; then
    vim $selected_files
  fi
}

function fvim () {
  if git rev-parse 2> /dev/null; then
    vim_from_git_files
  else
    vim_from_tree
  fi
}
zle -N fvim
bindkey '^jv' fvim

function fpsql () {
  local psqlLoginHost=$(cat ~/.ssh/config | grep "^Host" | grep -v '*' | awk '{print $2}' | fzf)
  if [ "$psqlLoginHost" = "" ]; then
    # ex) Ctrl-C.
    return 1
  fi
  psql -h $psqlLoginHost
}

function fcd () {
  local dir=$(fd -t d 2> /dev/null | fzf +m --preview 'exa -alh {}')
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}
zle -N fcd
bindkey '^jd' fcd

function fbr () {
  local branch=$(git branch -a -vv | fzf +m)
  if [ -n "$branch" ]; then
    git checkout $(echo "$branch" | sed "s/remotes\/origin\///" | awk '{print $1}' | sed "s/.* //")
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

function chpwd() {
  if [ `ls -Al | wc -l` -eq 0 ]; then
    echo "\n\nempty directory";
  else
    ls
  fi
}

# Tmux + SSH
function ssh_tmux() {
  tmux set-option default-terminal "screen" \; \
    new-window -n $(echo $@ | perl -ple 's/(^|\s)-[^\s] *[^\s]+//g' | cut -d" " -f2 ) "exec ssh $(echo $@)" \; \
    run-shell        "[ ! -d $HOME/.tmuxlog/#W/$(date +%Y-%m/%d)  ] && mkdir -p $HOME/.tmuxlog/#W/$(date +%Y-%m/%d)" \; \
    pipe-pane        "cat >> $HOME/.tmuxlog/#W/$(date +%Y-%m/%d/%H%M%S.log)" \; \
    display-message  "Started logging to $HOME/.tmuxlog/#W/$(date +%Y-%m/%d/%H%M%S.log)"
}

if [[ $TERM = screen  ]] || [[ $TERM = screen-256color  ]] ; then
  alias ssh=ssh_tmux
fi

bindkey '^[u' undo
bindkey '^[r' redo
bindkey '^U' backward-kill-line

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias l='exa -alF --color=auto'
alias ll='exa -alF --color=auto'
alias la='exa -a --color=auto'

alias ap='ansible-playbook'
alias b='brew'
alias be='bundle exec'
alias bi='bundle install'
alias ber='bundle exec rspec'
alias c='code'
alias ci='code-insiders'
alias cdu='cd-gitroot'
alias cl='clip.exe'
alias d='docker'
alias e='explorer.exe .'
alias -g f='| fzf'
alias fkill="ps aux | fzf -m | awk '{print $2}' | xargs kill"
alias frm="ls -a | fzf -m | xargs rm"
alias g='git'
#alias gh="open $(git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e 's/ssh:\/\///' -e's/git@/http:\/\//' -e's/\.git\$//' | sed -E 's/(\/\/[^:]*):/\1\//')"
alias h='runhaskell'
alias gr='go run'
alias gd='go doc -all $(ghq list | fzf) | less'
alias i='sudo apt install --yes'
alias m='cat $MEMO_PATH'
alias md='mkdir -p'
alias open='explorer.exe'
alias p='powershell.exe'
alias rl='readlink -f'
alias t='tmux'
alias tl='tldr'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vimc='vim --clean'
alias vimr='vim -R -'

# edit
alias vimfish='vim ~/.config/fish/config.fish'
alias vimzsh='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias vimssh='vim ~/.ssh/config'
alias vimstar='vim ~/.config/starship.toml'
alias vimgit='vim ~/.gitconfig'
alias vimtmux='vim ~/.tmux.conf'
alias vimdein='vim ~/.vim/rc/dein.toml'
alias vimdeinl='vim ~/.vim/rc/lazy_dein.toml'
alias vimmemo='vim $MEMO_PATH'
alias refish='source ~/.config/fish/config.fish'
alias rezsh='source ~/.zshrc'

# Use modern completion system
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
eval "$(dircolors -b)"
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
setopt always_last_prompt
setopt auto_cd
setopt auto_name_dirs
setopt auto_remove_slash
setopt cdable_vars
setopt extended_glob
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt histignorealldups 
setopt inc_append_history
setopt list_types no_beep
setopt prompt_subst
setopt pushd_ignore_dups
setopt sh_word_split auto_param_keys
setopt share_history
setopt sharehistory
# comment out these are to much sideeffect
# setopt auto_menu
# setopt correct rm_star_silent
# setopt sun_keyboard_hack

[ -f ~/.local/.zshrc ] && source ~/.local/.zshrc

# Generated by `eval "$(stack --bash-completion-script stack)"` command.
#_stack()
#{
#    local CMDLINE
#    local IFS=$'\n'
#    CMDLINE=(--bash-completion-index $COMP_CWORD)
#
#    for arg in ${COMP_WORDS[@]}; do
#        CMDLINE=(${CMDLINE[@]} --bash-completion-word $arg)
#    done
#
#    COMPREPLY=( $(stack "${CMDLINE[@]}") )
#}

#complete -o filenames -F _stack stack

### Added by Zplugin's installer
source '/home/fumi/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin light zsh-users/zsh-autosuggestions
zplugin light rupa/z
zplugin light mollifier/cd-gitroot
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait'!0' zplugin load zsh-users/zsh-completions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# OPAM configuration
#. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# 遅くなったら zprof 使って原因を特定する
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

