#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.usage(){
    echo -e "     ${Cusa}Usage :${Coff}\n
    ${Ccom}\tBuild current project (overwrite existing build)
    ${Cspe}\tbes-build  ${Copt}
    ${Ccom}\tBuild current project and backup existing build
    ${Cspe}\tbes-build  ${Copt}-b${Ctext}, ${Copt}backup
    ${Ccom}\tInstall or update bes-build on specified BINDIR directory or in /etc/local/bin directory
    ${Cspe}\tbes-build  ${Copt}-i${Ctext}, ${Copt}install        ${Copt}[ ${Ctext}BINDIR${Copt} ]
    ${Ccom}\tDisplay program version
    ${Cspe}\tbes-build  ${Copt}-v${Ctext}, ${Copt}version
    ${Ccom}\tDisplay this help
    ${Cspe}\tbes-build  ${Copt}-h${Ctext}, ${Copt}help"

    echo -e "${Coff}"
}
