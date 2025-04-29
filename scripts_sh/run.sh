#!/bin/bash

# Make sure the Python script is executable
PYTHON_SCRIPT="perp_dist.py"

# Atom index ranges
FULLERENE="73-132"
ORGANIC="1-72"

# Read each number from numbers.txt
while read -r number; do
    filename="geom-${number}.xyz"
    if [ -f "$filename" ]; then
#        echo "Processing $filename..."
        python "$PYTHON_SCRIPT" "$filename" --fullerene "$FULLERENE" --organic "$ORGANIC"
    else
        echo "File $filename not found!"
    fi
done < numbers.txt

