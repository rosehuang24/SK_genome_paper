#a very ungraceful script but it does its job right
#input: a vcf
#output: a vcf with only segregating sites

import argparse
import gzip
parser = argparse.ArgumentParser()
parser.add_argument("-I","--input", help="input file, zipped or unzipped vcf",required=True)
parser.add_argument("-O","--output", help="output file name",required=True)
#parser.add_argument("-P","--population", help="Population name for header",required=True)

args = parser.parse_args()

outh = open(args.output, 'w')
#name = args.population
#outh.write(name+"\n")


with (gzip.open if args.input.endswith(".gz") else open)(args.input, "rt") as inh:
    for lines in inh:
        if not lines.startswith("#"):
            line=lines.strip().replace("|", "/").split()
            hom=0
            het=0
            ref=0
            for g in line[9:]:
                gt=g.split(":")[0]
                if gt=="0/0":
                    ref+=2
                if gt=="0/1":
                    het+=1
                if gt=="1/1":
                    hom+=2
            if hom+het!=0:
                if het+ref!=0:
                    outh.write(lines)
        else:
            outh.write(lines)





inh.close()
outh.close()
