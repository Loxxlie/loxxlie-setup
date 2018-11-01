#!/bin/bash

# Some dependancies (Erlang, Python 3.7)
sudo apt-get install -y make automake build-essential autoconf gcc wget curl \
zlib1g-dev libffi-dev bzip2 zlib1g-dev libncurses5-dev libbz2-dev libssl-dev \
libreadline-dev libsqlite3-dev llvm libncursesw5-dev xz-utils tk-dev \
liblzma-dev

# Add Visual Studio Code Repo
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# == Repositories with tools we want ==
# evm
git clone git@github.com:robisonsantos/evm.git ~/.evm
~/.evm/install
echo "source $HOME/.evm/scripts/evm" >> ~/.bash_tool_init
source $HOME/.evm/scripts/evm
evm install OTP_21.1
evm default OTP_21.1

# kiex
\curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s
echo 'test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"' >> ~/.bash_tool_init
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
kiex install 1.7.4
kiex default 1.7.4

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_tool_init
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_tool_init
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_tool_init
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
pyenv install 3.7.0

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code vlc git unrar virtualbox virtualbox-ext-pack npm