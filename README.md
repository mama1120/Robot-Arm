# Robot Arm Moveit Container

## Exercise 1: setup your environment and run example
1. Navigate to the directory where the dockerfile is saved.
2. Build and run container by running the script:

```bash
./start_docker.sh
```

If the shell script cannot be run, try making it an executable:

```bash
chmod +x start_docker.sh
```

3. Start robot driver and visualization

```bash
ros2 launch robot_moveit_config demo.launch.py
```

This should open up RViz and you should see the robot model.
You can play around with MoveIt! and the robot should move in the visualization.

4. To run the example application, open a new terminal and connect to running container

```bash
docker exec -it ros2_moveit_container /bin/bash
```

5. Build workspace

```bash
colcon build
```

6. Source workspace

```bash
source install/setup.bash
```

7. Run example

```bash
ros2 run robot_control multiple_positions
```

## Debugging Network

To check the connection to the raspberry pi via TCP, use netcat with. To install it, use:

```bash
apt-get update && apt-get install -y netcat
```

Check the port and IP address by sending a message:

```bash
nc -zv 10.42.0.128 12345
```

Another tool to check if there is a connection, is to simply use ping. Install ping:

```bash
apt-get update -y
apt-get install -y iputils-ping
```

Ping the other end, by using the receiver's IP Address

```bash
ping 10.42.0.128
```
