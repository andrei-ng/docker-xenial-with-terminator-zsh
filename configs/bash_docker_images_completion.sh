# Andrei Gherghescu 23012018
# Bash completion for custom run.sh script used to launch a docker image
# First method works fine, but it is more involved. 
# Second method is shorter. 

# _docker_autocomplete_image_and_tags() {
#     local cur
#     COMPREPLY=()
#     cur="${COMP_WORDS[COMP_CWORD]}"
#     prev=${COMP_WORDS[COMP_CWORD-1]}
#     __ltrim_colon_completions "$cur"

#     local image_name

#     if [[ $COMP_CWORD -eq 1 ]]; then
#       local reposAndTags="$(docker images | awk 'NR>1 && $1 != "<none>" { if ($2 == "latest") print $1; else print $1":"$2 }')"
#       COMPREPLY=( $(compgen -W "$reposAndTags" -- "$cur") ) #; compopt -o nospace;
#       return
#     fi

#     if [[ $COMP_CWORD -eq 2 && ${cur}==:* ]]; then
#       local imageTags="$(docker images $prev | awk 'NR>1 && $1 != "<none>" && $2 != "latest" { print $2}')"
#       COMPREPLY=( $(compgen -W "$imageTags") ) #; compopt -o nospace;
#       return
#     fi

#     if [[ $COMP_CWORD -eq 3 && ${prev}==:* ]]; then
#       image_name=${COMP_WORDS[COMP_CWORD-2]}
#       local imageTags="$(docker images $image_name | awk 'NR>1 && $1 != "<none>" { print $2}')"
#       COMPREPLY=( $(compgen -W "$imageTags" -- "$cur")) #; compopt -o nospace;
#       return
#     fi
# }

# complete -F _docker_autocomplete_image_and_tags ./run.sh

_docker_autocomplete_image_and_tags () {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prev=${COMP_WORDS[COMP_CWORD-1]}

  case "${prev}" in
    *:*)
      image_name=${COMP_WORDS[COMP_CWORD-2]}
      local imageTags="$(docker images $image_name | awk 'NR>1 && $1 != "<none>" { print $2}')"
      COMPREPLY=( $(compgen -W "$imageTags" -- "$cur")) #; compopt -o nospace;
      ;;
    *)
      local reposAndTags="$(docker images | awk 'NR>1 && $1 != "<none>" { if ($2 == "latest") print $1; else print $1":"$2 }')"
      COMPREPLY=( $(compgen -W "${reposAndTags}" -- ${cur}) ); #compopt -o nospace; return 0;;
  esac
}

complete -F _docker_autocomplete_image_and_tags ./run.sh