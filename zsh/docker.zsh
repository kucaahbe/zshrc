# functionality:
# on cd: examine for presence of Dockerfile/docker-compose.yml
#        add to prompt: docker(-compose)?:name(${green, if up}service1,${red, if down}service2,...)
# if for current directory docker is up, examine `./docker.zsh` and make sure commands listed there
# are executed using docker(-compose)-exec service (service is specified in ./docker.zsh)

#DOCKER_ZSH_DEBUG=true

preexec_functions+=(__docker_zsh_preexec)

__docker_zsh_preexec() {
	# local cmd_raw=$1
	# local cmd_expanded=$2
	local cmd=$3
	__docker_zsh_debug $cmd
}

__docker_zsh_debug() {
	[ ${DOCKER_ZSH_DEBUG:-false} != true ] && return

	print docker.zsh: $*
}

_docker_zsh_mini() {
	[[ -f docker.zsh ]] && source docker.zsh
}

precmd_functions+=(
  _docker_zsh_mini
)

# TODO: use functions autoloading(autoload/zcompile)?
# TODO: implement trusted:yes/no for ./docker.zsh, since it probably may come from unstructed repository
# and be a security risk
