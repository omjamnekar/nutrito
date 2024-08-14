package main

import (
	"context"
	"fmt"
	"log"
	"mime"
	"os"
	"path/filepath"

	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
)

func generateContentFromImage() {
	ctx := context.Background()
	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("API_KEY")))
	if err != nil {
		log.Fatal(err)
	}
	defer client.Close()

	model := client.GenerativeModel("gemini-1.5-flash")

	imagePath, err := filepath.Abs("meggi.jpg") // Path to your image in the current directory
	if err != nil {
		log.Fatal(err)
	}
	imageInput := genai.FileData{
		MIMEType: mime.TypeByExtension(filepath.Ext(imagePath)),
		URI:      imagePath,
	}

	textPrompt := genai.Text("Write a story about a magic backpack.")

	resp, err := model.GenerateContent(ctx, imageInput, textPrompt)
	if err != nil {
		log.Fatal(err)
	}

	for _, candidate := range resp.Candidates {
		fmt.Println("Generated Text:", candidate.Content.Parts[0])
	}
}
