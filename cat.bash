#!/usr/bin/env bash


cat.bash() {
	# cat.bash [FILE]...
	#
	# DESCRIPTION
	#   Concatenate FILE(s) to stdout in native BASH without use of cat.
	#
	#   With no FILE, or when FILE is -, read standard input.


	print_pipe() {
		# Writes the contents of stdin to stdout in null character deliminated chunks.

		# If the `read` command succeeds it means it read a null character.
		# Contents of what was read is written to stdout followed by a null character
		# to represent the one squashed as the deliminator.

		# If the `read` command fails it means it didn't read a null character
		# before encountering EOF. The loop is broken and the all characters
		# read up to that point are written to stdout.

		local LANG=C IFS REPLY
		while read -r -d ''; do
			printf '%s\0' "$REPLY"
		done
		printf '%s' "$REPLY"
	}


	# If no args, read from stdin
	if [[ ${#@} == '0' ]]; then
		print_pipe
		return $?
	fi


	# Hande args
	while [[ $1 ]]; do
		if [[ $1 == '--' ]]; then
			shift
			break
		fi

		if [[ $1 == '-' ]]; then
			print_pipe || return $?
		else
			print_pipe < "$1" || return $?
		fi

		shift
	done


	# Hande remaining args as files
	while [[ $1 ]]; do
		print_pipe < "$1" || return $?
		shift
	done


	return 0
}



# If not sourced, call function
[[ ${BASH_SOURCE[0]} == "$0" ]] && cat.bash "$@"


