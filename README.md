
# Robot Arm MoveIt2 Container

This project provides a environment for simulating and controlling a robotic arm using ROS2 Humble and MoveIt2.
---

## Development Environment

- **Operating System**: Ubuntu 22.04.5 LTS
- **Frameworks**: ROS2 Humble, MoveIt2 Humble
- **Tools**: Docker, Git
- **Additional Hardware**: 
  - Raspberry Pi 4 (8 GB)

- **GPU Note**: 
  - NVIDIA GPUs (graphical performance may not be optimal on NVIDIA setups due to X11 forwarding limitations). Further Packages needed.
---

## Requirements

Before you begin, ensure you have the following installed:
- [Docker](https://docs.docker.com/get-docker/) (version 20.10 or later)
- [Git](https://git-scm.com/)
---

## Cloning the Repository

To get started, clone the repository to your local machine:

```bash
git clone <https://github.com/mama1120/robot-arm.git>
```
---

## Building the Docker Image

1. **Navigate** to the directory where the `Dockerfile` is saved.

2. **Build the container** using the provided shell script. This step is required only once:
   ```bash
   ./build_docker.sh
   ```

   If the script cannot be executed, make it an executable:
   ```bash
   chmod +x build_docker.sh
   ```

## Running the Container

3. **Start the container** using the shell script:
   ```bash
   ./start_docker.sh
   ```
---

## Running the Graphical UI
Once Inside of the Container:

4. **Build the workspace**:
   ```bash
   colcon build
   ```

5. **Source the workspace**:
   ```bash
   source install/setup.bash
   ```

6. **Start the robot driver and visualization**:
   ```bash
   ros2 launch robot_moveit_config demo.launch.py
   ```

   This should open up RViz, and you should see the robot model. You can play around with MoveIt2, and the robot should move in the visualization.

## Running the Demo
7. **To run the demo application**, open a new terminal and connect to the running container:
   ```bash
   docker exec -it ros2_moveit_container /bin/bash
   ```

8. **Source the workspace**:
   ```bash
   source install/setup.bash
   ```
9. **Run the demo**:
   ```bash
   ros2 run robot_control multiple_positions
   ```

---

## Debugging Network

To check the connection to the Raspberry Pi via TCP, use netcat. To install it, use:

```bash
apt-get update && apt-get install -y netcat
```

Check the port and IP address by sending a message:

```bash
nc -zv 10.42.0.128 12345
```

Another tool to check if there is a connection is to use ping. Install ping:

```bash
apt-get update -y
apt-get install -y iputils-ping
```

Ping the other end using the receiver's IP Address:

```bash
ping 10.42.0.128
```

---