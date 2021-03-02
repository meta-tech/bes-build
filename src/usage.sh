#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.usage ()
{
    echo -e "     ${Cusa}Usage :${Coff}\n
    ${Ccom}\tCreate new bes project
    ${Cspe}\t$BES_NAME  ${Copt}-n${Ctext}, ${Copt}new            ${Copt}[ ${Ctext}PROJECT_NAME${Copt} ]
    ${Ccom}\tUpdate current project dependencies
    ${Cspe}\t$BES_NAME  ${Copt}-u${Ctext}, ${Copt}update
    ${Ccom}\tBuild current project (overwrite existing build)
    ${Cspe}\t$BES_NAME  ${Copt}
    ${Ccom}\tBuild current project and backup existing build
    ${Cspe}\t$BES_NAME  ${Copt}-b${Ctext}, ${Copt}backup
    ${Ccom}\tInstall or update $APP_NAME on specified BINDIR directory or in /usr/local/bin directory
    ${Cspe}\t$BES_NAME  ${Copt}-i${Ctext}, ${Copt}install        ${Copt}[ ${Ctext}BINDIR${Copt} ]
    ${Ccom}\tDisplay program version
    ${Cspe}\t$BES_NAME  ${Copt}-v${Ctext}, ${Copt}version
    ${Ccom}\tDisplay this help
    ${Cspe}\t$BES_NAME  ${Copt}-h${Ctext}, ${Copt}help"

    echo -e "${Coff}"
}
