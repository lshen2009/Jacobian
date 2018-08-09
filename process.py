#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Aug  9 11:16:37 2018

@author: lulushen
"""
import re
import os
import math
#import numpy as np
os.chdir("/Users/lulushen/Documents/GC_speedup/CPU/Test_jacobian/code/Jacobian")

#----- define function -------
def get_coef(x):    
    x2=re.split('\(|\)|\*',x)
    x3=[i for i in x2 if i]
    if x3[0]=='B':
        x3.insert(0,'1')
    if x3[0]=='-B':
        x3[0]='B'
        x3.insert(0,'-1')        
    return([float(x3[0]),int(x3[2])])

def get_coef_list(xx):
    result=[]
    for x in xx:
        result.append(get_coef(x))
    return(result)
        

#--remove unnessary comments and make it simple ------------------
input_file=open('gckpp_Jacobian.F90','r')
output_file = open('simplified_Jacobian.sh', 'w')
for line in input_file:
    if not line.startswith('!'):
        output_file.write(line)
input_file.close()
output_file.close()


#-- get the start and end # for each equation ---------------------
input_file=open('simplified_Jacobian.sh','r')
lines=input_file.readlines()
starts=[]
ends=[]
for i in range(0,len(lines)):        
    line=lines[i]
    line=line.replace('\n','').replace(' ','')  
    if (line.startswith('JVS')):
        starts.append(i)
    if ((line.startswith('JVS') or line.startswith('&')) and (not line.endswith('&'))):
        ends.append(i)
input_file.close()
#diff=np.array(ends)-np.array(starts)

#--- calculate the coordinates ------------------------
sparse_coords=[]
for i in range(len(starts)):
    line=lines[starts[i]:(ends[i]+1)]
    ap=''.join(line)
    ap=ap.replace('&','').replace('\n','').replace(' ','')  
    ap=re.split('\=',ap)
    ap2=[x.strip() for x in ap]

    precursors=re.split('\(|\)',ap2[0])
    precursors=[x for x in precursors if x]
    row=int(precursors[1])

    ng=ap2[1].replace('-','+-')
    products=re.split('\+',ng)
    products=[x for x in products if x]
    if (len(products)==1 and products[0]=='0'):
        sparse_coords.extend([[row,1,0]])
    else:
        spdata=get_coef_list(products)    
        ap=[[row,x[1],x[0]] for x in spdata]
        sparse_coords.extend(ap)


rows=[x[0] for x in sparse_coords]
cols=[x[1] for x in sparse_coords]
vals=[x[2] for x in sparse_coords]
num=math.floor(len(rows)/10)

#-------Now write the coordinates into a datafile-------
start_space='     '
end_symbol='&\n'
output_file = open('Jacobian_para.F90', 'w')
output_file.write('MODULE Jacobian_para\n')
output_file.write('  PUBLIC\n')
output_file.write('  SAVE\n')

#--- save rows---
line='  INTEGER, PARAMETER, DIMENSION('+str(len(rows))+') :: Jac_rows = (/ &\n'
output_file.write(line)
for k in range(num+1):
    ind1=k*10+0
    ind2=ind1+9
    if ((ind2+1)<len(rows)):
        ap=start_space+','.join(str(x) for x in rows[ind1:(ind2+1)])+', '+end_symbol
    else:
        ap=start_space+','.join(str(x) for x in rows[ind1:(ind2+1)])+' /)\n'
    output_file.write(ap)

#--- save cols---
line='  INTEGER, PARAMETER, DIMENSION('+str(len(cols))+') :: Jac_cols = (/ &\n'
output_file.write(line)
for k in range(num+1):
    ind1=k*10+0
    ind2=ind1+9
    if ((ind2+1)<len(rows)):
        ap=start_space+','.join(str(x) for x in cols[ind1:(ind2+1)])+', '+end_symbol
    else:
        ap=start_space+','.join(str(x) for x in cols[ind1:(ind2+1)])+' /)\n'
    output_file.write(ap)

#--- save cols---
line='  INTEGER, PARAMETER, DIMENSION('+str(len(vals))+') :: Jac_vals = (/ &\n'
output_file.write(line)
for k in range(num+1):
    ind1=k*10+0
    ind2=ind1+9
    if ((ind2+1)<len(rows)):
        ap=start_space+','.join(str(x) for x in vals[ind1:(ind2+1)])+', '+end_symbol
    else:
        ap=start_space+','.join(str(x) for x in vals[ind1:(ind2+1)])+' /)\n'
    output_file.write(ap)
output_file.write("END MODULE Jacobian_para")
output_file.close()