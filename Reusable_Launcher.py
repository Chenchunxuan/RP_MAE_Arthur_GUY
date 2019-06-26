# -*- coding: utf-8 -*-
"""
Created on Wed Apr 17 09:58:23 2019
s 
@author: arthur guy
"""


from math import exp, pi
import subprocess as sp
#import time


###### path to the .geo file and to gmsh.exe
File = "C:/Users/arthu/OneDrive/Bureau/Nouveau dossier/gep_launcher.geo"   # warning : put "/" instead of "\"
Path = "C:/Users/arthu/OneDrive/Bureau/Nouveau dossier"
GMSH = r'C:\Program Files\gmsh 4.3.0 Windows64\\gmsh.exe'


###### constants
g = 9.81 # m/s2
Epsilon = 2
rho_LH2 = 112 # kg/m3
rho_LOX = 1140 # kg/m3
I_sp = 450 # s
RCS = 700 # kg, Reaction Conctrol System propellant


###### input data
deltav_input = input('enter Deltav (m/s) : ')
Payload_input = input('enter payload (kg) : ') # black box

deltav = int(deltav_input)
Payload = int(Payload_input)


###### Initialization
M_inert = Payload
M_tot = Payload
i = 0


###### function


# computation of propellant and tank mass
def propellant_and_tank(deltav, M_tot, M_inert):
    
    # rocket equation
    R = exp(deltav / (I_sp * g))
    
    M_tot = M_inert * R
    M_prop = M_tot - M_inert
    
    M_prop = M_prop * 1.07 # 4% for FPR Propellant, 7% for Unusable Propellant
    
    # mixture ratio LOX/LH2, 6:1
    M_LH2 = M_prop / 7
    M_LOX = 6 * (M_prop / 7)
    M_LH2_1 = M_LH2 / 2  # 2 tanks for mass distribution
    M_LOX_1 = M_LOX / 2  # 2 tanks for mass distribution
    
    # LOX Tank
    M_LOX_Tank = 0.00152 * M_LOX_1 + 318
    V_LOX_Tank = M_LOX_1 / rho_LOX
    r_LOX_Tank = (V_LOX_Tank / (4 * pi /3))**(1 / 3)  # radius of LOX tank
    A_LOX_Tank = 4 * pi * (r_LOX_Tank**2)  # Area LOX Tank
    M_LOX_Insu = 1.123 * A_LOX_Tank  # Mass LOX insulation
    M_LOX_Tanks = 2 * M_LOX_Tank
    M_LOX_Insus = 2 * M_LOX_Insu
    
    # LH2 Tank
    M_LH2_Tank = 0.0694 * M_LH2_1 + 363
    V_LH2_Tank = M_LH2_1 / rho_LH2
    r_LH2_Tank = (V_LH2_Tank / (4 * pi  /3))**(1 / 3)  # radius of LH2 tank
    A_LH2_Tank = 4 * pi * (r_LH2_Tank**2)  # Area LH2 Tank
    M_LH2_Insu = 2.88 * A_LH2_Tank  # Mass LH2 insulation
    M_LH2_Tanks = 2 * M_LH2_Tank
    M_LH2_Insus = 2 * M_LH2_Insu
    
     
    
    return M_prop, M_LOX_Tanks, M_LH2_Tanks, M_LOX_Insus, M_LH2_Insus, r_LOX_Tank, r_LH2_Tank


# computation of structure mass
def structure(M_inter):
    
    y = -M_tot/2500000 + 0.067
    
    M_Struct = M_tot * y
    
    with open("geo_launcher.geo", "r+") as f:
        f.seek(0) # rewind
        f.write("r_LOX_Tank = %s;\nr_LH2_Tank = %s; \n" % (round(r_LOX_Tank,2),round(r_LH2_Tank,2))) # write the new line before
        f.close()
        

    sp.call([GMSH, File, "-1", "-2"], shell=True) 
    #sp.call([File,"-o test.bdf"], shell=True) 
    
    
    return M_Struct



#################################################################################
    
###### main


# Open and read original .geo file in order to keep the original
with open("geo_launcher.geo", "r+") as f:
     f.read() # read everything in the file
     f.close()


# Masses computation loop
while Epsilon > 1 : 
    
    i = i + 1
    
    save = M_tot
    
    # calling function propellant_and_tank
    M_prop, M_LOX_Tanks, M_LH2_Tanks, M_LOX_Insus, M_LH2_Insus, r_LOX_Tank, r_LH2_Tank = propellant_and_tank(deltav, M_tot, M_inert)
    
    # Intermediary mass for structure mass computation
    M_inter = RCS + Payload + M_prop + M_LOX_Tanks + M_LOX_Insus + M_LH2_Tanks + M_LH2_Insus
    
    # calling function structure
    M_Struct = structure(M_inter)
    
    # New inert mass
    M_inert = RCS + Payload + M_Struct + M_LOX_Tanks + M_LOX_Insus + M_LH2_Tanks + M_LH2_Insus
    
    # Total Mass
    M_tot = M_inert + M_prop
    
    Epsilon = M_tot - save
    
    
    
    
# Printing all the values
print('\n')
print('number of iterations :', i)
print('\n')
print('Inert mass :', M_inert)
print('Structure mass :', M_Struct)
print('Propellant mass :', M_prop)
print('LOX tanks mass :', M_LOX_Tanks)
print('LOX insulation mass :', M_LOX_Insus)
print('LH2 tanks mass :', M_LH2_Tanks)
print('LH2 insulation mass :', M_LH2_Insus)
print('Total mass :', M_tot)
print('\n')
print('LOX tank radius', r_LOX_Tank)
print('LH2 tank radius', r_LH2_Tank)