umask 002
set -gx fish_user_paths $HOME/.linuxbrew/bin $fish_user_paths
set -g fish_user_paths "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
set -g fish_user_paths "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH;

set -x VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1
set -x PATH "$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
set -x VAGRANT_PREFER_SYSTEM_BIN 0
set -x GOPATH $HOME
set -x PATH $GOPATH/bin:$PATH
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
set -x JRE_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
set -x DISPLAY localhost:0.0

rbenv init - | source
status --is-interactive; and source (anyenv init -|psub)
# status --is-interactive; and source (anyenv init -|psub)

alias i='sudo apt install --yes'

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
alias vimr='vim -R -'
alias gh="open (git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e 's/ssh:\/\///' -e's/git@/http:\/\//' -e's/\.git\$//' | sed -E 's/(\/\/[^:]*):/\1\//')"
alias p='powershell.exe'
alias rl='readlink -f'

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

