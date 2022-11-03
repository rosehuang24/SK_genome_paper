# SMC++ pipeline


https://github.com/popgenmethods/smcpp

## 01. Prepare the smc input from VCF

* Each contig must be calculated seperately

```smc++ vcf2smc <input.vcf.gz> <POP1_chr$i.smc.gz> $i -m <masked_region.bed> POP1:indv1,indv2,indv3,indv4...```



## 02. Run estimate with chromosomes combined
 ```
  smc++ estimate \
  --spline cubic \
  -o <POP1_estimate> \
  1.8e-9 \
  POP1_chr1.smc.gz POP1_chr2.smc.gz POP1_chr3.smc.gz POP1_chr4.smc.gz...
```
The resulted folder ```POP1_estimate```will have a json file, which will be used for plotting
```--spline cubic``` produces smooth line

## 03. Plot and get datapoints if you want to generate the plot yourselves

```
smc++ plot -c <plot.png> POP1_estimate/model.final.json \
-g 1 \ #generation time as one year
-x 0 1000000 -y 1000 10000000 #custominzed x,y axis. Not necessary 
```

``` -c: keep data file in csv format```

## 04. R plotting

Combine the result csv files to create plot with all populations of interest

```cat *csv | sed 's/,/\t/g' | grep -v label | cut -f -3 > cat.txt ```


# For Step_01 and Step_02.sh in this folder:

###  ```Step_01.sh``` : 

*contains ```vcf2smc```

1. Substitude ```DDDD``` in the file with your population name

```parallel sed \'s/DDDD/{}/g\' Step_01.sh \> Step_01_{}.sh :::: <107.pop_names_cap.DL.txt>```

2. Make sure you have a popluation file with each individual a seperate line (```DDDD.popline.txt```)

3. The ```Step_01.sh``` script will create files ends in ```.smc.gz``` for each chromosome (contig)

###  ```Step_2.sh``` : 

*contains ```estimate``` and ```plot```
1. Nothing special. Just prepare a file with the same population name as you used in step_01 (e.g. ```<107.pop_names_cap.DL.txt>```)

