#!/bin/bash

for r in recipe/*.recipe; do
    ./sync-recipe.bash ${r}
done
