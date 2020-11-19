set terminal pngcairo font "helvetica,10" size 1200, 750            
#set xrange [0:6]                                                    
set yrange [0:6]                                                    
#set yrange [0:1.2]                                                  
set grid                                                            
#set key bottom left                                                 
set key top right                                                 
set key samplen 2                                                   
set key spacing 1                                                   
set ylabel '{/Symbol h}'                                            
set xlabel '{/Symbol Q}+100x'                                            
set offset .05, .05                                                 
set output "theta_all.png"                                               
set title "Theta_{x=0.005/0.005/0.009}"                                                
                                                                    
ub = 0.2; 
us = 50.0;
etab(r, s) = r * sqrt(ub / (2 * 1.0e-5 * s))
etas(r, s) = r * sqrt(us / (2 * 1.0e-5 * s))
                                                                    
Te = 350
Tw = 275

bench = "../BlasiusSolution.dat"                                    
input1 = "blasiusFoam/postProcessing/sampleDict/300/x+0.005_T_u.xy"  
input2 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.005_T.xy"   
input3 = "blasiusFoam/postProcessing/sampleDict/300/x+0.007_T_u.xy"  
input4 = "blasiusFoam/postProcessing/sampleDict/300/x+0.009_T_u.xy"  
input5 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.007_T.xy"   
input6 = "mySimpleFoam/postProcessing/sampleDict/300/x+0.009_T.xy"   

#plot \
#	input1 u (($3/ub)+0.5):(etab($1, 0.005)) t "blasius_{x=0.005/7/9}" w l lw 2 lc rgb "#009E73", \
#	input2 u (($2/us)+0.5):(etas($1, 0.005)) t "simpleFoam" w l lw 2 dt 2 lc rgb "#0072B2", \
#	input3 u (($3/ub)+0.7):(etab($1, 0.007)) notitle w l lw 2 lc rgb "#009E73", \
#	input5 u (($2/us)+0.7):(etas($1, 0.007)) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
#	input4 u (($3/ub)+0.9):(etab($1, 0.009)) notitle w l lw 2 lc rgb "#009E73",\
#	input6 u (($2/us)+0.9):(etas($1, 0.009)) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
#	bench every ::5 u ($2+0.5):1 t "analytical" w p lw 1 pt 6 lc rgb "#D55E00",\
#	bench every ::5 u ($2+0.7):1 notitle w p lw 1 pt 6 lc rgb "#D55E00",\
#	bench every ::5 u ($2+0.9):1 notitle w p lw 1 pt 6 lc rgb "#D55E00"

plot \
	input1 u ((($2-Te)/(Tw-Te))+0.5):( etab($1, 0.005) ) t "blasius_{x=0.005/7/9}" w l lw 2 lc rgb "#009E73", \
	input2 u ((($2-Te)/(Tw-Te))+0.5):( etas($1, 0.005) ) t "simpleFoam" w l lw 2 dt 2 lc rgb "#0072B2", \
	input3 u ((($2-Te)/(Tw-Te))+0.7):( etab($1, 0.007) ) notitle w l lw 2 lc rgb "#009E73", \
	input5 u ((($2-Te)/(Tw-Te))+0.7):( etas($1, 0.007) ) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
	input4 u ((($2-Te)/(Tw-Te))+0.9):( etab($1, 0.009) ) notitle w l lw 2 lc rgb "#009E73", \
	input6 u ((($2-Te)/(Tw-Te))+0.9):( etas($1, 0.009) ) notitle w l lw 2 dt 2 lc rgb "#0072B2", \
	bench every ::5 u ($3+0.5):1 t "anlytical" w p lw 1 pt 6 lc rgb "#D55E00",\
	bench every ::5 u ($3+0.7):1 notitle w p lw 1 pt 6 lc rgb "#D55E00",\
	bench every ::5 u ($3+0.9):1 notitle w p lw 1 pt 6 lc rgb "#D55E00"
