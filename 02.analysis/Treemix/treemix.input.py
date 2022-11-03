#parafile is the one with pop names and python positions. one pop per line, tab delim, three colomns: pop, start, end
#107.header.locale.txt
import sys

infile = sys.argv[1]
inh = open(infile, 'r')
outfile = sys.argv[2]
outh = open(outfile, 'w')
parafile = sys.argv[3]
parah = open(parafile, 'r')


start={}
end={}
ls=[]
for locales in parah:
    locale=locales.strip().split()
    start[locale[0]]=locale[1]
    end[locale[0]]=locale[2]
    ls.append(locale[0])
outh.write(' '.join(ls)+"\n")
#print()

def ac(popnames):
    ac_start=start[popnames]
    ac_end=end[popnames]
    #pop='\t'.join(line[int(ac_start):int(ac_end)])
    hom=0
    het=0
    ref=0
    for g in line[int(ac_start):int(ac_end)]:
        gt=g.split(":")[0]
        if gt=="0/0":
            ref+=2
        if gt=="0/1":
            het+=1
        if gt=="1/1":
            hom+=2
    AC=str(hom+het)+","+str(het+ref)
    outh.write(AC+' ')


for lines in inh:
    if not lines.startswith("#"):
        line=lines.strip().replace("|", "/").split()
        for i in ls:
            ac(i)
        outh.write("\n")



inh.close()
outh.close()
parah.close()
