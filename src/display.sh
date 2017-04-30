#!/bin/bash

BES_TERM_WIDTH=105
   BES_NOCOLOR=0

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [ "$BES_NOCOLOR" -eq 0 ]; then
             Cok="\033[0;38;5;43m";              Cko="\033[0;38;5;217m"
            Coff="\033[m";                    Ctitle="\033[1;48;5;24;1;38;5;15m"
           Cdone="\033[1;48;5;36;1;38;5;15m";  Cfail="\033[1;48;5;196;1;38;5;15m"
            Cspe="\033[1;38;5;223m";           Citem="\033[1;38;5;214m"
            Cval="\033[1;38;5;215m";            Cusa="\033[1;38;5;214m"
            Cbra="\033[1;38;5;203m";           Crepo="\033[1;38;5;223m"
           Cmeta="\033[1;38;5;30m";            Ctext="\033[1;38;5;30m"
            Copt="\033[1;38;5;81m";             Csep="\033[1;38;5;241m"
            Cerr="\033[1;38;5;196m";            Ccom="\033[0;38;5;139m"
        Csection="\033[1;38;5;97m";          Caction="\033[0;38;5;37m"
fi
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo(){
    local      msg=${1:-''}
    local isAction=${2:-'0'}
    local   symbol=${3:-' *'}
    if [ ! "$BES_NOCOLOR" = 1 ]; then
        local   c=" "
        if [ -z "$isAction" ] || [ "$isAction" = 1 ]; then
            c=$Caction
        fi
        if [ ! "$isAction" = 0 ]; then
            c="   $Citem$symbol $c"
        fi
        echo -e " $c$msg$Coff"
    else
        if [ ! "$isAction" = 0 ]; then
            msg="   $symbol $msg"
        fi
        echo -e "$msg"
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo.action(){
    bes.echo "$1" 1
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo.title(){
    bes.echo " ${Citem}☪ ${Csection}$1 ${Cspe}$2${Coff}"
    echo
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo.keyval(){
    local c=': '
    if [ ! "$BES_NOCOLOR" = 1 ]; then
        c="$Citem: ${Cval}"
    fi
    bes.echo "  $1 $c$2" 1 " "
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo.state(){
    local len=8
    printf "%0.s " $(seq 1 $(($BES_TERM_WIDTH-${len})))
    if [ "$1" = 0 ]; then
        echo -e "${Cdone}  OK  ${Coff}"
    else
        echo -e "${Cfail}  KO  ${Coff}"
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo.rs(){
    local rs=${1:-0}
    if [ "$rs" -eq 0 ]; then
        echo -e "\n  ${Cdone}  done  ${Coff}"
    else 
        echo -e "\n  ${Cfail}  failed  ${Coff}"
    fi
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.echo.error(){
    echo -e "\n${Cerr}    error : ${Coff}\n\t$1 ${Coff}\n"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.sepline(){
    local  char=${1:-'_'}
    local width=${2:-$BES_TERM_WIDTH}
    echo -ne "${Csep} "
    printf "%0.s$char" $(seq 1 $width)
    echo -e "${Coff}"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.title(){
    local     msg=${1:-''}
    local version=${2:-''}
    local  author=${3:-'a-Sansara'}
    if [ ! -z "$2" ]; then
        msg="$msg ${Cval}v$version"
    fi
    local     len="$1${version}license : GNU GPL v3   author:$author"
    bes.sepline
    echo -ne "\n  $Ctitle   $msg   $Coff"
    printf "%0.s " $(seq 1 $(($BES_TERM_WIDTH-${#len}-15)))
    echo -e " ${Cmeta}license : ${Coff}GNU GPL v3   ${Cmeta}author : ${Cval}$author"
    bes.sepline
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bes.color.map(){
    for fgbg in 38 48 ; do
        for color in {0..256} ; do
            echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
            if [ $((($color + 1) % 7)) == 0 ] ; then
                echo
            fi
        done
        echo
    done
}
