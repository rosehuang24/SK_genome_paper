#!/bin/bash

source ~/.bash_profile


python3 treemix.input.py $SNPVCF $OUTDIR/treemix_input.9pops 107.header.locale.txt
gzip $OUTDIR/treemix_input.9pops



$treemix/treemix -i $OUTDIR/treemix_input.9pops.gz \
                  -bootstrap -k 500 \
                  -root RJF \
                  -noss \
                  -m ${migration_number} \
                  -o $OUTDIR/input.4.noWLH_migs/mig${migration_number}

