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
    shellcheck
    postgresql
    cmake
    gcc
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup

# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

apps=(
    iterm2
    atom
    google-chrome
    slack
    pycharm-ce
    java
    docker
    intellij-idea
)

brew cask install "${apps[@]}"

# Install R and RStudio
brew cask install xquartz
brew tap homebrew/science
brew install --with-x11 r
brew cask install --appdir=/Applications rstudio

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package
