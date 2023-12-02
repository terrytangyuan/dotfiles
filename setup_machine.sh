#!/bin/bash

# Copy Configurations and helper scripts
sudo mkdir /usr/local/bin
sudo cp bin/* /usr/local/bin/
cp git/.gitconfig ~/

# Install Softwares
bash install/all.sh
