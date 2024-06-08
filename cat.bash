#!/usr/bin/env bash


cat.bash() {
	# cat.bash [FILE]...
	#
	# DESCRIPTION
	#   Concatenate FILE(s) to stdout in native BASH without use of cat.
	#
	#   With no FILE, or when FILE is -, read standard input.

	local LANG=C REPLY


	print_pipe() {
		# Writes the contents of stdin to stdout.

		# stdin is read in null character deliminated chunks.

		# Each successful read prints the contents of stdin up to the first null character followed
		# by a null character to represent the one squashed as the deliminator.

		# Read fails when encountering an EOF. Everything read since the last null character (or
		# beginning of stdin if there weren't any) is printed and the read loop is broken.

		while :; do
			if IFS= read -r -d ''; then
				printf '%s\0' "$REPLY"
				continue
			fi
			printf '%s' "$REPLY"
			break
		done
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



