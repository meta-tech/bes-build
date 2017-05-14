#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.build(){
    bes.echo.title "building project" "$APP_NAME"
    if [ -d "$APP_DIR/src" ]; then 
        if [ ! -d "$APP_DIR/dist" ]; then
            bes.echo.action "creating dist directory"
            mkdir $APP_DIR/dist
            bes.echo.state $?
        fi
        if [ -f "$APP_BIN" ]; then
            if [ "$1" = "backup" ] || [ "$1" = "-b" ]; then
                bes.echo.action "backup last build to ${Coff}dist/$(date +%y%m%d)-$APP_NAME${Coff}"
                mv $APP_BIN $APP_DIR/dist/$(date +%y%m%d)-$APP_NAME
            else
                bes.echo.action "removing ${Coff}dist/$APP_NAME${Coff}"
                rm $APP_BIN
            fi
            bes.echo.state $?
        fi
        echo "#!/bin/bash" > $APP_BIN
        bes.echo.action "reading ${Coff}dependencies"
        for vendor in "$APP_DIR/vendor/*"; do
            if [ "$(basename $vendor)" != "." ] && [ "$(basename $vendor)" != ".." ]; then
                local vendorName="$(basename $vendor)"
                for project in "$vendor/*"; do
                    if [ "$(basename $project)" != "." ] && [ "$(basename $project)" != ".." ]; then
                        for entry in "$project/src"/*.sh; do
                            local vendorName="$(basename $vendor)"
                            local project="$(basename $(dirname $(dirname $entry)))"
                            bes.echo "      ${Cspe}- ${Cok}appending ${Cusa}$vendorName/$project/${Coff}src/$(basename $entry)"
                            tail -n +2 "$APP_DIR/vendor/$vendorName/$project/src/$(basename $entry)" >> "$APP_BIN"
                        done
                    fi
                done
            fi
        done
        bes.echo.state 0
        
        bes.echo.action "reading ${Coff}src/"
        for entry in "$APP_DIR/src"/*.sh; do
            if [ "$(basename $entry)" != "main.sh" ]; then
                bes.echo "      ${Cspe}- ${Cok}appending ${Coff}src/$(basename $entry)"
                tail -n +2 "$entry" >> "$APP_BIN"
            fi
        done
        if [ -f "$APP_DIR/src/main.sh" ]; then
            tail -n +2 "$APP_DIR/src/main.sh" >> "$APP_BIN"
            bes.echo "      ${Cspe}- ${Cok}appending ${Coff}src/main.sh"
        fi
        bes.echo.state 0
        bes.echo.action "set execution mode"
        chmod +x $APP_BIN
        done=$?
        bes.echo.state $done
        bes.echo.rs $done
    else
        bes.echo.error "no src/ directory. exit"
        bes.echo.state 1
    fi
}
