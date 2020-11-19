Info<< "Reading field u\n" << endl;
volScalarField u
(
    IOobject
    (
        "u",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Reading field v\n" << endl;
volScalarField v
(
    IOobject
    (
        "v",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Constructing and initializing field U\n" << endl;
volVectorField U
(
    IOobject
    (
        "U",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::AUTO_WRITE
    ),
    mesh, 
    dimensionedVector(dimVelocity, Zero)
);

// Initialise the velocity internal field to zero
//U = dimensionedVector(U.dimensions(), Zero);
 
// construct and initialize phi

 #include "createPhi.H"

//Info << "Reading/calculating face flux field phi\n" << endl; 
//
//surfScalarField phi
//(
// IOobject
// (
//  "phi",
//  runTime.timeName(),
//  mesh, 
//  IOobject::NO_READ, 
//  IOobject::AUTO_WRITE
// ),
// fvc::flux(U)
//);


// Infer the velocity potential BCs from the x-velocity
wordList PhiBCTypes
 (
     u.boundaryField().size(),
     fixedValueFvPatchScalarField::typeName
 );

forAll(u.boundaryField(), patchi)
   {
     if (u.boundaryField()[patchi].fixesValue())
         {
            PhiBCTypes[patchi] = zeroGradientFvPatchScalarField::typeName;
         }
   }


Info << "Constructing velocity potential field Phi\n" << endl; 
volScalarField Phi
(
 IOobject
 (
  "Phi",
  runTime.timeName(),
  mesh, 
  IOobject::NO_READ, 
  IOobject::AUTO_WRITE
 ),
 mesh, 
 dimensionedScalar(dimLength*dimVelocity, Zero),
 PhiBCTypes
);

//label PhiRefCell = 0;
//scalar PhiRefValue = 0;
//setRefCell
//(
//     Phi,
//     simple.dict(),
//     PhiRefCell,
//     PhiRefValue
//);
//mesh.setFluxRequired(Phi.name());


Info<< "Reading field T\n" << endl;
volScalarField T
(
    IOobject
    (
        "T",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

IOdictionary transportProperties
(
     IOobject
     (
       "transportProperties",
        runTime.constant(),
        mesh,
        IOobject::MUST_READ_IF_MODIFIED,
        IOobject::NO_WRITE
     )
);

//Pr = dimensionedScalar("Pr", dimless, transportProperties);
//nu = dimensionedScalar("nu", dimViscosity, transportProperties);


dimensionedScalar Pr ("Pr", dimless, transportProperties);
dimensionedScalar nu ("nu", dimViscosity, transportProperties);

//dimensionedScalar nuByPr ("nuByPr", dimViscosity, scalar(nu/Pr));

//label pRefCell = 0;
//scalar pRefValue = 0.0;
//setRefCell(p, simple.dict(), pRefCell, pRefValue);
//mesh.setFluxRequired(p.name());
//
//
//singlePhaseTransportModel laminarTransport(U, phi);
//
//autoPtr<incompressible::turbulenceModel> turbulence
//(
//    incompressible::turbulenceModel::New(U, phi, laminarTransport)
//);

