# librealsense-Docker


## Docker Image information  

- Base image : [nvidia/cuda:11.2.2-cudnn8-devel-ubuntu18.04](https://hub.docker.com/r/nvidia/cuda)  
- Ubuntu version : 18.04  
- CUDA : 11.2  
- cuDNN : 8.1  
- ROS : Melodic  
- IntelRealSense lib : [v2.47](https://github.com/IntelRealSense/librealsense/releases/tag/v2.47.0)  

## Quick start  
```
docker pull tyoung96/realsense-ros1-cuda:latest  
```

When you want to use realsense with ROS, you should have [realsense-ros](https://github.com/IntelRealSense/realsense-ros/releases/tag/2.3.0) in `catkin_ws/` folder.  
I use 2.3.0 version.  

You could use other version.  


In your local computer, you could clone [realsense-ros](https://github.com/IntelRealSense/realsense-ros/releases/tag/2.3.0), and use `--volume` option.  

```
nvidia-docker run -it --net=host --runtime nvidia -e DISPLAY=$DISPLAY \
--privileged --ipc=host -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /tmp/argus_socket:/tmp/argus_socket \
--volume=/dev:/dev -v [Absolute PATH for realsense-ros]:/home/nvidia/catkin_ws/src \
--cap-add SYS_PTRACE --name realsense_d455 ros1-realsense-cuda:latest /bin/bash
```

On your docker container, after changing the path to `catkin_ws/` and build your [realsense-ros](https://github.com/IntelRealSense/realsense-ros/releases/tag/2.3.0)
```
root@taeyoung:/home/nvidia/catkin_ws# sudo apt-get install ros-melodic-realsense2-camera
root@taeyoung:/home/nvidia/catkin_ws# sudo apt-get install ros-melodic-realsense2-description
root@taeyoung:/home/nvidia/catkin_ws# catkin_make clean
root@taeyoung:/home/nvidia/catkin_ws# catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
root@taeyoung:/home/nvidia/catkin_ws# catkin_make install
root@taeyoung:/home/nvidia/catkin_ws# echo "source /home/nvidia/catkin_ws/devel/setup.bash" >> ~/.bashrc
root@taeyoung:/home/nvidia/catkin_ws# source ~/.bashrc
```   

When you are done, you could test your realsense camera!    
```
roslaunch realsense2_camera rs_camera.launch
```

## Result  




