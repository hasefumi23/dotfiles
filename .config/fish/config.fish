set -gx fish_user_paths $HOME/.linuxbrew/bin $fish_user_paths

alias vi='/usr/bin/vim'
alias open='explorer.exe'
alias e='explorer.exe .'

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

