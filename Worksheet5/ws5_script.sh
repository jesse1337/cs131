#!/bin/bash

# file to read
data="Global YouTube Statistics.csv"

# file we contain counts in (make sure it's empty first)
output="ws5.txt"
>"$output"

# create directory if we haven't already
mkdir -p "United States"

# this loop takes the category & country row, and creates the respective txt files with entries in each
while IFS=, read -r  _ _ _ _ category _ _ country rest
do
	if [[ "$country" == "United States" ]]; then
		echo "$country, $category, $rest" >> "United States/$category.txt"
	fi
done < <(tail -n +2 "$data")

# this loop goes through each txt file, counts, and outputs that count along w other text into ws5.txt
for file in "United States"/*.txt; do
	count=$(wc -l < "$file")
	f_name=$(basename "$file")
	echo "$f_name: $count" >> "$output"
done
