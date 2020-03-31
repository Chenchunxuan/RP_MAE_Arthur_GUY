# -*- coding: utf-8 -*-
"""
Created on Mon Mar  2 18:58:00 2020

@author: arthur GUY
"""


with open("nastran_test.inp", "r+") as f:
    original = f.read() # read everything in the file
    for i in range (1,600):
        for j in range (10,20):
                original = original.replace("CBAR,%s,%s," % (i,j),"CROD,%s,%s," % (i,j))  # replace CBAR by CROD    
    original = original.replace(',0.,0.,0.','') # delete default orientation vector of GMSH
    original = original.replace('TRIA3','TRIA2') # replace TRIA3 by TRIA2
    original = original.replace('QUAD4','QUAD2') # replace QUAD4 by QUAD2
    f.seek(0)
    f.truncate()
    f.write(original)
    f.close()
    
correct = []
# we do not have orientation vector anymore and here we replace it by a GRID point (that has to be defined)
# look for CBAR bulk data card to know how GRID point works compared to orientation vector
with open("nastran_test.inp","r+") as f:
    original = f.readlines()
    i = 1
    for line in original:
        if "CBAR,%s,9" % i in line:
            correct.append(line.rstrip('\n') + ',1001\n') 
            i += 1
        elif "CBAR,%s,3" % i in line:
            correct.append(line.rstrip('\n') + ',1001\n')
            i += 1
        elif "CBAR,%s,4" % i in line:
            correct.append(line.rstrip('\n') + ',1001\n')
            i += 1
        elif "CBAR" in line:
            correct.append(line.rstrip('\n') + ',1000\n')
            i += 1
        else:
            correct.append(line)
    f.seek(0)
    f.truncate()
    f.write("".join(correct))
    f.close()

