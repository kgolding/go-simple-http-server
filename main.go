package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/hello", handler)
	http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir("www"))))
	http.ListenAndServe(":8080", nil)
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello !")
}
