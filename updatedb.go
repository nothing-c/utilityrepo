/*
updatedb for Windows
Usage: (as admin) updatedb
DB location: c:/bin/locatedb.txt
*/

package main

import (
	"fmt"
	"path/filepath"
	"os"
)

const FILENAME = "c:/bin/locatedb.txt"

func main () {
	//reset file so I can just append
	err := os.WriteFile(FILENAME, []byte("\n"), 0644)
	if err != nil {
		panic("Could not write to db file")
	}
	fileout,_ := os.OpenFile(FILENAME, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	//so this works, now we just need to write to a file
	err = filepath.WalkDir("c:/", 
		func(file string, entry os.DirEntry, err error) error {
			if err != nil {
				fmt.Println(err) //TODO: put this to a logger
			}
			fmt.Println(file)
			fileout.WriteString(file + "\n")
			return nil
		})
	fileout.Close()
	if err != nil {
		fmt.Println(err)
	}
}
