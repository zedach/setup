#!/bin/bash
# Simple setup.sh 
# for headless setup. 

# Install Homebrew

# Install Command Line Tools for Xcode
# xcode-select --install
# ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

# echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# Install cask 
brew tap phinze/cask
brew install brew-cask

function installcask() {
				brew cask install "${@}" 2> /dev/null
}

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash
# Install wget with IRI support
brew install wget --enable-iri

brew install git
brew install ack
brew install tree
brew install lynx
brew install node
brew install pigz
brew install rename
brew install tree
brew install zopfli
brew install p7zip

# Install dev tools

installcask java

brew install subversion
brew install scala --with-docs

# hacks for scala
# http://scalacookbook.blogspot.fr/2012/09/scala-for-intellij.html
scalaversion="$(brew which scala | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')"

if [ ! -L /usr/local/Cellar/scala/$scalaversion/src ]; then
				ln -s /usr/local/Cellar/scala/$scalaversion/libexec/src /usr/local/Cellar/scala/$scalaversion/src
fi
if [ ! -L /usr/local/Cellar/scala/$scalaversion/lib ]; then
				ln -s /usr/local/Cellar/scala/$scalaversion/libexec/lib /usr/local/Cellar/scala/$scalaversion/lib
fi
if [ ! -d /usr/local/Cellar/scala/$scalaversion/doc/scala-devel-docs ] ; then 
				mkdir -p /usr/local/Cellar/scala/$scalaversion/doc/scala-devel-docs
				ln -s /usr/local/Cellar/scala/$scalaversion/share/doc/scala /usr/local/Cellar/scala/$scalaversion/doc/scala-devel-docs/api
fi

brew install sbt
brew install maven 

#install gvm
curl -s get.gvmtool.net | bash
[[ -s ~/.gvm/bin/gvm-init.sh ]] && source ~/.gvm/bin/gvm-init.sh

gvm install grails 2.3.5
gvm install groovy 

installcask intellij-idea-ultimate

installcask dropbox
installcask google-chrome
# installcask google-chrome-canary
installcask imagealpha
installcask imageoptim
installcask iterm2
# installcask macvim
# installcask miro-video-converter
installcask sublime-text
installcask the-unarchiver
# installcask tor-browser
installcask transmission
installcask ukelele
installcask virtualbox
installcask vlc

brew install elasticsearch
mv /usr/local/bin/plugin /usr/local/bin/elasticsearch-plugin
elasticsearch-plugin --install mobz/elasticsearch-head

# Remove outdated versions from the cellar
brew cleanup

# git pull and install dotfiles as well
cd $HOME
if [ ! -d ~/Projects/ ]; then
				mkdir ~/Projects
fi
if [ -d ~/Projects/dotfiles/ ]; then
    mv ~/Projects/dotfiles ~/Projects/dotfiles.old
fi

git clone https://ze_dach@bitbucket.org/ze_dach/dotfiles.git ~/Projects/dotfiles
cd Projects/dotfiles && source bootstrap.sh

