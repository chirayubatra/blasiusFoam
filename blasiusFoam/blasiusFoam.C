/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2020 2020 AUTHOR,AFFILIATION
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

Application
    blasiusFoam

Description
    Steady-state solver for incompressible, turbulent flows. 

\*---------------------------------------------------------------------------*/

#include "fvCFD.H"
#include "singlePhaseTransportModel.H"
#include "turbulentTransportModel.H"
#include "simpleControl.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    argList::addNote
    (
        "Steady-state blasius solver for incompressible, laminar flows."
    );

    //#include "setRootCase.H"
    #include "postProcess.H"

    #include "addCheckCaseOptions.H"
    #include "setRootCaseLists.H"  // extends "setRootCase.H"
    #include "createTime.H"
    #include "createMesh.H"
    #include "createControl.H"
    #include "createFields.H"
//    #include "initContinuityErrs.H"

    // Validate the turbulence fields after construction.
    // Update turbulence viscosity and other derived fields as required
    
    //turbulence->validate();

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< nl;
    runTime.printExecutionTime(Info);

    Info << "\nStarting time loop\n" << endl; 

    while (runTime.loop())
    {
	    Info << "Time = " << runTime.timeName() << nl << endl; 
		#include "CourantNo.H"

		//3.1 x-momentum equation 
		//Info << "*********Solving for the velocity u\n"<< endl; 
		fvScalarMatrix uEqn
		(
		   fvm::div(phi, u)
		 - fvm::laplacian(nu, u)
		);

	//	uEqn.relax();

		uEqn.solve();

		//Info << "*********Calculating U\n"<< endl; 
		U = volVectorField
		(
		   vector(1, 0, 0)*u
		 + vector(0, 1, 0)*v
		 + vector(0, 0, 1)*v*0
		);

		phi = fvc::flux(U);

		//Info << "**********Solving continuity equation (Phi)\n"<< endl; 
		//3.2 continuity equation using velocity potential field
		fvScalarMatrix PhiEqn
		(
		   fvm::laplacian(dimensionedScalar("1", dimless, 1), Phi)
		   ==
		   fvc::div(phi)
		);

		PhiEqn.solve();

		phi -= PhiEqn.flux();
		// correcting the v boundary conditions

		volVectorField UIntermediate(fvc::reconstruct(phi));
		v = UIntermediate.component(vector::Y);
		v.correctBoundaryConditions();


		//Info << "*********Calculating temperature equation\n"<< endl; 
		//3.4 Energy Equation 
		fvScalarMatrix TEqn
		(
    	      	    fvm::div(phi,T)
		  - fvm::laplacian(nu/Pr,T)
		);

		TEqn.solve();


	    runTime.write();

    	    runTime.printExecutionTime(Info);
    }


    Info<< "End\n" << endl;

    return 0;
}


// ************************************************************************* //
