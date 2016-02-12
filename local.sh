#!/usr/bin/env bash

###########
##
##  Source this to set up the ability to use the gem locally without installing during dev
## 
##########

export RUBYLIB="${PWD}/lib:$RUBYLIB"
export PATH="$PATH:${PWD}/bin"
