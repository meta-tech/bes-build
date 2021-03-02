#!/bin/bash

function bes.build.new () {
    local prj=${1}
    echo.title "creating new project" "$prj"
    if [ -d "$APP_DIR/$prj" ]; then
        echo.error "directory $prj already exists" 1
    else
        echo.action "creating directory" "$prj" "*" "Cusa"
        mkdir "$APP_DIR/$prj"
        echo.state $?
        echo.action "creating project config file" "bes.ini" "*" "Cusa"
        echo -e "[project]
vendor      = 
name        = $prj
version     = 0.1
license     = \"GNU GPL v3\"
author      = 
type        = application
homepage    = 
description = \"bash bes $prj application\"
keywords    = \"bash $prj\"

[require]
bes.install = 1.4
" > "$APP_DIR/$prj/bes.ini"
        echo.state $?
        echo.action "Creating directory" "src" "*" "Cusa"
        mkdir $APP_DIR/$prj/src
        echo.state $?
        echo.action "Adding default templates" "main" "*" "Cusa"
        echo "#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      BES_VERSION=0.1
       BES_AUTHOR=me
      BES_LICENSE=MIT
         BES_NAME=\"$prj\"
          BES_URL=\"https://your.forge.git/vendor/\$BES_NAME/raw/latest/dist/\$BES_NAME\"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function $prj.main ()
{
    echo.msg \"hello bes\" \"\$Citem\"
    echo.rs \$?
    echo
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.main ()
{
    if   [ \"\$1\" = \"version\" ] || [ \"\$1\" = \"-v\" ]; then
        echo \$BES_VERSION
    else
        echo.app \"\$BES_NAME\" \"\$BES_VERSION\" \"\$BES_AUTHOR\" \"\$BES_LICENSE\"
        echo
        if   [ \"\$1\" = \"install\" ] || [ \"\$1\" = \"-i\" ]; then
            bes.install \"\$BES_NAME\" \"\$BES_URL\" \"\$2\"
        elif [ \"\$1\" = \"help\" ] || [ \"\$1\" = \"-h\" ]; then
            $prj.usage
        else
            $prj.main
        fi
        echo
    fi
}
bes.main \$*
" > "$APP_DIR/$prj/src/main.sh"
        echo.state $?
        echo.action "Adding default template" "usage" "*" "Cusa"
echo "#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function $prj.usage ()
{
    echo -e \"     \${Cusa}Usage :\${Coff}\n
    \${Ccom}\tInstall or update \$BES_NAME on specified BINDIR directory or in /usr/local/bin directory
    \${Cspe}\t\$BES_NAME  \${Copt}-i\${Ctext}, \${Copt}install        \${Copt}[ \${Ctext}BINDIR\${Copt} ]
    \${Ccom}\tDisplay program version
    \${Cspe}\t\$BES_NAME  \${Copt}-v\${Ctext}, \${Copt}version
    \${Ccom}\tDisplay this help
    \${Cspe}\t\$BES_NAME  \${Copt}-h\${Ctext}, \${Copt}help\"

    echo -e \"${Coff}\"
}

" > "$APP_DIR/$prj/src/usage.sh"
        echo.state $?
        echo.rs $?
        echo
    fi
}
