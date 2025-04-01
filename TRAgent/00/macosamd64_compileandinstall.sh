#!/bin/bash

which -s brew
if [[ $? != 0 ]] ; then    
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    /usr/local/bin/brew update
    /opt/homebrew/bin/brew update
fi

/usr/local/bin/brew install golang
/opt/homebrew/bin/brew install golang

git clone https://github.com/amidaware/rmmagent.git

cd rmmagent

xcode-select --install

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w" -o ./rmmagent-macos-amd64

chmod +x rmmagent-macos-amd64

sudo ./rmmagent-macos-amd64 -m install --api https://api.fegroup.it --client-id 1 --site-id 5 --agent-type workstation --auth da5b1220c52e454a53f5c78bde5b177754c2db71717172bccc4871c27638c9f1 --ping