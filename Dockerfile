# Start from the MoveIt2 base image (no NVIDIA dependency)
FROM moveit/moveit2:humble-source

# Set environment variable to make apt-get non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies in one RUN step to reduce layers and improve caching
RUN apt-get update && apt-get install -y \
    ros-humble-moveit-msgs \
    ros-humble-moveit-core \
    ros-humble-graph-msgs \
    ros-humble-rviz-visual-tools \
    x11-xserver-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set timezone to avoid configuration prompts
ENV TZ=Etc/UTC
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Copy only the necessary folders (optimized for smaller context copy)
COPY robot_ws/src /root/ros2_ws/src/
COPY ws_moveit2 /root/ws_moveit2

# Set the working directory to the ROS2 workspace
WORKDIR /root/ros2_ws/

# Build the ROS2 workspace (combined into one RUN command to reduce layers)
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    source /root/ws_moveit2/install/setup.bash && \
    colcon build --merge-install --symlink-install"

# Set up ROS2 environment for the container
RUN echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc && \
    echo 'source /root/ros2_ws/install/setup.bash' >> ~/.bashrc

# Set environment variable for X11 display (for graphical applications like RViz)
ENV DISPLAY=:0

# Expose port (optional if running RViz or other GUI-based tools)
EXPOSE 11311
