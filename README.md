bes-build
=========

bes-build is a bash script to build bash program.  
the building process simply consist to append shell script files from your `src/` project directory into a single `dist/project` executable file

### Install

```
wget https://raw.githubusercontent.com/meta-tech/bes-build/master/dist/bes-build
chmod +x bes-build
sudo mv bes-build /usr/local/bin
```

### Usage

```shell
# change directory to your project
cd /home/repo/meta-tech/bes
bes-build
# you can now execute program with : 
./dist/bes
```

### Requirements

using bes-build script require you to conform to these following rules :

* respect this directory structure :
```pre

    project/
       |
       |--- src/
             |
             |--- file1.sh
             |--- file2.sh
             |--- file3.sh
```
* each `src/` shell file require a `shebang` on first line (**#!/bin/bash**)
