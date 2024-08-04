# BeTrusty Circuitos

En este depositorio de encuentran los circuitos para generar las ZKP.

## Parámetros

Luego generamos la prueba enviando ese secret

circom betrusty.circom --r1cs --wasm --sym --c

node betrustyHash_js/generate_witness.js betrustyHash_js/betrustyHash.wasm inputHash.json witness.wtns

Luego generamos el circuito y pruebas para betrusty

node betrusty_js/generate_witness.js betrusty_js/betrusty.wasm input.json witness.wtns

## Explicación Caso de Uso



## Criterios de BeTrusty

BeTrusty establece varios criterios que los usuarios pueden cumplir o no. Hay un requisito excluyente que todos los postulantes deben cumplir: solvencia económica suficiente, equivalente a tres meses de alquiler en una dirección validada por el protocolo.

### Proceso de Selección

Los negocios que ofrecen inmuebles en alquiler seleccionan uno o más criterios proporcionados por el protocolo. Internamente, los usuarios podrán visualizar los inmuebles para los cuales cumplen los requisitos.

### Funcionamiento del Sistema

El sistema opera de la siguiente manera:

Si el usuario cumple con el requisito estipulado, el sistema retorna un 0.
Si no cumple, retorna un 1.
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

> **Nota** :  solo `userId` y `platformScore` pueden ser distintos de `0` y `1`. 

### Ejemplo Valores enviados al circuito

```JSON
{
{
    "linkedinProfession": "1",
    "platformScore": "1",
    "residenceCountry": "1",
    "creditScore": "1", 
    "waletBalance": "0",
    "userId": "111"    
}
}
```

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](./LICENSE) para obtener más detalles.


