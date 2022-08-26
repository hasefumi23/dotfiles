function tmuxpopup() {
  local name=${1}
  local width='80%'
  local height='80%'
  local session=$(tmux display-message -p -F "#{session_name}")
  if [ $(echo ${session} | grep "${name}") ]; then
    tmux detach-client
  else
    tmux popup -d '#{pane_current_path}' -xC -yC -w${width} -h${height} -E "tmux attach -t ${name} || tmux new -s ${name}"
  fi
}
