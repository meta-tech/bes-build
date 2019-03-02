#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.build ()
{
    echo.title "building project" "$APP_NAME"
    if [ -d "$APP_DIR/src" ]; then 
        if [ ! -d "$APP_DIR/dist" ]; then
            echo.action "creating dist directory"
            mkdir $APP_DIR/dist
            echo.state $?
        fi
        if [ -f "$APP_BIN" ]; then
            if [ "$1" = "backup" ] || [ "$1" = "-b" ]; then
                echo.action "backup last build to ${Coff}dist/$(date +%y%m%d)-$APP_NAME${Coff}"
                mv $APP_BIN $APP_DIR/dist/$(date +%y%m%d)-$APP_NAME
            else
                echo.action "removing ${Coff}dist/$APP_NAME${Coff}"
                rm $APP_BIN
            fi
            echo.state $?
        fi
        echo "#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BES_BOOT=
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.exists () { 
    declare -f \$1 > /dev/null
    #~ [ x\$(type -t \$1) = xfunction ]; 
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.boot ()
{
    for fn in \$BES_BOOT; do
        if bes.exists  \$fn.boot; then
            \$fn.boot
        fi
    done
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.reg ()
{
    local sep=\" \"
    if [ -z \"\$BES_BOOT\" ]; then
        sep=\"\"
    fi
    BES_BOOT=\$BES_BOOT\$sep\$1
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" > $APP_BIN
        #~ echo "#!/bin/bash" > $APP_BIN
        echo.action "reading ${Coff}dependencies"
        if [ -d "$APP_DIR/vendor" ]; then
            for vendor in $(ls $APP_DIR/vendor/); do
                if [ "$vendor" != "." ] && [ "$vendor" != ".." ]; then
                    for project in $(ls $APP_DIR/vendor/$vendor/); do
                        if [ "$project" != "." ] && [ "$project" != ".." ]; then
                            for entry in $(ls $APP_DIR/vendor/$vendor/$project/src/); do
                                local entrypath="$APP_DIR/vendor/$vendor/$project/src/$(basename $entry)"
                                if [ -f "$entrypath" ] && [ "${entrypath: -3}" = ".sh" ]; then
                                    tail -n +2 "$entrypath" >> "$APP_BIN"
                                    echo.msg "      ${Cspe}- ${Cok}appending ${Cusa}$vendorName/$project/${Coff}src/$(basename $entry)"
                                fi
                            done
                        fi
                    done
                fi
            done
        else
            echo.msg "     no dependencies, did you forget to run bes-build update ?"
        fi
        echo.state 0
        
        echo.action "reading ${Coff}src/"
        for entry in "$APP_DIR/src"/*.sh; do
            if [ "$(basename $entry)" != "main.sh" ]; then
                echo.msg "      ${Cspe}- ${Cok}appending ${Coff}src/$(basename $entry)"
                tail -n +2 "$entry" >> "$APP_BIN"
            fi
        done
        echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.boot" >> "$APP_BIN"
        if [ -f "$APP_DIR/src/main.sh" ]; then
            tail -n +2 "$APP_DIR/src/main.sh" >> "$APP_BIN"
            echo.msg "      ${Cspe}- ${Cok}appending ${Coff}src/main.sh"
        fi
        echo.state 0
        echo.action "set execution mode"
        chmod +x $APP_BIN
        done=$?
        echo.state $done
        echo.rs $done
    else
        echo.error "no src/ directory. exit"
        echo.state 1
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.build.install ()
{
    local path="/usr/share/bes/colors.ini"
    if [ ! -f "$path" ]; then
        local dir=$(dirname "$path")
        if [ ! -d "$dir" ]; then
            echo.action "Creating default bes share dir" "$Cspe$dir$Cofff"
            sudo mkdir -p "$dir"
            echo.state $?
        fi
        echo.action "Installing default colors file" "$Cspe$path$Cofff"
        local tmp=$(mktemp)
        echo "[set]
#           background    foreground
#           R   G   B      R   G   B
head     =  53 114 160    195 223 255
headsep  =  53 114 160    252 212 102

[bg]
#           background
#           R   G   B
done     =  63 172 138
fail     = 172  63  85

[fg]
#           foreground
#           R   G   B
title    = 133  92 181
headline =  22  74 133
sep      =  80  80  80
err      = 194  48  64
val      = 255 175  95
key      =  40 168 134
action   = 106 183 241 
symbol   = 255 175  95
item     =  92 147 181
usa      = 255 172   0
spe      = 255 214 166
opt      =  94 215 255
com      = 175 135 175
text     =   0 132 101
meta     =  39 100 170" > "$tmp"
        sudo mv "$tmp" "$path"
        echo.state $?
    else
        echo.action "Installing default colors file" "$Cspe$path$Cofff"
        echo.error "file already exists, do not rewrite."
        echo.state 1
    fi
}
