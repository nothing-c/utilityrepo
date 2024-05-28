#!/bin/sh
#simple lisp compilation script - SBCL-compatible, IDK about anything else
#REQUIRES A MAIN FUNCTION, LIKE C
#usage: lispc [file] [executable name]
echo "(load \"$1\")\n(sb-ext:save-lisp-and-die \"$2\" :toplevel #'main :executable t)" | sbcl
