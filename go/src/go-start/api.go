package main

import (
	"encoding/json"
	"fmt"

	// "github.com/gorilla/mux"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

type APIServer struct {
	addr string
}

type Article struct {
	Title   string `json:"Title"`
	Desc    string `json:"desc"`
	Content string `json:"content"`
}

type Articles []Article

func NewAPIServer(addr string) *APIServer {
	return &APIServer{
		addr: addr,
	}

}

func (s *APIServer) Run() error {

	//SERVER HANDELING
	// router := http.NewServeMux()
	router := mux.NewRouter().StrictSlash(true)
	server := http.Server{
		Addr:    s.addr,
		Handler: router,
	}
	log.Printf("server has started %s", s.addr)

	// HTTP PATH REQUESTS AND RESPONSE
	router.HandleFunc("/user/{userId}", func(w http.ResponseWriter, r *http.Request) {
		userID := r.PathValue("userI")
		w.Write([]byte("User ID:" + userID))
	}).Methods("POST")
	router.HandleFunc("/home", HomePage).Methods("GET")
	router.HandleFunc("/jsonFormat", RanderJson).Methods("GET")
	return server.ListenAndServe()
}

func HomePage(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Home Page"))
}

func RanderJson(w http.ResponseWriter, _ *http.Request) {
	articles := Articles{
		Article{
			Title:   "Test Title",
			Desc:    "Test Description",
			Content: "Hello World"},
	}

	fmt.Printf("EndPoint hit:")
	json.NewEncoder(w).Encode(articles)
}

func RoutPage(w http.ResponseWriter, r *http.Request) {

}
