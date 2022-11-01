import sys

infile = sys.argv[1]
inh = open(infile, 'r')
outfile = sys.argv[2]
outh = open(outfile, 'w')

for lines in inh:
    if lines.startswith('#'):
        outh.write(lines)
    else:
        line = lines.strip().split()
        m=0
        for indv in lines.strip().split()[9:]:
            gt=str(indv).split(":")[0]
            if gt=="./.":
                m+=1
        if m<11:
            outh.write(lines)


inh.close()
outh.close()
