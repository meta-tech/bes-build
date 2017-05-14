#!/bin/bash

BES_LIB="echo"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.inlist ()
{
    local rs=1
    if [[ "$2" =~ (^|[[:space:]])"$1"($|[[:space:]]) ]] ; then
        rs=0
    fi
    return $rs
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.update ()
{
    bes.ini $APP_DIR/bes.ini -p bes -b 1

    bes.echo.title "Reading Project" $APP_NAME
    bes.echo.keyval path $APP_DIR
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
    if [ ! -z "${bes_ALL_VARS}" ]; then
        bes.echo.title "Checking Dependencies"
        for name in ${bes_ALL_VARS}; do
            key=${name:${#prefix}+1}
            bes.echo.keyval ${key//_/.} ${!name}
            echo
            local project=${key#*_}
            local vendor=${key%_*}
            local version=${!name}
            
            if [ "$vendor" = "bes" ]; then
                if bes.inlist "$project" "$BES_LIB"; then
                    if [ ! -d "$APP_DIR/vendor/$vendor" ]; then
                        bes.echo.action "creating vendor directory ${Cusa}$vendor"
                        mkdir -p "$APP_DIR/vendor/$vendor"
                    else
                        bes.echo.action "checking vendor directory ${Cusa}$vendor"
                    fi
                    bes.echo.state $?
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
                        git checkout -q -b $version 2>&1 >/dev/null
                    fi
                    bes.echo.state $?
                    for entry in "$APP_DIR/vendor/$vendor/$project/src"/*.sh; do
                        bes.echo "      ${Cspe}- ${Cok}set for autoloading ${Coff}src/$(basename $entry)"
                        # tail -n +2 "$entry" >> "$APP_BIN"
                    done
                    bes.echo.state $?
                fi
            fi
            bes.echo.rs
            
            local req=${!name}
            local path=${req#*:} 
            local repo=${req%:*}
            local repoName=bes_repo_$repo
            local repoVar=${!repoName}
            local src=${!repoName}$path
            #~ echo "$name : ${!name}"
            #~ echo "\$req : ${req}"
            #~ echo "\$repo : ${repo}"
            #~ echo "\$path : ${path}"
            #~ echo "\$repoName : ${repoName}"
            #~ echo "\$repoVar : ${repoVar}"
            #~ echo "\$src : ${src}"
        done
    fi
}
