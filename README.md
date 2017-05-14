bes-build
=========

bes-build is a bash script to build bash program.  
the building process simply consist to append shell script files from your `src/` project directory 
into a single `dist/project` executable file


since version 0.5 bes-build attempt to be a dependency manager like `composer` (for php projects) but in a more extra-light way


### Install

```
wget https://raw.githubusercontent.com/meta-tech/bes-build/latest/dist/bes-build
bash ./bes-build -i
```

### Usage

```shell
# change directory to your project
cd /home/repo/meta-tech/bes
bes-build
# you can now execute program with : 
./dist/bes
# to display help execute :
bes-build -h 
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
* `src/main.sh` file is append to the end of the build file
* we strongly recommand you to use function and prefix function name
```shell
bes.install(){
   ...
}
```

### Depency Manager Requirements

**note** This functionnality is still in progress  
to use `bes-build` like a dependency manager, you need a `bes.ini` file in your application root path

```ini  
[require]
bes.echo    = 1.0
```
 
then you can run the `update` command before building

```shell
bes-build update
```

`bes-build` call `git` on a `vendor` directory and clone the require lib

on next build, bes-build  will append the dependencies


