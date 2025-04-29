#!/bin/bash

# List of numbers corresponding to the files (3, 5, 7)
#numbers=(12 16 1 21 24 28 2 33 37 3 42 46 49 50 8 15 19 20 23 25 29 32 36 38 41 45 47 4 7)  # You can replace this list with your actual numbers or read from a file
#numbers=(47 36)
numbers=($(< 2.numbers.txt))
#coup_file="coup" 
# Loop through each number in the list
for n in "${numbers[@]}"; do
  # Step 1: Find the file named opt-couple$n.in in the current directory
  opt_couple_file=$(find . -type f -name "geom-$n.xyz")

  # Check if the opt-couple$n.in file is found
  if [[ -z "$opt_couple_file" ]]; then
    echo "geom-$n.xyz file not found."
    continue
  fi

  # Step 2: Search for opt$n.out in the previous directory
  opt_out_file=$(find  -type f -name "opt$n.out")

  # Check if the opt$n.out file is found
  if [[ -z "$opt_out_file" ]]; then
    echo "opt$n.out file not found in the previous directory."
    continue
  fi

  # Step 3: Search for the phrase "OPTIMIZATION CONVERGED" in opt$n.out
  line_num=$(grep -n " CONVERGED" "$opt_out_file" | awk -F: '{print $1}')

  # Check if the phrase is found
  if [[ -z "$line_num" ]]; then
    echo "Phrase 'OPTIMIZATION CONVERGED' not found in opt$n.out."
    continue
  fi

  # Step 4: Extract 160 lines starting from 7 lines after the found line
  start_line=$((line_num + 6))
  tail -n +"$start_line" "$opt_out_file" | head -n 186 | cut -c12- > temp_lines$n.txt

  # Step 5: Insert these lines into opt-couple$n.in after the second line
  {
    head -n 2 "$opt_couple_file"
    cat temp_lines$n.txt
    tail -n +3 "$opt_couple_file"
  } > temp_file$n && mv temp_file$n "$opt_couple_file"

  # Cleanup the temporary file
  rm temp_lines$n.txt

  echo "Lines successfully inserted into geom-$n.xyz with the first 9 characters removed."
done

