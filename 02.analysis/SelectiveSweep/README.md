For selective sweep analysis, we utilized three different approaches:

1. Fst
2. pi ratio
3. XP-EHH

All three of them are done in a window approach. Windows with poor quality were removed from the analysis (less than 5 snps and/or have more than 50% missing calls)
Such step can be done with ```awk```

To use the scripts in this folder, you'll will need the windows that pass the filters and has all three stats and their Zscores in tab-delim format (see ```z.R```). See ```three_stat_xrf.bed``` as example
