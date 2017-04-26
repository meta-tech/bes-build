#!/bin/bash

BES_BUILD_VERSION=0.2

bes.title 'bes-build' $BES_BUILD_VERSION

  APP_DIR=$(pwd)
 APP_NAME=$(basename $(pwd)) 
  APP_BIN=$APP_DIR/dist/$APP_NAME

echo
bes.echo " ${Cspe}building project ${Copt}$APP_NAME${Coff}" 0
echo
if [ -d "$APP_DIR/src" ]; then 
    if [ ! -d "$APP_DIR/dist" ]; then
        bes.echo.action "creating dist directory"
        mkdir $APP_DIR/dist
        bes.echo.state $?
    fi
    if [ -f "$APP_BIN" ]; then
        bes.echo.action "removing ${Coff}dist/$APP_NAME${Coff}"
        rm $APP_BIN
        bes.echo.state $?
    fi
    echo "#!/bin/bash" > $APP_BIN
    bes.echo.action "reading ${Coff}src/"
    for entry in "$APP_DIR/src"/*.sh; do
        bes.echo "      - appending ${Coff}src/$(basename $entry)"
        tail -n +2 "$entry" >> "$APP_BIN"
    done
    bes.echo.state 0
    bes.echo.action "set execution mode"
    chmod +x $APP_BIN
    bes.echo.state $?
else
    bes.echo.error "no src/ directory. exit"
    bes.echo.state 1
fi
echo
