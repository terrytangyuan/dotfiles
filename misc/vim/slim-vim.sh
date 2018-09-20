#!/bin/bash - 
# Make a slim version of vim settings

work_dir="/tmp/vim-slim"
tar_file="/tmp/vim-slim.tar.gz"

mkdir -p $work_dir/vim
cp -r ./* $work_dir/vim/

pushd $work_dir/vim

# Remove the plugins, who need to build
rm -rf bundle/YouCompleteMe

# Remove the large git files
find . -name .git | xargs -t -I '{}' rm -rf '{}'

popd

# Make the tar ball
tar -zc -C $work_dir -f $tar_file vim

# Clean
rm -rf $work_dir
