cat << EOF > Dockerfile
#Build an ubuntu image for docker and install Gitr

# Create the base image
FROM ubuntu:latest


# Install necessary package
RUN apt-get update  && \ 
    apt-get install -y git &&\
    rm -rf /var/lib/apt/lists/*

# Copy files to app dir
COPY . /app

#Go to working Dir
WORKDIR /app

CMD ["Git", "Hello, Installed GIT in a docker!"]
EOF

echo "Building docker image"
sudo docker build -t git_in_docker .
echo "Checking version"
sudo docker run -it git_in_docker --version

gcloud artifacts repositories create my-docker-repo --repository-format=docker --location=us-central1 --description="My Docker test repository"

echo "Rename your file"

gcloud auth configure-docker test-docker.pkg.dev
echo "Tagging your image with artifactory path"
docker tag git_in_docker:latest us-central1-docker.pkg.dev/YOUR_PROJECT_ID/my-docker-repo/my-app-image:latest

echo "Push the image to artifactory"
docker push us-central1-docker.pkg.dev/YOUR_PROJECT_ID/my-docker-repo/git_in_docker:latest
