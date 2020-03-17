# jupyterutils
Docker para cuaderno jupyter con utilidades

Variables de entorno:

  - JUPITER_TOKEN: Token para Jupyter (debe iniciar por un caracter alfanumerico)

```sh
$ docker run --rm -p 8888:8888 -e JUPITER_TOKEN=a123 aaadomi/jupyterutils
```
