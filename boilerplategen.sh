#!/bin/sh
#generates boilerplate code in the language from cmd arg

#TODO: man page
#main args: -cljp (C, Lua, Java, Python), <filename>

c="//this is autogen boilerplate - CB 2021\nint main(void){\n  return 0;\n}"

l="--this is autogen boilerplate - CB 2021\nfunction fun()\n  return 0\nend"

j="//this is autogen boilerplate - CB 2021\nint void main(String[] args){\n  return 0;\n}"

p="#this is autogen boilerplate - CB 2021\ndef function():\n  return 0\n"

while getopts cljp FILETYPE; do
	case $FILETYPE in
		c) touch base.c | echo $c >> base.c;;
		l) touch base.lua | echo $l >> base.lua;;
		j) touch base.java | echo $j >> base.java;;
		p) touch base.py | echo $p >> base.py;;
	esac
done
exit


