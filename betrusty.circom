pragma circom 2.0.0;

include "node_modules/circomlib/circuits/poseidon.circom";
include "node_modules/circomlib/circuits/comparators.circom";

template BeTrusty() {
    signal input linkedinProfession; // id del sistema
    signal input platformScore; // puntaje
    signal input residenceCountry; // evaluacion
    signal input creditScore; // oro , plata , bronce, etc ...
    signal input waletBalance; // secret
    signal input userId; 
    signal input nonce;
    signal input clientRequeriments; // todos los valores anteriores hasheados

    signal output hashedReputation;

    signal sum;
    sum <==  residenceCountry + creditScore + waletBalance;

    // Componente para validar si la sumatoria de los requisitos es mayor 
    // o igual al criterio del cliente
    component ge = GreaterEqThan(32);
    ge.in[0] <== sum;
    ge.in[1] <== platformScore;

    // validamos que sum sea mayor o igual que platformScore
    ge.out === 1;

    component hash = Poseidon(4);
    hash.inputs[0] <== platformScore;
    hash.inputs[1] <== residenceCountry;
    hash.inputs[2] <== creditScore;
    hash.inputs[3] <== waletBalance;        
    
    hashedReputation <== hash.out;

    log("hashedReputation : ",hashedReputation);    
    // Constraint to ensure the ownership is correct
    beTrustyHash === hashedReputation;
}

component main = BeTrusty();