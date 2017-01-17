#!/bin/bash

SCRIPT_NAME='cleanup'

matches_debug() {
  if [ -z "$DEBUG" ]; then
    return 1
  fi
  if [[ $SCRIPT_NAME == $DEBUG ]]; then
    return 0
  fi
  return 1
}

debug() {
  local cyan='\033[0;36m'
  local no_color='\033[0;0m'
  local message="$@"
  matches_debug || return 0
  (>&2 echo -e "[${cyan}${SCRIPT_NAME}${no_color}]: $message")
}

script_directory(){
  local source="${BASH_SOURCE[0]}"
  local dir=""

  while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
    dir="$( cd -P "$( dirname "$source" )" && pwd )"
    source="$(readlink "$source")"
    [[ $source != /* ]] && source="$dir/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done

  dir="$( cd -P "$( dirname "$source" )" && pwd )"

  echo "$dir"
}

assert_required_params() {
  local pattern="$1"

  if [ -n "$pattern" ]; then
    return 0
  fi

  usage

  if [ -z "$pattern" ]; then
    echo "Missing <pattern> argument"
  fi

  exit 1
}

usage(){
  echo "USAGE: ${SCRIPT_NAME} <base-url> <pattern>"
  echo ''
  echo 'Description: ...'
  echo ''
  echo 'Arguments:'
  echo '  -h, --help       print this help text'
  echo '  -n, --dry-run    list indexes that would be deleted, but dont do anything'
  echo '  -v, --version    print the version'
  echo ''
  echo 'Environment:'
  echo '  DEBUG            print debug output'
  echo ''
}

version(){
  local directory="$(script_directory)"

  if [ -f "$directory/VERSION" ]; then
    cat "$directory/VERSION"
  else
    echo "unknown-version"
  fi
}

# Main functionality

delete_all(){
  local base_url="$1"; shift
  local indexes_to_delete=( "$@" )

  for index in "${indexes_to_delete[@]}"; do
    delete_index "$base_url" "$index"
  done
}

delete_index(){
  local base_url="$1"
  local index="$2"

  curl --fail --silent -X DELETE "$base_url/$index" && echo ""
}

get_indexes(){
  local base_url="$1"

  curl --silent "$base_url/_cat/indices" | awk '{print $3}'
}

get_indexes_to_delete(){
  local base_url="$1"
  local pattern="$2"

  get_indexes "$base_url" | grep "$pattern"
}

main() {
  # Define args up here
  local base_url
  local dry_run
  local pattern
  local progress

  while [ "$1" != "" ]; do
    local param="$1"
    local value="$2"
    case "$param" in
      -h | --help)
        usage
        exit 0
        ;;
      -v | --version)
        version
        exit 0
        ;;
      # Arg with value
      # -x | --example)
      #   example="$value"
      #   shift
      #   ;;
      # Arg without value
      -n | --dry-run)
        dry_run='true'
        ;;
      -p | --progress)
        progress='true'
        ;;
      *)
        if [ "${param::1}" == '-' ]; then
          echo "ERROR: unknown parameter \"$param\""
          usage
          exit 1
        fi
        # Set main arguments
        if [ -z "$base_url" ]; then
          base_url="$param"
        elif [ -z "$pattern"]; then
          pattern="$param"
        fi
        ;;
    esac
    shift
  done

  assert_required_params "$base_url" "$pattern"

  local indexes_to_delete=( $(get_indexes_to_delete "$base_url" "$pattern") )

  if [ "$dry_run" == "true" ]; then
    printf '%s\n' "${indexes_to_delete[@]}"
    exit 0
  fi

  if [ "$progress" == "true" ]; then
    delete_all "$base_url" "${indexes_to_delete[@]}" \
    | pv --line-mode --size "${#indexes_to_delete[@]}" > /dev/null
    exit 0
  fi

  delete_all "$base_url" "${indexes_to_delete[@]}"
}

main "$@"
