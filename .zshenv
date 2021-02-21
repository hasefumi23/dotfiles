function tmuxpopup() {
  local width='80%'
  local height='80%'
  local session=$(tmux display-message -p -F "#{session_name}")
  if [ $(echo ${session} | grep "popup") ]; then
    tmux detach-client
  else
    tmux popup -d '#{pane_current_path}' -xC -yC -w${width} -h${height} -K -E -R "tmux attach -t popup || tmux new -s popup"
  fi
}
