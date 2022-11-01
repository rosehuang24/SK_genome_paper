import sys
import gzip
infile = sys.argv[1]
inh = gzip.open(infile, 'rt')

outfile = sys.argv[2]
outh = open(outfile, 'w')



for lines in inh:
    if not lines.startswith('#'):
        line = lines.strip().split()
        if line[6] == "PASS":
            outh.write(lines)
    else:
        outh.write(lines)

outh.close()
inh.close()
