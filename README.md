# cat.bash

Concatenate FILE(s) to stdout in pure BASH as an executable or sourceeable script.

```
cat.bash [FILE]...
   With no FILE, or when FILE is -, read standard input.
```

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

cat.bash ./myfile
# stdout: Hello from a heredoc
```
```bash
source ./cat.bash
# cat.bash now becomes a function
printf 'test' | cat.bash
# stdout: test
```

## Null Character Demonstration
cat.bash does not squash or error on null characters.
```bash
  printf '\0\0\0null\0\0\0characters\0\0\0' | cat.bash | sed 's/\o0/\\0/g'
# stdout: \0\0\0null\0\0\0characters\0\0\0
```

## License

Licensed under Creative Commons, CC0 1.0 Universal. See LICENSE for details.
