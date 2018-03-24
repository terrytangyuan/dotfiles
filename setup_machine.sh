#!/bin/bash

# Install Softwares
bash install/all.sh

# Copy Configurations and helper scripts
cp atom/* ~/.atom/
cp bin/* /usr/local/bin/
cp git/.gitconfig ~/
