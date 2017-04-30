#!/bin/bash

BES_BUILD_VERSION=0.3
          APP_DIR=$(pwd)
         APP_NAME=$(basename $(pwd)) 
          APP_BIN=$APP_DIR/dist/$APP_NAME

bes.main(){
    if   [ "$1" = "version" ]; then
        echo $BES_BUILD_VERSION
    else
        bes.title 'bes-build' $BES_BUILD_VERSION
        echo
        if   [ "$1" = "install" ]; then
            bes.install $2
        elif [ -z "$1" ] || [ "$1" = "-s" ]; then
            bes.build "$1"
        fi
        echo
    fi
}

bes.main $*
