#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

apps=(
    bash-completion2
    coreutils
    moreutils
    findutils
    git
    grep --with-default-names
    imagemagick --with-webp
    ffmpeg
    python
    python3
    source-highlight
    wget
    thefuck
    jq
    gradle
    go
    maven
    sbt
    gradle
    shellcheck
    postgresql
    gcc
    kubectl
    node
    yarn
    pkg-config
    cmake
    qt
    docker
    hunspell
    poppler --with-qt --enable-xpdf-headers
    glances
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup

# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

apps=(
    atom
    pycharm-ce
    docker
    docker-machine
    virtualbox
    intellij-idea
    minikube
)

brew cask install "${apps[@]}"

# JVM
brew cask install java
brew install scala

# Install R and RStudio
brew cask install xquartz
brew tap homebrew/science
brew install --with-x11 r
brew cask install --appdir=/Applications rstudio

# Tex
brew cask install basictex
git clone https://github.com/TeXworks/texworks.git
cd texworks; mkdir build; cd build; cmake ..; make; make install; cd ../..

# Misc
gem install jekyll jekyll-paginate
npm install -g typescript

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package
