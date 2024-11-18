#!/bin/bash

# Set container name
CONTAINER_NAME="ros2_moveit_container"

# Allow Docker to use the X server for graphical applications (RViz)
xhost +local:docker

# Build the Docker container if it doesn't exist yet
docker build -t ros2-moveit:v1.3 .

# Run the container with the necessary settings for graphical interfaces and assign a name
docker run --network host -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name $CONTAINER_NAME ros2-moveit:v1.2

# Function to enter the running container from another terminal
docker exec -it $CONTAINER_NAME /bin/bash

