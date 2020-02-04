#!/bin/bash

# ----------------------------------------------------
# Author: ohmystack (jiangjun1990@gmail.com)
# Original repo: https://github.com/ohmystack/kubetool
# ----------------------------------------------------

set -e

# default settings
KUBECTL="kubectl"

# -----------------
# Help
# -----------------

print_usage() {
	# NOTE: After modification, remember to
	#       1. Run `:Align |` in vim to align the help info with '|' seperator
	#       2. Sort the action list by alphabet
	cat <<-'EOF'
    __         __         __              __
   / /____  __/ /_  ___  / /_____  ____  / /
  / //_/ / / / __ \/ _ \/ __/ __ \/ __ \/ / 
 / ,< / /_/ / /_/ /  __/ /_/ /_/ / /_/ / /  
/_/|_|\__,_/_.___/\___/\__/\____/\____/_/

	kt (kubetool)

	Usage:
	kt [-n <namespace>] [--all] <action>

	Actions:
	  ps <kind> [keyword]   | List or search resources
	  get <kind> [keyword]  | Search and get a resource by a keyword
	  desc <kind> [keyword] | Search and describe a resource by a keyword
	  logs [-f] <keyword>   | Search and fetch the Pod's logs
	  ssh <keyword>         | Enter the bash/sh of a Pod's container

	Other actions:
	  self-upgrade          | Upgrade "kubetool" to the latest version

	EOF
}

# -----------------
# Utils - common
# -----------------

# echo with 256 color
# Usage: echo_color <color_id> <text>
echo_color() {
	dye=$(echo -e "\x1B[38;5;${1}m")
	stop_dye=$(echo -e "\x1B[0m")
	echo "${dye}${2}${stop_dye}"
}

echo_err() {
	echo_color 202 "$1" 1>&2
}

# Prompt a string to ask user, and return the result string.
# Usage:
#   answer=$(ask_user_string 'which one do you want?')
ask_user_string() {
	local answer
	echo ""
	read -p "$1 " answer >&2
	echo $answer
}

# ------------------
# Utils - Kubernetes
# ------------------

# List or search the resource by a keyword
# Returns:
#   Result string
list_or_search() {
	local kind=$1
	local keyword=$2
  local opts=(--no-headers=true)

	local result
  if [ -z "${keyword}" ]; then
    result=$($KUBECTL get "${opts[@]}" $kind | awk '{print $1}' | sort)
  else
    result=$($KUBECTL get "${opts[@]}" $kind | awk '{print $1}' | grep -i $keyword | sort)
  fi
  echo $result
}

# List or search the resource by a keyword, and ask user to pick one of them
# Returns:
#   The picked name
list_or_search_one() {
	local container_level=false
	while [ -n "$1" ]; do
		case $1 in
			'-c')
				container_level=true
				;;
			*)
			  break
				;;
		esac
		shift
	done

  local names
  local kind=$1
  local keyword=$2
	# Try to parse keyword from kind_with_keyword. e.g. Parse 'xxx' from 'pod/xxx'
	local keyword_from_kind="${kind##*/}"
	if [ $kind != $keyword_from_kind ] && [ -n "${keyword_from_kind}" ] ; then
		kind="${kind%/*}"
		keyword=$keyword_from_kind
	fi

  read -a names <<< $(list_or_search $kind $keyword)
	if [ ${#names[@]} -eq 0 ] ; then
	  echo_err "no such resource"
	  exit 1
	elif [ ${#names[@]} -eq 1 ] ; then
	  pod_name=$names
  else
    # Print
    local i
    for i in "${!names[@]}"; do
      printf "%3d) %s\n" $i "${names[$i]##*/}" >&2
    done
    # Pick one
    picked=$(ask_user_string 'Please choose one. Enter the index number:')
    if [ $picked -lt 0 ] || [ $picked -ge ${#names[@]} ] ; then
      echo_err 'invalid index'
      exit 1
    fi
    pod_name="${names[$picked]}"
	fi

	if ! $container_level ; then
    echo $kind $pod_name
    return
  fi

  # Container level
  local containers
  read -a containers <<< $($KUBECTL get pod $pod_name -o jsonpath='{.spec.containers[*].name}' | sort)
  if [ ${#containers[@]} -eq 1 ] ; then
    echo $pod_name
    return
  fi
  # Print containers in this Pod
  for i in "${!containers[@]}"; do
    printf "%3d) %s\n" $i "${containers[$i]}" >&2
  done
  # Pick one container
  picked_container=$(ask_user_string 'Multiple containers in this Pod. Please choose one. Enter the index number:')
  if [ $picked_container -lt 0 ] || [ $picked_container -ge ${#containers[@]} ] ; then
    echo_err 'invalid index'
    exit 1
  fi
  echo $pod_name -c "${containers[$picked_container]}"
}

# -----------------
# Actions
# -----------------

action_ps() {
  local kind=$1
  local keyword=$2
  local opts=(--no-headers=true -o wide)

  if [ -z "${keyword}" ]; then
    exec $KUBECTL get "${opts[@]}" $kind
  else
    exec $KUBECTL get "${opts[@]}" $kind | grep --color=auto -i $keyword
  fi
}

action_get() {
  local name
  name=$(list_or_search_one $1 $2)
  exec $KUBECTL get -o yaml $name
}

action_describe() {
  local name
  name=$(list_or_search_one $1 $2)
  exec $KUBECTL describe $name
}

action_ssh() {
  local name
  name=$(list_or_search_one -c pod $1)
  name=${name##*/}  # Drop the prefix kind

	local exit_code
  $KUBECTL exec -it $name /bin/bash
  exit_code=$?
  if [ ! $exit_code -eq 126 ] ; then  # 126: no such command
    exit $exit_code
  fi

  echo_color 64 "- Try to use /bin/sh"
  $KUBECTL exec -it $name /bin/sh
  exit_code=$?
  if [ ! $exit_code -eq 126 ] ; then
    exit $exit_code
  fi

  echo_err "cannot find '/bin/bash' or '/bin/sh' in container: $name"
  exit 1
}

action_logs() {
	local keyword

	local follow=false
	while [ -n "$1" ]; do
		case $1 in
			'-f')
				follow=true
				;;
			*)
				keyword=$1
				break
				;;
		esac
		shift
	done

  local name
  name=$(list_or_search_one -c pod $keyword)
  if $follow ; then
    exec $KUBECTL logs --tail=50 -f $name
  else
    exec $KUBECTL logs $name
  fi
}

action_self_upgrade() {
	local self=$0
	local kt_download_link="https://raw.githubusercontent.com/ohmystack/kubetool/master/kubetool"
	local kt_repo="https://github.com/ohmystack/kubetool"
	# If user launchs this script from a symlink, find the real file path
	if [ -L $self ] ; then
		self=$(python -c 'import os,sys;print(os.path.realpath(sys.argv[1]))' $self)
	fi
	local base=$(basename $self)
	if [ -z "${base}" ] ; then
		echo_err "failed to find kubetool installation path."
		exit 1
	fi
	echo "upgrade kubetool from $kt_repo ..."
	cp $self /tmp/ && echo "(the old kubetool has been backuped into /tmp)"
	# Do this in one line, and exit immediately to prevent executing wrong lines in the new downloaded script.
	curl -s $kt_download_link > $self && chmod a+x $self && rm /tmp/$base && echo "done." && exit 0 || echo_err "failed." && mv /tmp/$base $self && exit 1
}

# -----------------
# Main
# -----------------

if [ -z "${1}" ]; then
	print_usage
	exit 0
fi
while [ -n "$1" ]; do
	case $1 in
		'help'|'-h'|'--help')
			print_usage
			break
			;;
		'-n'|'--namespace')
      KUBECTL+=" -n $2"
      shift 2
			;;
    '--all'|'--all-namespaces')
      KUBECTL+=" --all-namespaces=true"
			shift
      ;;
		'ps')
			shift
			action_ps "$@"
			break
			;;
		'get')
			shift
			action_get "$@"
			break
			;;
		'desc'|'describe')
			shift
			action_describe "$@"
			break
			;;
		'ssh'|'exec')
			shift
			action_ssh "$@"
			break
			;;
		'logs'|'log')
			shift
			action_logs "$@"
			break
			;;
		'self-upgrade')
			shift
			action_self_upgrade "$@"
			break
			;;
		*)
			echo_err "Error: unknown action '$1'"
			exit 1
			;;
	esac
done
