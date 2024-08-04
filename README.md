# BeTrusty Circuitos

En este depositorio de encuentran los circuitos para generar las ZKP.

## Parámetros

Luego generamos la prueba enviando ese secret

`circom betrusty.circom --r1cs --wasm --sym --c`

`node betrusty_js/generate_witness.js betrusty_js/betrusty.wasm input.json witness.wtns`

`snarkjs powersoftau new bn128 12 pot12_0000.ptau -v`    

`snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v`

`snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v`  

`snarkjs groth16 setup betrusty.r1cs pot12_final.ptau multiplier2_0000.zkey`

`snarkjs zkey contribute multiplier2_0000.zkey multiplier2_0001.zkey --name="1st Contributor Name" -v`

`snarkjs zkey export verificationkey multiplier2_0001.zkey verification_key.json`  

`snarkjs groth16 prove multiplier2_0001.zkey witness.wtns proof.json public.json`   

`snarkjs groth16 verify verification_key.json public.json proof.json`   

Exportar el contrato verifier

`snarkjs zkey export solidityverifier multiplier2_0001.zkey verifier.sol`

Imprimir los inputs para enviar al contrato verifier:

`snarkjs generatecall`

# Explicación Caso de Uso

A continuación se explica el funcionamiento del proyecto.

## Criterios de BeTrusty

BeTrusty establece varios criterios que los usuarios pueden cumplir o no. Hay un requisito excluyente que todos los postulantes deben cumplir: solvencia económica suficiente, equivalente a tres meses de alquiler en una dirección validada por el protocolo.

### Proceso de Selección

Los negocios que ofrecen inmuebles en alquiler seleccionan uno o más criterios proporcionados por el protocolo. Internamente, los usuarios podrán visualizar los inmuebles para los cuales cumplen los requisitos.

### Funcionamiento del Sistema

El sistema opera de la siguiente manera:

Si el usuario cumple con el requisito estipulado, el sistema retorna un `0`.
Si no cumple, retorna un `1`.
Ejemplo de Selección

Un negocio decide que los postulantes deben tener nacionalidad argentina. Este es el único criterio solicitado.

Internamente, los usuarios solo visualizarán ese inmueble si tienen nacionalidad argentina.
Al momento de aplicar, se generará una prueba de conocimiento cero (ZKP) que tomará los valores retornados por BeTrusty.
Valoración Interna

BeTrusty también establece una valoración interna llamada platformScore, basada en la cantidad de requisitos que cumple el usuario en relación a los disponibles en la plataforma. Esta valoración se clasifica de la siguiente manera:

| Campo             | Valor |
|-------------------|-------|
| Oro               |  3    |
| Plata             |  2    |
| Bronce            |  1    |
| SinCategoria      |  0    |

Siguiendo el ejemplo anterior, supongamos que un usuario cumple con la solvencia económica y es argentino. Los valores enviados para las pruebas de conocimiento cero serían los siguientes:

| Campo               | Valor |
|---------------------|-------|
| platformScore       | 2     |
| linkedinProfession  | 0     |
| residenceCountry    | 1     |
| creditScore         | 1     |
| waletBalance        | 1     |
| userId              | 20    | 
| nonce              | 0     | 
| clientRequeriments  | 2    | 


> **Nota** :  solo `userId` y `platformScore` pueden ser distintos de `0` y `1`. 

### Ejemplo Valores enviados al circuito

```JSON
{
    "linkedinProfession": "1", // si cumple con la profesion en linkedin
    "platformScore": "1", // que score tiene de la plataforma
    "residenceCountry": "1", // si cumple con el pais de residencia
    "creditScore": "1", // si cumple con los requisitos crediticios
    "waletBalance": "0", // si cumple con el requisito del balance
    "userId": "111", // id del usuario
    "nonce": "0",   // nonce interno para evitar colision
    "clientRequeriments": "2" // si cumple con la cantidad de requisitos que solicita el negocio
}
```

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](./LICENSE) para obtener más detalles.


