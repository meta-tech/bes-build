bes-build
=========

**bes-build** is a bash script to build bash program.  
the building process simply consist to append shell script files from your `src/` project directory 
into a single `dist/project` executable file


since version **0.5** **bes-build** attempt to be a *dependency manager* like `composer` (for php projects) but in a more extra-light way


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

using **bes-build** script require you to conform to these following rules :

* respect this directory structure :
```pre

    project/
       |
       |--- bes.ini         # project information and requirements (optional)
       |
       |--- dist/project    # project build (auto generated by bes-build)
       |
       |--- src/
       |     |
       |     |--- file1.sh
       |     |--- file2.sh
       |     | ...
       |     |--- filen.sh
       |
       |--- vendor/         # project dependencies (auto generated by bes-build update)
```
* each `src/` shell file require a `shebang` on first line (**#!/bin/bash**)
* `src/main.sh` file is append to the end of the build file
* we strongly recommand you to use function and prefix function name
```shell
bes.install(){
   ...
}
```

### Dependency Manager

**note:** This functionnality is still in progress  
to use **bes-build** like a dependency manager, you need a `bes.ini` file in your application root path

```ini  
[require]
bes.echo    = 1.1
```
 
then you can run the `update` command before building

```shell
bes-build update
```

**bes-build** call `git` on a `vendor` directory and clone the require lib

on next build, **bes-build**  will append the dependencies to your dist file


### External dependencies

since version 0.6 you can now add external dependencies :

```ini  
[require]
test.echo   = https://git.pluie.org/meta-tech/bes-echo:master
```


### Releasing bes lib

if you intend to release your lib as a bes dependency you must provide a bes.ini file as following :
(example is taken from bes-echo)

```
[project]
vendor      = bes
name        = echo
version     = 1.1
license     = "GNU GPL v3"
author      = a-Sansara
type        = library
homepage    = "https://git.pluie.org/meta-tech/bes-echo"
description = "bash bes display utility library"
keywords    = "bash, bes"
```
