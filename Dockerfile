name: Build and Push Docker Image

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Docker Buildx (build toolkit)
        uses: docker/setup-buildx-action@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ DOCKERHUB_USERNAME }}       # GitHub Secret with Docker Hub username
          password: ${{ DOCKERHUB_TOKEN }}  # GitHub Secret with Docker Hub PAT

      - name: Build and push Docker image
        uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ${{ secrets.USERNAME }}/myapp:latest
