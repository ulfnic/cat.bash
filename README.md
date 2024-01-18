# cat.bash

Concatenate files to stdout in pure BASH without use of `cat` as a sourced or executable script.

```bash
printf 'b' | cat.bash <(printf 'a') - <(printf 'c')
# stdout: abc
```

## Trailing $'\0' Null Character Limitation

If an input ends in a null character, it's trimmed from it's output.

Example:

```bash
  printf '\0\0\0null\0\0\0characters\0\0\0' | cat.bash
# stdout: \0\0\0null\0\0\0characters\0\0
```

#### Why is this the case?

cat.bash gets around the null character storage limitation of BASH by storing incoming data in a null character deliminated array so they're represented as array indexes.

The limitation of this method is if the last character that's read is a deliminator (a null character) `readarray` doesn't create an additional index so the information is lost.

A work-around is to arbitrarily write a null character at the end of every input but I don't know of a way to do that in pure BASH without using `cat`.

## Examples of Use

```bash
cat.bash '/path/to/file1' '/path/to/file2'
```
```bash
cat.bash <<-'EOF'
	Hello from a heredoc
EOF
```
```bash
source /path/to/cat.bash
# cat.bash becomes a function

printf '%s\n' 'data' | cat.bash
```

## License

Licensed under Creative Commons, CC0 1.0 Universal. See LICENSE for details.
