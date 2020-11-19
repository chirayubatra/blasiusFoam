set terminal pngcairo font "helvetica,10" size 1200, 750            
#set xrange [0:6]                                                    
set yrange [0:6]                                                    
#set yrange [0:1.2]                                                  
set grid                                                            
#set key bottom left                                                 
set key top left                                                 
set key samplen 2                                                   
set key spacing 1                                                   
set ylabel '{/Symbol h}'                                            
set xlabel "u/U+100x"                                                    
set offset .05, .05                                                 
set output "velocity_all.png"                                               
set title "Velocity_{x=0.002/0.005/0.007/0.009}"                                                
                                                                    
ub = 0.2; 
us = 50.0;
etab(r, s) = r * sqrt(ub / (2 * 1.0e-5 * s))
etas(r, s) = r * sqrt(us / (2 * 1.0e-5 * s))
                                                                    
bench = "../BlasiusSolution.dat"                                    
input1 = "blasiusFoam/postProcessing/sampleDict/300/x+0.005_T_u.xy"  
input2 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.005_U.xy"   
input3 = "blasiusFoam/postProcessing/sampleDict/300/x+0.007_T_u.xy"  
input4 = "blasiusFoam/postProcessing/sampleDict/300/x+0.009_T_u.xy"  
input5 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.007_U.xy"   
input6 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.009_U.xy"   
input7 = "blasiusFoam/postProcessing/sampleDict/300/x+0.002_T_u.xy"  
input8 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.002_U.xy"   

plot \
	input1 u (($3/ub)+0.5):(etab($1, 0.005)) t "blasius_{x=0.002/5/7/9}" w l lw 2 lc rgb "#009E73", \
	input2 u (($2/us)+0.5):(etas($1, 0.005)) t "simpleFoam" w l lw 2 dt 2 lc rgb "#0072B2", \
	input3 u (($3/ub)+0.7):(etab($1, 0.007)) notitle w l lw 2 lc rgb "#009E73", \
	input5 u (($2/us)+0.7):(etas($1, 0.007)) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
	input4 u (($3/ub)+0.9):(etab($1, 0.009)) notitle w l lw 2 lc rgb "#009E73",\
	input6 u (($2/us)+0.9):(etas($1, 0.009)) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
	input7 u (($3/ub)+0.2):(etab($1, 0.002)) notitle w l lw 2 lc rgb "#009E73",\
	input8 u (($2/us)+0.2):(etas($1, 0.002)) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
	bench every ::5 u ($2+0.5):1 t "analytical" w p lw 1 pt 6 lc rgb "#D55E00",\
	bench every ::5 u ($2+0.7):1 notitle w p lw 1 pt 6 lc rgb "#D55E00",\
	bench every ::5 u ($2+0.9):1 notitle w p lw 1 pt 6 lc rgb "#D55E00",\
	bench every ::5 u ($2+0.2):1 notitle w p lw 1 pt 6 lc rgb "#D55E00"

