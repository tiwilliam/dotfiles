#!/bin/bash

TMP_DIR="/tmp/tiwilliam-dotfiles"
GIT_URL="https://github.com/tiwilliam/dotfiles.git"

# OS specific stuff
case $(uname) in
    Darwin)
        BASH_CONFIG=".profile"
        INSTALL_DIR="/Users/${USER}"
    ;;
    *)
        BASH_CONFIG=".bashrc"
        INSTALL_DIR="${HOME}"
esac

# Are you sure?
read -p "This may overwrite existing files in ${INSTALL_DIR}. Are you sure? (y/n) " -n 1
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting."
    exit 1
fi

# Get latest files
if [ -d "${TMP_DIR}" ]; then
    pushd ${TMP_DIR}
        git pull
        git submodule init
        git submodule update
    popd
else
    git clone ${GIT_URL} ${TMP_DIR}
    pushd ${TMP_DIR}
        git submodule init
        git submodule update
    popd
fi

install -m 644 ${TMP_DIR}/vimrc ${INSTALL_DIR}/.vimrc
install -m 644 ${TMP_DIR}/bashrc ${INSTALL_DIR}/${BASH_CONFIG}
install -m 644 ${TMP_DIR}/gitconfig ${INSTALL_DIR}/.gitconfig

rm -rf ${INSTALL_DIR}/.vim
cp -r ${TMP_DIR}/vim ${INSTALL_DIR}/.vim
