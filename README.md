## About this project
This is a simple terminal based calculator written in Haxe.
Parsing is done by tokenising the input and building an AST (abstract syntax tree: https://en.wikipedia.org/wiki/Abstract_syntax_tree) from those tokens.
The goal of this project was to better understand parsing and building ASTs for my upcoming projects.

## Prerequisites
1. Install Haxe binaries: https://haxe.org/download/
2. Clone this repo

## Usage
Simply run this command in the project folder:
```
haxe --main Repl --interp
``` 
You will be greeted with this prompt:

```
calc>
```

Type in any arithmetic expression using integers, `+, -, *, /` operators and parenthesis.
If the expression is valid you will get an answer:
```
calc> 7 + 9 * (8 / 2)
calc> 43
```

To quit the program either type in `exit` or press <kbd>Ctrl</kbd>+<kbd>C</kbd>

## Current limitations
- supports only these operators: `+ - * /`
- work only with integer numbers
- overflows at the signed 32-bit integer values (2147483647 and -2147483648) 
```
calc> 2147483647 + 1
calc> -2147483648
```
- division by zero results in negative signed 32 integer bound (-2147483648)
