#!/bin/bash

# Install Softwares
bash install/all.sh

# Copy Configurations and helper scripts
cp atom/* ~/.atom/
sudo mkdir /usr/local/bin
sudo cp bin/* /usr/local/bin/
cp git/.gitconfig ~/
