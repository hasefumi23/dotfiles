umask 002
set -gx fish_user_paths $HOME/.linuxbrew/bin $fish_user_paths
set -g fish_user_paths "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
#set -g fish_user_paths "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths;
set -x PATH "/home/linuxbrew/.linuxbrew/bin" $PATH
set -x PATH "/home/linuxbrew/.linuxbrew/sbin" $PATH
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH;

set -x DISPLAY localhost:0.0
set -x DOCKER_HOST tcp://localhost:2375
set -x GOPATH $HOME
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
set -x JRE_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH "/mnt/c/Program Files/Oracle/VirtualBox" $PATH
set -x PATH $GOPATH/bin $PATH
set -x VAGRANT_PREFER_SYSTEM_BIN 0
set -x VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1
set -gx MANPAGER 'vim -c MANPAGER -'
set -gx LANG ja_JP.UTF-8
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -x FZF_DEFAULT_OPTS '
  --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
  --color=fg+:#d0d0d0,bg+:#9620b3,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#ffffff
  --color=marker:#87ff00,spinner:#ae88d4,header:#87afaf
'

rbenv init - | source
status --is-interactive; and source (anyenv init -|psub)
# status --is-interactive; and source (anyenv init -|psub)

alias i='sudo apt install --yes'
status --is-interactive; and source (anyenv init -|psub)

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls
alias ll='ls -alFh'

# tool
alias ap='ansible-playbook'
alias b='brew'
alias c='code'
alias clip='clip.exe'
alias d='docker'
alias open='explorer.exe'
alias e='explorer.exe .'
alias f='fisher'
alias g='git'
alias l='ls -al'
alias p='pa aux'
alias v='vim'
alias vi='vim'
alias vimc='vim --clean'
alias vimr='vim -R -'
alias gh="open (git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e 's/ssh:\/\///' -e's/git@/http:\/\//' -e's/\.git\$//' | sed -E 's/(\/\/[^:]*):/\1\//')"
alias p='powershell.exe'
alias rl='readlink -f'
alias fkill="ps aux | fzf -m | awk '{print $2}' | xargs kill"
alias frm="ls -a | fzf -m | xargs rm"
alias i='sudo apt install --yes'

# ruby
alias be='bundle exec'
alias bi='bundle install'
alias br='bundle exec rspec'

# python
alias py='python3'

# edit
alias vimfish='vim ~/.config/fish/config.fish'
alias vimrc='vim ~/.vimrc'
alias vimssh='vim ~/.ssh/config'
alias vimgit='vim ~/.gitconfig'
alias refish='source ~/.config/fish/config.fish'

function fzf_select_history
  history|fzf|read slct
  if [ $slct ]
      commandline $slct
  else
      commandline ''
  end
end

function fish_user_key_bindings
    bind \cr 'fzf_select_history (commandline -b)'
end

if test -e ~/.local/config.fish
  source ~/.local/config.fish
end

function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge ^ /dev/null
  end
end

function fssh
  set -l sshLoginHost (cat ~/.ssh/config | grep "^Host" | grep -v '*' | awk '{print $2}' | fzf)
  if [ "$sshLoginHost" = "" ]
    # ex) Ctrl-C.
    return 1
  end
  ssh $sshLoginHost
end

function fpsql
  set -l psqlLoginHost (cat ~/.ssh/config | grep "^Host" | grep -v '*' | awk '{print $2}' | fzf)
  if [ "$psqlLoginHost" = "" ]
    # ex) Ctrl-C.
    return 1
  end
  psql -h $psqlLoginHost
end

function ftree
  tree -N -a --charset=o -f -I '.git|.idea|resolution-cache|target/streams|node_modules' | \
    fzf --preview '
      set target (echo {} | grep -o "\./.*\$" | xargs)
      if [ -d $target ]
        ls -lh $target
      else
        highlight -O ansi $target ||
        coderay $target ||
        cat $target 2> /dev/null | head -100
      end' | \
      sed -e "s/ ->.*\$//g" | \
      tr -d '\||`| ' | \
      tr '\n' ' ' | \
      sed -e "s/--//g" | \
      xargs echo
end

function vim_from_tree
  set selected_file (ftree)
  if [ -n "$selected_file" ]
    vim "$selected_file"
  end
end

function vim_from_git_files
  set selected_files (fzf_git_files)
  if [ -n "$selected_files" ]
    vim $selected_files
  end
end

function fzf_git_files
  set files (git ls-files)
  echo "$files" | sed 's/ /\n/g' |
    fzf --preview '
      highlight -O ansi {} ||
      coderay {} ||
      rougify {} ||
      cat {} 2> /dev/null | head -500
    '
end

function fvim
  if git rev-parse 2> /dev/null
    vim_from_git_files
  else
    vim_from_tree
  end
end

function fcode
  set selected_files (fzf_git_files)
  if [ -n "$selected_files" ]
    code-insiders $selected_files
  end
end

function fcd
  set dir (fd -t d 2> /dev/null | fzf +m --preview 'exa -alh {}')
  if [ -n "$dir" ]
    cd "$dir"
  end
end

function fish_user_key_bindings
  bind \cr 'fzf_select_history (commandline -b)'
  bind \c] 'fvim'
  bind \ct 'tig'
end

function fbr
  set branch (git branch -a -vv | fzf +m)
  git checkout (echo "$branch" | sed "s/remotes\/origin\///" | awk '{print $1}' | sed "s/.* //")
end

function fkill
  set pid (ps -xf | sed 1d | fzf -m | awk '{print $1}')

  if [ "x$pid" != "x" ]
    echo $pid | xargs kill
  end
end
