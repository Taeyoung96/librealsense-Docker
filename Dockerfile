FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu18.04
RUN apt-get update -y
RUN apt install -y wget software-properties-common apt-utils  curl git
RUN /bin/bash  -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'

RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt clean -y && apt update -y

RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE

RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo bionic main" -u

RUN apt-get update -y
ENV TZ=Asia/Seoul

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata git curl cmake wget mc mlocate
RUN DEBIAN_FRONTEND="noninteractive" apt install -y ros-melodic-desktop clang-format ros-melodic-desktop-full python-pip python3-pip  python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential 
RUN apt update -y
RUN apt install -y ros-melodic-ddynamic-reconfigure
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN rm -rf /var/lib/apt/lists

WORKDIR /home/nvidia/catkin_ws

RUN cd ..
RUN wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.47.0.tar.gz && tar -xvf v2.47.0.tar.gz

RUN cd librealsense-2.47.0/ && mkdir build && cd build &&  cmake ../ -DFORCE_RSUSB_BACKEND=true -DBUILD_PYTHON_BINDINGS=true -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_WITH_CUDA=true -DBUILD_GRAPHICAL_EXAMPLES=true && make -j8 && make install

# set environment variables
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
