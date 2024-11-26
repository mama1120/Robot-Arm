#!/bin/bash

# Set container name
CONTAINER_NAME="ros2_moveit_container"

# Allow Docker to use the X server for graphical applications (RViz)
xhost +local:docker

# Check if the container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "The container $CONTAINER_NAME is already running. Attaching..."
    docker exec -it $CONTAINER_NAME /bin/bash
else
    echo "Starting a new container..."
    # Run the container with graphical settings and assign a name
    docker run --network host -it --rm \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --name $CONTAINER_NAME \
        ros2-moveit:v1.3
fi
