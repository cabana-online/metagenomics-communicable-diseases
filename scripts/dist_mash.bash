#!/bin/bash

CTG=$(ls *.msh)

for i in $CTG; do
    for j in $CTG; do
        [[ "$i" == "$j" ]] && break
        out="$(basename $i .msh)-$(basename $j .msh)"
        [[ -s $out.dist ]] || mash dist $i $j > $out.dist
    done
done
