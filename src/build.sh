#!/bin/bash

bes.build(){
    bes.echo.title "building project" "$APP_NAME"
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
            if [ "$(basename $entry)" != "main.sh" ]; then
                bes.echo "      - appending ${Coff}src/$(basename $entry)"
                tail -n +2 "$entry" >> "$APP_BIN"
            fi
        done
        if [ -f "$APP_DIR/src/main.sh" ]; then
            tail -n +2 "$APP_DIR/src/main.sh" >> "$APP_BIN"
            bes.echo "      - appending ${Coff}src/main.sh"
        fi
        bes.echo.state 0
        bes.echo.action "set execution mode"
        chmod +x $APP_BIN
        bes.echo.state $?
    else
        bes.echo.error "no src/ directory. exit"
        bes.echo.state 1
    fi
    echo
}