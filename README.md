## 

## Parámetros

```shell
signal input userId; // id del sistema
signal input score; // puntaje
signal input assessment; // evaluacion
signal input reputation; // oro , plata , bronce, etc ...
signal input secret; // secret
signal input beTrustyHash; // todos los valores anteriores hasheados
```
Primero Generaos la prueba de los inputs solamente



Luego generamos la prueba enviando ese secret

circom betrusty.circom --r1cs --wasm --sym --c

node betrustyHash_js/generate_witness.js betrustyHash_js/betrustyHash.wasm inputHash.json witness.wtns

Luego generamos el circuito y pruebas para betrusty

node betrusty_js/generate_witness.js betrusty_js/betrusty.wasm input.json witness.wtns

## Explicación Caso de Uso

BeTrusty establece algunos criterios, los cuales los usuarios pueden cumplir o no. Hay un requisito excluyente, que deben cumpplir todos los postulantes, este es: la solvencia económica suficiente. La cual equivale a tres meses de arriendo en algún address validada por el protocolo.

Luego, los negocios que ponen sus inmuebles en arriendo. seleccionan uno o más de los criterios que disponibiliza el protocolo e internamente los usuarios podrán visualizar los inmuebles a los cuáles puedan aplicar, siempre y cuando cumplan los requisitos.

El sistema funciona de la siguiente manera:

Si el usuario cumple con el requisito estipulado, el sistema retorna un `0` y si no cumple retorna un `1`.

Ejemplo:

El negocio decide que la persona debe tener nacionalidad Argentina. Este es el único criterio que solicita este negocio.

Internamente el usuario visualizará ese inmueble para aprobar solo si tiene nacionalidad Argentina.

Luego al momento de aplicar, se generará una prueba de conocimien cero (ZKP).

La cuál tomará los valores retornados por BeTrusty. 

Siguiente el mismo ejemplo, digamos que un usuario cumple  con la solvencia monetaria y es Argentino.

Además BeTrusty establece una valoración interna según la cantidad de requisitos que cumple en relación a los que estén disponibles en la plataforma. Este se conoce como `platformScore`. Por ejemplo: si hay 10 requisitos y cumple los 10, tiene categoría oro y esta se representa con un `3`.

La tabla de valores es la siguiente:

| Campo             | Valor |
|-------------------|-------|
| Oro               |  3    |
| Plata             |  2    |
| Bronce            |  1    |
| SinCategoria      |  0    |


Siguiendo con el ejemplo, los valores que se enviarían para las pruebas de conocimiento cero, serían los siguientes:

| Campo               | Valor |
|---------------------|-------|
| platformScore       | 2     |
| linkedinProfession  | 0     |
| residenceCountry    | 1     |
| creditScore         | 1     |
| waletBalance        | 1     |
| userId              | 20    | 

> ** Nota: ** solo userId y platformScore pueden ser distintos de `0` y `1`. 

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


