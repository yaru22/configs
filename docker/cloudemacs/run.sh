#!/bin/sh

# Usage
# ./run.sh       -->  runs gotty directly
# ./run.sh bash  -->  runs bash

docker run -it --rm --name emacs \
    -v ~/workspace/notes:/home/brianpark/workspace/notes \
    -v empty_dir:/home/brianpark/workspace/notes/.git \
    -p 3333:8080 \
    cloudemacs:doom $1
 
    #-v ~/.doom.d:/home/brianpark/.doom.d \
    #-v empty_dir:/home/brianpark/.doom.d/.git \
    #-v ~/.emacs.d:/home/brianpark/.emacs.d \
    #-v empty_dir:/home/brianpark/.emacs.d/.git \
