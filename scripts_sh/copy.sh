#!/bin/bash

# Path to the file containing the list of numbers
NUMBER_LIST="2.numbers.txt"

# Loop through each number in the number list
while IFS= read -r n; do
    # Execute the copy command, creating optn.in for each n
    cp geom.xyz "geom-$n.xyz"
done < "$NUMBER_LIST"

