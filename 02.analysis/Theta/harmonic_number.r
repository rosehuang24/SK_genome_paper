harmonicNumber = 0
numChromosomes = 16 #inpout number of chromosomes, not indvs

for (i in 1:(numChromosomes - 1)) {
  harmonicNumber = harmonicNumber + 1.0/i
}
print(harmonicNumber)
