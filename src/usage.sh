#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.usage ()
{
    echo -e "     ${Cusa}Usage :${Coff}\n
    ${Ccom}\tBuild current project (overwrite existing build)
    ${Cspe}\t$APP_NAME  ${Copt}
    ${Ccom}\tBuild current project and backup existing build
    ${Cspe}\t$APP_NAME  ${Copt}-b${Ctext}, ${Copt}backup
    ${Ccom}\tInstall or update $APP_NAME on specified BINDIR directory or in /usr/local/bin directory
    ${Cspe}\t$APP_NAME  ${Copt}-i${Ctext}, ${Copt}install        ${Copt}[ ${Ctext}BINDIR${Copt} ]
    ${Ccom}\tDisplay program version
    ${Cspe}\t$APP_NAME  ${Copt}-v${Ctext}, ${Copt}version
    ${Ccom}\tDisplay this help
    ${Cspe}\t$APP_NAME  ${Copt}-h${Ctext}, ${Copt}help"

    echo -e "${Coff}"
}
