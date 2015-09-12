#!/bin/bash

shopt -s nullglob

for r in recipe/*.recipe; do
    ./sync-recipe.bash ${r}
done
