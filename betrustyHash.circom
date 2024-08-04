pragma circom 2.0.0;

include "node_modules/circomlib/circuits/poseidon.circom";

template BeTrustyHash() {
    signal input userId; // id del sistema
    signal input score; // puntaje
    signal input assessment; // evaluacion
    signal input reputation; // oro , plata , bronce, etc ...
    signal input secret; // secret

    signal output hashedSecret;
    component hash = Poseidon(4);
    hash.inputs[0] <== userId;
    hash.inputs[1] <== score;
    hash.inputs[2] <== assessment;
    hash.inputs[3] <== reputation;        
    log(hash.out);
    hashedSecret <== hash.out;
}

component main = BeTrustyHash();