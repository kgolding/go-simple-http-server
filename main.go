package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

func main() {
	wwwDir := flag.String("www", "www", "directory with files to be served")

	log.Printf("Serving files from '%s'", *wwwDir)

	http.HandleFunc("/hello", handler)
	http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir(*wwwDir))))

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err.Error())
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello !")
}
