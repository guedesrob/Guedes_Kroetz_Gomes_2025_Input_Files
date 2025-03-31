import re
import codecs
import os
######################################
#           Input
#
######################################
# Current Directory Path
diretorio_atual=os.path.dirname(os.path.abspath(__file__)) if '__file__' in locals() else os.getcdw()

# File path 'variables.txt' ('\\' separa as pastas)
path_variables=os.path.join(diretorio_atual,"variable.txt")

# File path 'variables.txt' ('\\' separa as pastas)
path_apdl=os.path.join(diretorio_atual,"FE_Input.apdl")

######################################
#    READING FILE 'VARIABLES' AND
#   Random Variable storage in a vector
######################################
# Initializes a vector that will store the random variables stored in the file "variables.txt"
list_of_VA=[]
# Reads lines of the "variable.txt" file, whose values ​​will replace into APDL File
with open(path_variables, "r") as variables:
    for line in variables.readlines():
        list_of_VA.append(line)
# Initialize a vector that stores the random variable without spaces       
Vetor_Aux1=[]
# Initializes a vector that stores the random variable without '\t'
Vetor_Aux2=[]
# Initializes a vector that stores the random variable without '\n'
Vetor_Aux3=[]
# Remove the spaces
for i in list_of_VA: 
    whatweneed=i.replace(" ","")
    Vetor_Aux1.append(whatweneed)
# Remove the "\t"    
for i in Vetor_Aux1:
    whatweneed=i.replace("\t","")
    Vetor_Aux2.append(whatweneed)
# Remove the "\n"    
for i in Vetor_Aux2:
    whatweneed=i.replace("\n","")
    Vetor_Aux3.append(whatweneed)    
    
# Vector with random variables
x=Vetor_Aux3
# Number of random variables
N_VA=len(x)

######################################
# Random Variables replacement  of the vector
# Into the APDL file
######################################
# Read in the file
with codecs.open(path_apdl, 'r', encoding='utf-8', errors='ignore') as file :
    filedata = file.read()
    pattern=re.compile(r'([xX])(\d+)\s*(=)\s*(-?\d*\.?\d*[Ee]?[+-]?0?\d*)')
    matches=pattern.finditer(filedata)
    # print(filedata)
# Replace the target string
    for match in matches:
        # print(match.group(0))
        for i in range(N_VA):
            va=f"x{i+1}={x[i]}"
            # print(va)
            teste_if=f'{i+1}'
            if match.group(2)==teste_if:
                filedata = filedata.replace(match.group(0), va)
                # print(filedata)
#print(filedata)

# Write the file out again 
with codecs.open(path_apdl, 'w', encoding='utf-8', errors='ignore') as file :
    filedata = file.write(filedata)
    
############
# END
############
       