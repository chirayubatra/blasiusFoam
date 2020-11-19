set terminal pngcairo font "helvetica,10" size 750, 750
set output 'Cf.png'                                               
set multiplot layout 2,1 columnsfirst spacing 0.1 title "Skin Friction Coefficient"
#set xrange [0:0.06]                                                    
#set yrange [0:1.2]                                                  
set grid                                                            
set key bottom left                                                 
set key samplen 2                                                   
set key spacing 1                                                   
#set xlabel 'x/L'                                            
#set ylabel 'C_f'                                            
#set offset .05, .05                                                 
#set output 'Cf.png'                                               
#set title "Skin Friction Coefficient"                                                
                                                                    
ub = 0.2;
us = 50.0;  
L=0.01;
nu = 1e-5;
etab(r, s) = r * sqrt(ub / (2 * 1.0e-5 * s))
etas(r, s) = r * sqrt(us / (2 * 1.0e-5 * s))
Cfxs(s) = 0.664/sqrt(us*s/nu)
Cfxb(s) = 0.664/sqrt(ub*s/nu)

Te = 350
Tw = 275
                                                                    
bench = "../BlasiusSolution.dat"                                    
input1 = "blasiusFoam/postProcessing/sampleLowerPatch/surface/300/wallShearStress_patch_bottomWall.raw"  
input2 = "mySimpleFoam/postProcessing/sampleLowerPatch/surface/300/wallShearStress_patch_bottomWall.raw"  

set ylabel 'C_f'                                            
plot input2 every ::3 u ($1/L):(sqrt($4*$4+$5*$5+$6*$6))/(0.5*us*us) t "simpleFoam" w l lw 2 lc rgb "red" ,\
input2 every::3 u($1/L):(Cfxs($1)) t "analytical" w p lw 1 pt 6 lc rgb "blue"
set xlabel 'x/L'                                            
set ylabel 'C_f'                                            
plot input1 every ::3 u ($1/L):(sqrt($4*$4+$5*$5+$6*$6))/(0.5*ub*ub) t "blasiusFoam" w l lw 2 lc rgb "orange" ,\
input1 every::3 u($1/L):(Cfxb($1)) t "analytical" w p lw 1 pt 6 lc rgb "blue"
unset multiplot
unset output
