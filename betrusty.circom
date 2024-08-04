pragma circom 2.0.0;

include "node_modules/circomlib/circuits/poseidon.circom";

template BeTrusty() {
    signal input linkedinProfession; // id del sistema
    signal input platformScore; // puntaje
    signal input residenceCountry; // evaluacion
    signal input creditScore; // oro , plata , bronce, etc ...
    signal input waletBalance; // secret
    signal input beTuserIdrustyHash; // todos los valores anteriores hasheados

    signal output hashedSecret;
    component hash = Poseidon(4);
    hash.inputs[0] <== userId;
    hash.inputs[1] <== score;
    hash.inputs[2] <== assessment;
    hash.inputs[3] <== reputation;        
    
    hashedSecret <== hash.out;

    log("hashedSecret : ",hashedSecret);    
    // Constraint to ensure the ownership is correct
    beTrustyHash === hashedSecret;
}

component main = BeTrusty();