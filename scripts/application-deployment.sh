# https://learn.microsoft.com/en-us/dotnet/architecture/microservices/

# Pull the production image
docker pull mcr.microsoft.com/dotnet/aspnet:7.0

# Move into working directory
cd /repos/ai-102/learning-ai-kubernetes-vim/deployment

# Create the Dockerfile for the agent
touch Dockerfile

# Add the following to the Dockerfile
cat <<EOF > Dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
EOF

# Build the Docker image
docker build -t dot-net-deployment .

# Verify that the image is built
docker image ls |grep dot-net-deployment

# Run the container with a terminal input, a mounted volume, name, and mapped port
docker run -it -v $(pwd)/app:/app --name app-deployment -p 5025:5025 dot-net-deployment

# Verify that the container is running
docker ps --all |grep app-deployment

# Start the container after exiting
docker start app-deployment

# Exec into the container
docker exec -it app-deployment bash

# Stop and remove the container
docker stop app-deployment && docker rm app-deployment