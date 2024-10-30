#!/bin/bash -e

_echo() {
    echo "---"
    echo $1
}

# Golang
GO_VERSION=1.21.3
GOROOT=$HOME/go 
GOBIN=$GOROOT/bin
GOSRC_GITHUB=$GOROOT/src/github.com

GO_DIRS=($GOROOT $GOBIN $GOSRC_GITHUB)
for DIR in "${GO_DIRS[@]}"
do
    echo "Creating $DIR"
    mkdir -p $DIR
done

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
   OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
   OS="darwin"
else
    echo "not supportted OS: $OSTYPE"
	exit 1
fi

GO_PACKAGE=go$GO_VERSION.$OS-amd64.tar.gz
GO_PACKAGE_URL=https://go.dev/dl/$GO_PACKAGE

TEMP_DIR=/tmp/install-golang
mkdir -p $TEMP_DIR
cd $TEMP_DIR
    
_echo "Downloading Go Archive: $GO_PACKAGE_URL"
if [ ! -e "$GO_PACKAGE" ]; then
    curl -LO $GO_PACKAGE_URL
    echo "File downloaded successfully."
else
    echo "File already exists locally. No need to download."
fi


_echo "Remove any previous Go installation"
sudo rm -rf /usr/local/go

_echo "Extract the Go archive into /usr/local, creating a fresh Go tree in /usr/local/go"
sudo tar -C /usr/local -xzf $GO_PACKAGE

SHELL_PROFILE=$HOME/.profile
BASH_RC=$HOME/.bashrc
ZSH_RC=$HOME/.zshrc

files=($SHELL_PROFILE $BASH_RC $ZSH_RC)
for file in "${files[@]}"
do
    if [ -e "$file" ]; then
        _echo "Found: $file"
        echo "Adding /usr/local/go/bin to PATH for: $file"
        if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" $file; then
            # If the line doesn't exist, append it to the file
            echo "" >> $file
            echo "# Golang" >> $file
            echo "export GOROOT=\$HOME/go" >> $file
            echo "export GOBIN=\$GOROOT/bin" >> $file
            echo "export PATH=$GOROOT/bin:\$PATH # All commands installed by 'go install' are here." >> $file
            echo "export PATH=\$PATH:/usr/local/go/bin # Bin binary is install in default location." >> $file
            echo "" >> $file
            echo "It's added to $file"
        else
            # If the line already exists, print a message
            echo "It's already exists in $file"
        fi
    fi
done

source $SHELL_PROFILE

_echo "Verify we've installed Go"
echo "Run 'go version': $(go version)"
