package main

import (
	"github.com/joho/godotenv"
	"log"
)

func main() {
	// Load the .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	// Get the API key from the environment variable
	generateContentFromImage()

	// Use the API key
}
