set -gx fish_user_paths $HOME/.linuxbrew/bin $fish_user_paths

alias i='sudo apt install --yes'

# safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls
alias ll='ls -alF'
alias l='ls -alF'

# tool
alias b='brew'
alias c='code'
alias clip='clip.exe'
alias d='docker'
alias open='explorer.exe'
alias e='explorer.exe .'
alias l='ls -al'
alias p='pa aux'
alias v='vim'
alias vi='vim'
alias gh="open (git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git\$//' | sed -E 's/(\/\/[^:]*):/\1\//')"
alias p='powershell.exe'

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
