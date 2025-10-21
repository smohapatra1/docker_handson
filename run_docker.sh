cat << EOF > Dockerfile
#Build an ubuntu image for docker and install Gitr

# Create the base image
FROM ubuntu:latest


# Install necessary package
RUN apt-get update  && \
    apt-get install -y git &&\
    rm -rf /var/lib/apt/lists/*
# Copy files to app dir
#COPY . /app

#Go to working Dir
#WORKDIR /app
CMD ["/bin/bash"]
EOF

echo "Building docker image"
sudo docker build -t git_in_docker .
echo "Checking the images"
sudo docker image ls
echo "Starting the conatiner with above image"
sudo docker container run git_in_docker
sleep 2
echo "Checking the docker processes"
sudo docker ps -a
id=$(sudo docker ps -a  | awk '{print $1}' | tail -1)
echo "Conatiner ID = $id"
echo "Starting the container"
sudo docker container start $id
echo "Checking the container status"
sudo docker ps -a

