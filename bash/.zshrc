# Git branch in prompt.
# parse_git_branch() {
#   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
# export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Force kill a job with a regex pattern
kk() {
  if [ -z "$1" ]
  then
     echo "Provide a regex for the job"
  fi
  REGEX=$1; kill -9 $(ps u | grep $REGEX | awk '{print $2}')
}

kdecode () {
  if [ -z "$1" ]
  then
    echo "Usage: kdecode SECRETNAME"
    return 1
  fi
  kubectl get secret -o json $@ | jq -r '.data | map_values(@base64d)'
}

# Aliases

alias g='git'
alias k='kubectl'
alias kp='kubectl get pods'
alias kl='kubectl logs'
alias kd='kubectl describe'

# Prerequisites: kubectl krew https://krew.sigs.k8s.io/docs/user-guide/setup/install/
alias kc='kubectl ctx'
alias kns='kubectl ns'
# Once installed podman and following the guides:
# 1. https://podman-desktop.io/docs/migrating-from-docker/using-podman-mac-helper
# 2. https://podman-desktop.io/docs/migrating-from-docker/emulating-docker-cli-with-podman
alias docker='sudo bash /usr/local/bin/docker'

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_331.jdk/Contents/Home"
