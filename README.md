# cat.bash

Concatenate FILE(s) to stdout in pure BASH as an executable or sourceable script.

```
cat.bash [FILE]...
   With no FILE, or when FILE is -, read standard input.
```

## Examples of Use

```bash
# Optional: source cat.bash to define cat.bash as a function for better performance.
source cat.bash
```
```bash
cat.bash '/path/to/file1' '/path/to/file2' > combined.txt
```
```bash
printf 'b' | cat.bash <(printf 'a') - <(printf 'c')
# stdout: abc
```
```bash
cat.bash < file-to-copy > copy-of-file
```
```bash
cat.bash <<-'EOF' > message.txt
	Hello from a heredoc
EOF
```

## Proofs
Copying a binary:
```bash
cat.bash "$(which bash)" > /tmp/bash_copy
md5sum "$(which bash)" /tmp/bash_copy
# stdout:
# e979d93c05b74fb89fd21eb312f81d3d  /usr/bin/bash
# e979d93c05b74fb89fd21eb312f81d3d  /tmp/bash_copy
```
Copying null characters:
```bash
  printf '\0\0\0null\0\0\0characters\0\0\0' | cat.bash | sed 's/\o0/\\0/g'
# stdout: \0\0\0null\0\0\0characters\0\0\0
```
