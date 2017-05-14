#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.install(){
    local path=${1:-/usr/local/bin}
    local done=1
    bes.echo.title "Installing bes-build ${Coff}in" "$path"

    if [ -f "./bes-build" ]; then
        rm ./bes-build
    fi
    wget -q https://git.pluie.org/meta-tech/bes-build/raw/latest/dist/bes-build
    if [ $? -eq 0 ]; then
        chmod +x ./bes-build
        if [ -d $path ]; then
            sudo mv ./bes-build $path/bes-build
            local done=$?
            bes.echo.state $done
        else
            bes.echo.error "install directory do not exists : ${Cspe}$path"
        fi
    else 
        bes.echo.error "can not download latest version of bes-build"        
    fi
    bes.echo.rs $done
}
