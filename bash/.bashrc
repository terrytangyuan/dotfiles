# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Force kill a job with a regex pattern
kk() {
  if [ -z "$1" ]
  then
     echo "Provide a regex for the job"
  fi
  REGEX=$1; kill -9 $(ps u | grep $REGEX | awk '{print $2}')
}

# Aliases

alias g='git'
alias kub='kubectl'
