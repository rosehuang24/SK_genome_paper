
# Theta

## get segregating site number S
```python3 $scriptDIR/segregating_sites.py -I $popvcf -O $pop.input4.segsite.vcf```

```grep -v "#" $pop.input4.segsite.vcf | wc -l > $pop.input4.segsite.count```

## get N
total automosomal length is 960,796,756. Repetitive region total length for autosomes is 190,557,588. The remaining region length is 770,239,168

## get harmonic number ```a```

see R script
 
## get Theta 

(S/N)/a

