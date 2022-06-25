/*
locate
Usage: locate [filename]
*/

package main

import (
	"fmt"
	"os"
	"bufio"
	"strings"
)

const FILENAME = "c:/bin/locatedb.txt"

func main () {
     if len(os.Args) < 2 {
     	fmt.Println("Not enough args")
	os.Exit(1)
     }
     file,_ := os.Open(FILENAME)
     reader := bufio.NewScanner(file)
     for reader.Scan() {
     	 if strings.Contains(reader.Text(), os.Args[1]) {
		fmt.Println(reader.Text())
	 }
     }
}
