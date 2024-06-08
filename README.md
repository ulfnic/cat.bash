# cat.bash

Concatenate FILE(s) to stdout in pure BASH.

## Examples of Use

```bash
cat.bash '/path/to/file1' '/path/to/file2' > combined.txt
```
```bash
printf 'b' | cat.bash <(printf 'a') - <(printf 'c')
# stdout: abc
```
```bash
cat.bash <<-'EOF' > myfile
	Hello from a heredoc
EOF
```
```bash
source /path/to/cat.bash
# cat.bash becomes a function

printf '%s\n' 'data' | cat.bash
```

## Null Character Compatible
```bash
  printf '\0\0\0null\0\0\0characters\0\0\0' | cat.bash | sed 's/\o0/\\0/g'
# stdout: \0\0\0null\0\0\0characters\0\0\0
```

## License

Licensed under Creative Commons, CC0 1.0 Universal. See LICENSE for details.
