#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# @author   a-Sansara - https://git.pluie.org/meta-tech/bes-build
# @app      bes-build
# @license  GNU GPL v3
# @date     2017-06-16 04:38:52 CET
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      BES_VERSION=0.13
         BES_NAME="bes-build"
          BES_URL="https://git.pluie.org/meta-tech/$BES_NAME/raw/latest/dist/$BES_NAME"
          APP_DIR=$(pwd)
         APP_NAME=$(basename $(pwd))
          APP_BIN=$APP_DIR/dist/$APP_NAME

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.main ()
{
    if   [ "$1" = "version" ] || [ "$1" = "-v" ]; then
        echo $BES_VERSION
    else
        echo.app "$BES_NAME" "$BES_VERSION"
        echo
        enusage=0
        if   [ "$1" = "install" ] || [ "$1" = "-i" ]; then
            bes.install "$BES_NAME" "$BES_URL" "$2" "bes.build.install"
        elif [ "$1" = "help" ] || [ "$1" = "-h" ]; then
            enusage=1
        elif [ "$1" = "update" ] || [ "$1" = "-u" ]; then
            bes.update
        elif [ "$1" = "new" ] || [ "$1" = "-n" ]; then
            if [ ! -z "$2" ]; then
                bes.build.new $2
            else
                enusage=1
            fi
        elif [ "$1" = "require" ] || [ "$1" = "-r" ]; then
            if [ ! -z "$2" ]; then
                bes.build.require $2
            else
                enusage=1
            fi
        elif [ -z "$1" ] || [ "$1" = "backup" ] || [ "$1" = "-b" ]; then
            bes.build "$1"
        fi
        if [ "$enusage" = "1" ]; then
            bes.usage
        fi
        echo
    fi
}
bes.main $*
