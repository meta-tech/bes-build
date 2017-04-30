#!/bin/bash

BES_BUILD_VERSION=0.4
          APP_DIR=$(pwd)
         APP_NAME=$(basename $(pwd)) 
          APP_BIN=$APP_DIR/dist/$APP_NAME

bes.main(){
    if   [ "$1" = "version" ] || [ "$1" = "-v" ]; then
        echo $BES_BUILD_VERSION
    else
        bes.title 'bes-build' $BES_BUILD_VERSION
        echo
        if   [ "$1" = "install" ] || [ "$1" = "-i" ]; then
            bes.install "$2"
        elif [ "$1" = "help" ] || [ "$1" = "-h" ]; then
            bes.usage
        elif [ -z "$1" ] || [ "$1" = "backup" ] || [ "$1" = "-b" ]; then
            bes.build "$1"
        fi
        echo
    fi
}
bes.main $*
