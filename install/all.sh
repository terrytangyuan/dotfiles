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
    github/gh/gh
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
    dep
    etcd
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
    k3d
    hunspell
    poppler --with-qt --enable-xpdf-headers
    glances
    zsh
    libgit2
    qpdf
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup

apps=(
    atom
    sublime-text
    pycharm-ce
    docker
    docker-machine
    virtualbox
    intellij-idea
    iterm2
)

brew cask install "${apps[@]}"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# JVM
brew cask install java
brew install scala

# Install R and RStudio
brew install xquartz r
brew install --appdir=/Applications rstudio

# Go
## GVM
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# Tex
brew cask install basictex
git clone https://github.com/TeXworks/texworks.git
cd texworks; mkdir build; cd build; cmake ..; make; make install; cd ../..

# Misc
gem install jekyll jekyll-paginate
npm install -g typescript

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package
