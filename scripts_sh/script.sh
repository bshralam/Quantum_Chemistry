#!/bin/bash

# Read numbers from a file
while read -r n; do
    # Extract lines from opt-coupn-$n.in
    if [[ -f "opt-coup${n}.in" ]]; then
        sed -n "2,190p" "opt-coup${n}.in" > temp.txt

        # Insert the extracted lines after line 2 in file_b.txt and save to marcus1-${n}.in
        sed "1r temp.txt" marcus2.in > "marcus2-${n}.in"

        # Remove the temporary file
        rm temp.txt
    else
        echo "File opt-coupn-${n}.in not found, skipping..."
    fi
done < numbers.txt

