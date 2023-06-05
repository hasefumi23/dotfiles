# 遅くなったら zprof 使って原因を特定する
# zmodload zsh/zprof && zprof
# easy way to calculate launch time
# time (zsh -i -c exit)

umask 002

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Use modern completion system
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^j^e' edit-command-line

#export DOCKER_HOST=tcp://localhost:2375
export BAT_THEME='Solarized (light)'
export EDITOR=nvim
export THOR_MERGE=nvim
export PATH=$PATH:/usr/local/go/bin
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:"/mnt/c/Program Files/Oracle/VirtualBox"
export PATH=$PATH:$HOME/.local/bin
# export PATH=$PATH:/opt/ghc/bin/
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.rbenv/bin
export VAGRANT_PREFER_SYSTEM_BIN=0
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1
export NO_PROXY=127.0.0.1
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LESS="-R"
export PAGER=less
export MANPAGER="nvim -R +MAN +'set ft=man nolist nonu noma' +'runtime ftplugin/man.vim'"
export RUBYOPT=-EUTF-8
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/*'"
export FZF_DEFAULT_OPTS='
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
  --height 100% --reverse --border
'
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/highlighters
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export LD_PRELOAD=/lib/x86_64-linux-gnu/libgcc_s.so.1
export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:~/.ghq/github.com/atcoder/ac-library"
export CPATH=${CPATH}:~/.ghq/github.com/atcoder/ac-library
export DENO_INSTALL="/home/fumi/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

which starship > /dev/null && eval "$(starship init zsh)"
which direnv > /dev/null && eval "$(direnv hook zsh)"
which kubectl > /dev/null && source <(kubectl completion zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh/scripts/pipr_hotkey.zsh ] && source ~/.zsh/scripts/pipr_hotkey.zsh

#eval "$(gh completion -s zsh)"
#eval "$(rbenv init -)"

# disable <C-s> and <C-q>
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export HISTCONTROL=ignoreboth

fpath=(~/.zsh/completions $fpath)

function gh-open () {
  wslview $(git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e 's/ssh:\/\///' -e's/git@/http:\/\//' -e's/\.git\$//' | sed -E 's/(\/\/[^:]*):/\1\//')
}

# githubにリポジトリを作り、ghqで取得、vscodeでひらく
function ghrepo () {
  gh repo create ${argv}
  ghq get git@github.com:hasefumi23/${argv[1]}.git
  cd $(ghq root)/github.com/hasefumi23/${argv[1]}
}

function gi() {
  curl -sLw n https://www.toptal.com/developers/gitignore/api/$@
}

function fcode () {
  local selected_files=$(fgit_files)
  if [ -n "${selected_files}" ]; then
    LBUFFER="code $(echo ${selected_files})"
  fi
}

function fopen () {
  local selected_files=$(fgit_files)
  if [ -n "${selected_files}" ]; then
    # 本当はLBUFFERを使いたいが、wslviewでWindows側でエラーが発生するので、直接起動する
    wslview ${selected_files}
  fi
}

function fkill () {
  local pid=$(ps -xf | sed 1d | fzf-tmux -- -m | awk '{print $1}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill
  fi
}

function fgf() {
  fzf --preview-window=right:65% --multi \
  --preview 'git diff {} '
}

function fzfp() {
  fzf --preview-window=right:65% --multi \
    --preview 'bat --style=numbers --color=always --line-range=:100 {} '
}

function fgit_files () {
  if [ "$1" = "i" ]; then
    local files=$(fd --type f --hidden --exclude .git --no-ignore)
  else
    local files=$(fd --type f --hidden --exclude .git --exclude node_modules --no-ignore)
  fi

  echo "$files" | sed 's/ /\n/g' | fzfp
}

function fssh () {
  local sshLoginHost=$(cat ~/.ssh/config | grep "^Host" | grep -v '*' | awk '{print $2}' | fzf)
  if [ "$sshLoginHost" = "" ]; then
    # ex) Ctrl-C.
    return 1
  fi
  ssh $sshLoginHost
}

function ftree () {
  tree -N -a --charset=o -f -I '.git|.idea|resolution-cache|target/streams|node_modules' | \
    fzf-tmux -- --preview '
      local target=$(echo {} | grep -o "\./.*\$" | xargs)
      if [ -d $target ]
        ls -lh $target
      else
        highlight --force=js -O ansi $target ||
        coderay $target ||
        cat $target 2> /dev/null | head -100
      fi' | \
      sed -e "s/ ->.*\$//g" | \
      tr -d '\||`| ' | \
      tr '\n' ' ' | \
      sed -e "s/--//g" | \
      xargs echo
}

function frm () {
  local selected_files=$(fgit_files i)
  if [ -n "${selected_files}" ]; then
    LBUFFER="rm $(echo ${selected_files})"
  fi
}

function fvim () {
  local selected_files=$(fgit_files)
  if [ -n "${selected_files}"  ]; then
    LBUFFER="nvim $(echo ${selected_files})"
  fi
}

function fvimi () {
  local selected_files=$(fgit_files i)
  if [ -n "${selected_files}" ]; then
    LBUFFER="nvim $(echo ${selected_files})"
  fi
}

function fpsql () {
  local psqlLoginHost=$(cat ~/.ssh/config | grep "^Host" | grep -v '*' | awk '{print $2}' | fzf-tmux)
  if [ "$psqlLoginHost" = "" ]; then
    # ex) Ctrl-C.
    return 1
  fi
  psql -h $psqlLoginHost
}

function fs () {
  local dir=$(fd --no-ignore -t d --hidden --exclude .git 2> /dev/null | fzf +m --preview 'exa -alh {}')
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

function fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function fbre () {
  local branch=$(git branch -a -vv | fzf +m)
  if [ -n "$branch" ]; then
    git checkout $(echo "$branch" | sed "s/remotes\/origin\///" | awk '{print $1}' | sed "s/.* //")
  fi
}

function zf() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
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

function mdd() {
  if [ -z ${1} ]; then
    exit 1
  fi

  mkdir "$(date +%Y-%m-%d)_${1}"
}

function ffiles() {
  local buf
  local item
  fd --hidden --exclude .git | fzf \
    --preview-window=right:65% --multi \
    --preview 'bat --style=numbers --color=always --line-range=:100 {} 2&>/dev/null || ls {}' | \
    while read item; do;
      buf="${buf} ${item}"
    done
  # バッファを入れ替える
  LBUFFER="${LBUFFER}${buf}"
  zle reset-prompt
}

function me() {
  echo "$@" >> "${MEMO_PATH}"
}

slack() {
  if [ -z "${SLACK_URL}" ]; then
    echo env SLACK_URL is neccesarry!
    return
  fi
  if [ -z "${SLACK_MENTION_USER}" ]; then
    echo env SLACK_MENTION_USER is neccesarry!
    return
  fi

  msg="${*}"
  if [ -z "${msg}" ]; then
    echo message is neccesarry!
    return
  fi

  data=$(cat << EOS
{
  "text":"${SLACK_MENTION_USER} ${msg}"
}
EOS
)

  curl -X POST -H 'Content-type: application/json' --data "${data}" "${SLACK_URL}"
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias l='exa -alF --color=auto'
alias ll='exa -alF --color=auto'
alias la='exa -a --color=auto'

#alias -g open="powershell.exe /c start"
alias ap='ansible-playbook'
alias b='brew'
alias be='bundle exec'
alias ber='bundle exec rspec'
alias bi='bundle install'
alias c='code'
alias cdu='cd-gitroot'
alias cg='cargo'
alias ci='code-insiders'
alias cl='win32yank.exe -i'
alias d='docker'
alias dc='docker-compose'
alias dotp="(cd /mnt/c/.ghq/github.com/hasefumi23/dotfiles && git pull && cd -)"
alias e='explorer.exe'
alias fdf='git diff --ignore-space-change --no-index $(fd | fgit_files) $(fd | fgit_files)'
alias -g fzf-tmux='fzf-tmux -p 80%'
alias g='git'
alias ginit='git init && git commit --allow-empty -m "init"'
alias gg='g++ -std=c++17 -O2'
alias gd='go doc -all $(ghq list | fzf) | less'
alias gr='go run'
alias h='runhaskell'
alias i='sudo apt update && sudo apt install --yes'
alias k='kubectl' && complete -F __start_kubectl k
alias lg='lazygit'
alias m='cat $MEMO_PATH'
alias md='mkdir -p'
alias mux='tmuxinator'
alias o='wslview'
alias open='wslview'
alias p='powershell.exe'
alias rl='readlink -f'
alias root='cd $(git rev-parse --show-toplevel)'
alias t='tmux'
alias ta='tmux attach || tmux'
alias tf='terraform'
alias tigs="tig status"
alias to='touch'
alias tl='tldr'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vimc='vim --clean'
alias vimr='vim -R -'
alias view='vim -R'
alias y='yarn'
alias w='wrangler'

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
alias vimnavi='vim ~/.local/share/navi/cheats/denisidoro__cheats/misc__misc.cheat'
alias vimmemo='vim $MEMO_PATH'
alias vimhosts='vim /etc/hosts'
alias refish='source ~/.config/fish/config.fish'
alias rezsh='source ~/.zshrc'

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
setopt auto_pushd
setopt pushd_ignore_dups
setopt sh_word_split auto_param_keys
setopt share_history
# comment out these are to much sideeffect
# setopt auto_menu
# setopt correct rm_star_silent
# setopt sun_keyboard_hack

# ZLE
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

zle -N fcode
zle -N fopen
zle -N fssh
zle -N fvim
zle -N fs
zle -N peco-src
zle -N ffiles
zle -N fzf-history-widget

bindkey '^o' fopen
bindkey '^s' fssh
bindkey '^v' fvim
bindkey '^g' peco-src
bindkey '^]u' undo
bindkey '^]r' redo
bindkey '^U' backward-kill-line
bindkey '^t' ffiles
bindkey -v

bindkey -M viins '^o' fopen
bindkey -M viins '^s' fssh
bindkey -M viins '^v' fvim
bindkey -M viins '^g' peco-src
bindkey -M viins '^r' fzf-history-widget
bindkey -M viins '^t' ffiles

bindkey -M vicmd 'g' peco-src
bindkey -M vicmd 'r' fzf-history-widget

autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

autoload -Uz surround
zle -N delete-surround surround
zle -N change-surround surround
zle -N add-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

[ -f ~/.local/.zshrc ] && source ~/.local/.zshrc

### Added by zinit's installer
[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ] && \
  # zinitがなかったらインストールする
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for zsh-users/zsh-autosuggestions \
  mollifier/cd-gitroot \
  zdharma/fast-syntax-highlighting \
  rupa/z \
  changyuheng/fz \
  zsh-users/zsh-completions
### End of Zinit's installer chunk

# 遅くなったら zprof 使って原因を特定する
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

