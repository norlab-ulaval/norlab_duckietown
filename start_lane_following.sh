#!/bin/bash

# Exporting ROS MASTER to laptop
export ROS_MASTER_URI="http://duckienorlab1.local:11311"


# Setting linear speed and turning speed to low values as a compensation for low framerate
rosparam set /duckienorlab1/kinematics_node/v_max 0.1
rosparam set /duckienorlab1/kinematics_node/omega_max 1.8

echo -e "---------------------LANE FOLLOWING DEMO----------------------\n\nLinear speed (v_max) set to 0.1, turning speed (omega_max) set to 1.8"

# Starting the demo in a screen
screen -d -m dts duckiebot demo --demo_name lane_following --duckiebot_name duckienorlab1 --package_name duckietown_demos --debug

echo "Starting demo ... (5 min)"
sleep 300

# Setting the resolution to 160x120 instead of 640x480
rosparam set /duckienorlab1/camera_node/res_w 160
rosparam set /duckienorlab1/camera_node/res_h 120

echo "Starting joystick ..."

# Starting the joystick interface in a screen
screen -d -m dts duckiebot keyboard_control duckienorlab1

echo -e "Press "a" to begin lane following, "s" to stop it.\nPress "q" to exit the joystick interface\n"


sleep 3

echo -e "To stop the demo, kill the demo container via Portainer or run <docker stop demo_lane_following> on the robot.\nWARNING : Resolution is set at 160x120. After closing the demo, reboot the robot or run <rosparam set /duckienorlab1/camera_node/res_w 160> and <rosparam set /duckienorlab1/camera_node/res_h 120>\n\nDemo initialization finished"

sleep 3

