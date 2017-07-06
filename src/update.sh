#!/bin/bash

BES_LIB="echo install ini"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.inlist ()
{
    local rs=1
    if [[ "$2" =~ (^|[[:space:]])"$1"($|[[:space:]]) ]] ; then
        rs=0
    fi
    return $rs
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.update ()
{
    bes.echo.title "Reading Project" $APP_NAME
    bes.echo.keyval path $APP_DIR

    if [ -f $APP_DIR/bes.ini ]; then
        bes.ini $APP_DIR/bes.ini -p bes -b 1

        local keys="vendor name version license author"
        local value=""
        for key in $keys; do
            value="bes_project_$key"
            if [ ! -z "${!value}" ]; then
                bes.echo.keyval $key "${!value}"
            fi
        done

        bes.ini "$APP_DIR/bes.ini" require -p bes -b 1
        local prefix="bes_require"
        local key=""
        local bescheck=1;
        if [ ! -z "${bes_ALL_VARS}" ]; then
            bes.echo.title "Checking Dependencies"
            for name in ${bes_ALL_VARS}; do
                key=${name:${#prefix}+1}
                bes.echo.keyval ${key//_/.} ${!name}
            done
            echo
            for name in ${bes_ALL_VARS}; do
                key=${name:${#prefix}+1}
                bes.echo.title "Loading" "${key//_/.}${Cusa} ${!name}${Coff}"
                local project=${key#*_}
                local vendor=${key%_*}
                local version=${!name}
                bes.inlist "$project" "$BES_LIB"
                if [ "$vendor" = "bes" ]; then
                    if bes.inlist "$project" "$BES_LIB"; then
                        if [ "$bescheck" = "1" ]; then
                            if [ ! -d "$APP_DIR/vendor/$vendor" ]; then
                                bes.echo.action "creating vendor directory ${Cusa}$vendor"
                                mkdir -p "$APP_DIR/vendor/$vendor"
                            else
                                bes.echo.action "checking vendor directory ${Cusa}$vendor"
                            fi
                            bes.echo.state $?
                            bescheck=0
                        fi
                        cd "$APP_DIR/vendor/$vendor"
                        bes.echo.action "updating repository $Cusa$vendor.$project ${Coff}:$Cusa $version"
                        if [ ! -d "$project" ]; then
                            git clone -q "https://git.pluie.org/meta-tech/$vendor-$project" "$project" 2>&1 >/dev/null
                            #~ bes.echo.state $?
                            cd $project
                        else
                            cd $project
                            git fetch --all -q 2>&1 >/dev/null
                            #~ bes.echo.state $?
                        fi
                        #~ bes.echo.action "checkout to version $Cusa$version"
                        local branch=$(git branch --no-color | grep \* | cut -d ' ' -f2-)
                        # branch=${branch:5: -3}
                        if [ "$branch" != "$version" ]; then
                            git checkout -q $version 2>&1 >/dev/null
                        fi
                        bes.echo.state $?
                        for entry in "$APP_DIR/vendor/$vendor/$project/src"/*.sh; do
                            bes.echo "      ${Cspe}- ${Cok}set for autoloading ${Coff}src/$(basename $entry)"
                            # tail -n +2 "$entry" >> "$APP_BIN"
                        done
                        bes.echo.state $?
                    fi
                else
                    if [ ! -d "$APP_DIR/vendor/$vendor" ]; then
                        bes.echo.action "creating vendor directory ${Cusa}$vendor"
                        mkdir -p "$APP_DIR/vendor/$vendor"
                        bes.echo.state $?
                    fi
                    if [ "${version:0:4}" = "http" ]; then
                        local req=${!name}
                        local path=${req#*:} 
                        local  tag=${req##*:} 
                        local repo=${req%:*}
                        echo "$APP_DIR/vendor/$vendor/$project"
                        echo $(pwd)
                        if [ ! -d "$APP_DIR/vendor/$vendor/$project" ]; then
                            mkdir "$APP_DIR/vendor/$vendor"
                            cd $_
                            git clone $repo $project
                        fi
                        cd "$APP_DIR/vendor/$vendor/$project"
                        git checkout $tag
                        for entry in "$APP_DIR/vendor/$vendor/$project/src"/*.sh; do
                            bes.echo "      ${Cspe}- ${Cok}set for autoloading ${Coff}src/$(basename $entry)"
                            # tail -n +2 "$entry" >> "$APP_BIN"
                        done
                        bes.echo.state $?
                    fi
                fi
                bes.echo.rs
            done
        fi
    else
        echo
        bes.echo '    no bes.ini file for your project'
        bes.echo.state
    fi
}
