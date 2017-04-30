#!/bin/bash

BES_BUILD_VERSION=0.2
          APP_DIR=$(pwd)
         APP_NAME=$(basename $(pwd)) 
          APP_BIN=$APP_DIR/dist/$APP_NAME

bes.main(){
    bes.title 'bes-build' $BES_BUILD_VERSION
    echo
    if   [ "$1" = "install" ]; then
        bes.install
    elif [ -z "$1" ]; then
        bes.build "$1"
    fi
}

bes.main $*
