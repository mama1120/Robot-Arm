# Start from the official ROS2 Humble MoveIt2 image
FROM moveit/moveit2:humble-source

# Install moveit_msgs and other ROS dependencies
RUN apt-get update && apt-get install -y \
    ros-humble-moveit-msgs \
    ros-humble-moveit-core \
    ros-humble-graph-msgs  \
    ros-humble-rviz-visual-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy only the src folder from your host ROS2 workspace to the container
COPY robot_ws/src /root/ros2_ws/src/

# Copy MoveIt2 workspace into the container
COPY ws_moveit2 /root/ws_moveit2

# Set the working directory to the ROS2 workspace
WORKDIR /root/ros2_ws/

# Source the setup scripts of ROS2 and MoveIt2, and build the ROS2 workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    source /root/ws_moveit2/install/setup.bash && \
    colcon build"

# Source the ROS2 setup script for the environment
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

# Set environment variable for X11 display (optional, can be set when running the container)
ENV DISPLAY=:0
    
