#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.install ()
{
    local  app=${1}
    local  url=${2}
    local path=${3:-/usr/local/bin}
    local done=1
    bes.echo.title "Installing $app ${Coff}in" "$path"

    if [ -f "./$app" ]; then
        rm ./$app
    fi
    wget -q $url
    if [ $? -eq 0 ]; then
        chmod +x ./$app
        if [ -d $path ]; then
            sudo mv ./$app $path/$app
            local done=$?
            bes.echo.state $done
        else
            bes.echo.error "install directory do not exists : ${Cspe}$path"
        fi
    else 
        bes.echo.error "can not download latest version of app $app. please check url : $url"        
    fi
    bes.echo.rs $done
}
