# -*- coding: utf-8 -*-
"""
Created on Wed Apr 17 09:58:23 2019
s 
@author: arthur guy
"""


from math import exp, pi, sqrt



###### path to files and softwares


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
Launch_G_input = input('enter max G from launch (m/s²) : ')
Landing_G_input = input('enter max G from landing (m/s²) : ')

deltav = int(deltav_input)
Payload = int(Payload_input) + RCS
G_Launch = int(Launch_G_input)
G_Land = int(Landing_G_input)


###### Initialization
M_dry = Payload
M_tot = Payload
i = 0


###### function


# computation of propellant and tank mass
def propellant_and_tank(deltav, M_tot, M_dry):
    
    # rocket equation
    R = exp(deltav / (I_sp * g))
    
    M_tot = M_dry * R
    M_prop = M_tot - M_dry
    
    M_prop = M_prop * 1.07 # 4% for FPR Propellant, 3% for Unusable Propellant
    
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
def structure(M_):
    
    y = -M_*5.92E-07 + 0.081
    
    M_Struct = M_ * y
        
    
    return M_Struct


    
####################### main ###############################

###### Masses computation loop
while Epsilon > 1 : 
    
    i = i + 1
    
    save = M_tot
    
    # calling function propellant_and_tank
    M_prop, M_LOX_Tanks, M_LH2_Tanks, M_LOX_Insus, M_LH2_Insus, r_LOX_Tank, r_LH2_Tank = propellant_and_tank(deltav, M_tot, M_dry)
    
    # Intermediary mass for structure mass computation
    M_inter = Payload + M_prop + M_LOX_Tanks + M_LOX_Insus + M_LH2_Tanks + M_LH2_Insus
    
    # calling function structure
    M_Struct = structure(M_inter)
    
    # New dry mass
    M_dry = Payload + M_Struct + M_LOX_Tanks + M_LOX_Insus + M_LH2_Tanks + M_LH2_Insus
    
    # Total Mass
    M_tot = M_dry + M_prop
    
    Epsilon = M_tot - save


M_dry = M_dry - RCS
M_prop = M_prop + RCS
###### Structural Analysis Preparation 
    
# Total mass of each filled tanks for structure approximation of the tanks as bars
M_LH2_Virtual = M_prop/14 + M_LH2_Tanks/2 + M_LH2_Insus/2
M_LOX_Virtual = 3*M_prop/7 + M_LOX_Tanks/2 + M_LOX_Insus/2

# Cross section area for tanks approximation
rho_LH2_tank = M_LH2_Virtual/(0.1*2*r_LH2_Tank)
rho_LOX_tank = M_LOX_Virtual/(0.1*2*r_LOX_Tank)

# Payload is modelized as 4 rods
Model_Payload = Payload/4
rho_Payload = Model_Payload/(9*sqrt(6)/100)


# here is where the new tanks' size is written in the .inp file for nastran

correct = []
with open("Mesh.inp", "r+") as f:    
    original = f.readlines() # read everything in the file
    
    for line in original:
        if "GRID,2," in line:
            correct.append('GRID,2,0,2.550000,0.00E+00,%s,,456\n' % (round(-0.3-2*r_LOX_Tank,2)))
        elif "GRID,4," in line:
            correct.append('GRID,4,0,-2.55000,0.00E+00,%s,,456\n' % (round(-0.3-2*r_LOX_Tank,2)))
        elif "GRID,6," in line:
            correct.append('GRID,6,0,0.00E+00,2.550000,%s,,456\n' % (round(-0.1-2*r_LH2_Tank,2)))
        elif "GRID,8," in line:
            correct.append('GRID,8,0,0.00E+00,-2.55000,%s,,456\n' % (round(-0.1-2*r_LH2_Tank,2)))
        else:
            correct.append(line)
    f.seek(0)
    f.truncate()
    f.write("".join(correct))
    f.close()

with open("Mesh.inp", "r+") as f:
    original = f.read()
    f.close()
    
    
# modify .inp file and writes new inputs, initialization parameters and mesh
with open("nastran_input.inp", "r+") as f:
    f.truncate()
    f.seek(0) # rewind
    f.write("ID LUNAR,LANDER\n"
            "SOL 1\n"
            "CEND\n"
            "TITLE = lander_analysis\n"
            "ECHO = NONE\n"
            "DISP = ALL\n"
            "STRESS = ALL\n"
            "SUBCASE 10\n"
            "LABEL = LAUNCH\n"
            "LOAD = 100\n"
            "SPC = 11\n"
            "SUBCASE 20\n"
            "LABEL = LANDING\n"
            "LOAD = 200\n"
            "SPC = 21\n"
            "BEGIN BULK\n"
            "PARAM,GRDPNT,0\n"
            "MAT1,1,71.7E+09,26.9E+09,0.33,2810. \n"
            ",4.03E+08,4.03E+08,3.31E+08,1\n"
            "MAT1,2,73.1E+09,27.0E+09,0.33,2840. \n"
            ",2.35E+08,2.35E+08,2.0E+08,1\n"
            "MAT1,3,50.0E+09,27.0E+09,,%s \n"
            "MAT1,4,50.0E+09,27.0E+09,,%s \n"
            "MAT1,5,71.7E+09,26.9E+09,0.33,%s\n" 
            "PBAR,1,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05     \n" #radius of 2.5mm aproximately
            "PBAR,2,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05      \n"
            "PBAR,3,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05  \n"
            "PBAR,4,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05        \n"
            "PBAR,5,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05        \n"
            "PBAR,6,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05        \n"
            "PBAR,7,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05        \n"
            "PBAR,8,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05        \n"
            "PBAR,9,1,0.0046,1.348E-5,6.953E-6,1.381E-5\n"
            ",0.075,0.05,-0.075,0.05,-0.075,-0.05,0.075,-0.05        \n"
            "PROD,10,1,0.0028      \n"
            "PROD,11,1,0.0028      \n"
            "PROD,12,1,0.0028      \n"
            "PROD,13,1,0.0028   \n"
            "PROD,14,1,0.0028      \n"
            "PROD,15,1,0.0028      \n"
            "PROD,16,1,0.0028      \n"
            "PROD,17,1,0.0028      \n"
            "PROD,18,3,0.1      \n"
            "PROD,19,4,0.1    \n"
            "PROD,20,5,0.1     \n"
            "PTRIA2,21,2,0.008     \n"
            "PTRIA2,22,2,0.008\n"
            "PQUAD2,23,2,0.008\n"
            "$\n"
            "$Pressurized module\n"
            "$\n"
            "PLOAD,1,101325.,25,27,34,36\n"
            "PLOAD,2,101325.,27,31,35,34\n"
            "PLOAD,3,101325.,31,29,33,35\n"
            "PLOAD,4,101325.,29,25,36,33\n"
            "PLOAD,5,101325.,36,34,35,33\n"
            "PLOAD,6,101325.,25,29,31,27\n"
            "$\n"
            "$Subcase 1\n"
            "$\n"
            "SPC1,11,123456,26,28,30,32\n"
            "GRAV,101,0,%s,0.,0.,-9.81\n"
            "LOAD,100,1.0,1.0,101,1.0,1,1.0,2\n"
            ",1.0,3,1.0,4,1.0,5,1.0,6\n"
            "$\n"
            "$Subcase 2\n"
            "$\n"
            "SPC1,21,123,37\n"
            "SPC1,21,3,38,39,40\n"
            "GRAV,201,0,%s,0.,0.,-9.81\n"
            "LOAD,200,1.0,1.0,201,1.0,1,1.0,2\n"
            ",1.0,3,1.0,4,1.0,5,1.0,6\n"
            "$\n"
            "GRID,1000,0,0.,0.,100.2,,123456\n"
            "GRID,1001,0,0.,0.,0.,,123456\n" 
            "POPT,20,0.01,0.95,5,YES\n" % (round(rho_LOX_tank,2), round(rho_LH2_tank,2), round(rho_Payload,2), "%0.1f" % G_Launch, "%0.1f" % G_Land)
            + original)
    
    f.close()
    
    
    
    
# Printing all the values
print('\n')
print('number of iterations :', i)
print('\n')
print('dry mass :', M_dry)
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

###### Visualization 

# open the .geo file and writes the new radius
with open("Visualization.geo", "r+") as f:
    f.seek(0) # rewind
    f.write("r_LOX_Tank = %s;\nr_LH2_Tank = %s; \n" % (round(r_LOX_Tank,2),round(r_LH2_Tank,2))) # write the new line before
    f.close()
