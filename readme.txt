Docker robot_ws

Copy the contents of robot_ws, as well as ws_moveit2 to the same folder as the one found in the Dockerfile

To use graphical interfaces, use outside of the container:

xhost +local:docker

To build the container (only one time):

docker build -t ros2-moveit:v1.2 .

To run the container use:

docker run --network host -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ros2-moveit:v1.2



To open a new terminal in the same container (container id, is probably differen):

docker exec -it 9851f5a86a9f /bin/bash



To run the robot model:

ros2 launch robot_moveit_config demo.launch.py

ros2 run robot_control send_all_joints


For debugging:

Install netcat:

apt-get update && apt-get install -y netcat

(docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -p 12345:12345 ros2-moveit:v1.2)

check port by sending a message:

nc -zv 10.42.0.128 12345

Install ping:

```bash
apt-get update -y
apt-get install -y iputils-ping
```

ping 10.42.0.128
