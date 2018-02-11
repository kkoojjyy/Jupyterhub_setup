#!/bin/bash

# Download and install anaconda 

curl -O https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh
sh Anaconda3-5.0.0.1-Linux-x86_64.sh

# Add anaconda into PATH
echo 'export PATH=/opt/anaconda3/bin:$PATH' > /etc/profile.d/anaconda.sh
source /etc/profile.d/anaconda.sh

# Create Virtual Env of python 2.7 and python 3.6
conda create -n py27 python=2.7 ipykernel
conda create -n py36 python=3.6 ipykernel

# Add python env into jupyter kernel
cp -r kernels/python2 /opt/anaconda3/share/jupyter/kernels/
cp -r kernels/python3 /opt/anaconda3/share/jupyter/kernels/
