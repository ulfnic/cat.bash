#!/usr/bin/env bash


cat.bash() {
	# cat.bash [FILE]...
	#
	# DESCRIPTION
	#   Concatenate FILE(s) to stdout in pure BASH without use of cat.
	#
	#   With no FILE, or when FILE is -, read standard input.
	#
	# TRAILING $'\0' NULL CHARACTER LIMITATION
	#   If an input ends in a null character, it's trimmed from it's output.
	#   (see README.md)

	local MAPFILE MAPFILE_len


	print_pipe() {
		# Read from stdin into an array deliminated by null characters
		readarray -d ''

		# Print portion of stdin that was before the first null character
		printf '%s' "${MAPFILE[0]}"

		# Print portion of stdin that contained null characters
		MAPFILE_len=${#MAPFILE[@]}
		[[ $MAPFILE_len == 1 ]] || printf '\0%s' "${MAPFILE[@]:1:MAPFILE_len-1}"
	}


	# Hande args
	if [[ ${#@} == '0' ]]; then
		print_pipe || return $?
	else
		while [[ $1 ]]; do
			if [[ $1 == '--' ]]; then
				shift; break
			elif [[ $1 == '-' ]]; then
				print_pipe || return $?
			else
				print_pipe < "$1" || return $?
			fi
			shift
		done
		while [[ $1 ]]; do
			print_pipe < "$1" || return $?
			shift
		done
	fi
}



# If not sourced, call function
[[ ${BASH_SOURCE[0]} == "$0" ]] && cat.bash "$@"



