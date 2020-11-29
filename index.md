# blasiusFoam
Complete documentation at [blasiusfoam.readthedocs.io](https://blasiusfoam.readthedocs.io)
A solver for incompressible laminar flow and heat transfer on a flat plate
- uses blasius equation
- ./Allwmake to compile the solver

## mySimpleFoam
- Modifield simpleFoam solver with temperature equation

### blasiusFoamCase
- a flat plate case to run and test the case with analytical solution
- ./Allrun to run the case, also calls ./Allplot to plot the results 

#### Skin Friction Coefficient
![Skin Friction Coefficient](/images/Cf.png)
#### Temperature
![Temperature](/images/theta_all.png)
#### Velocity
![Velocity](/images/velocity_all.png)
