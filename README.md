# Darvify Demo


App Swift para iOS usando API de Spotify


## Login

Implementa SafariServices para implementar un flujo OAuth, no es posible usar la App **sin conexión**.
La App no implementa checks de seguridad ni refresco de token.

## New Releases

Pantalla que llama al servicio [https://api.spotify.com/v1/browse/new-releases](https://developer.spotify.com/console/get-new-releases/) y lista los resultados en una tabla.
Permite ver el detalle del new release, además lista en una tabla los artistas y permite ver el detalle del artista

## Generos
Pantalla que llama al servicio [https://api.spotify.com/v1/recommendations/available-genre-seeds](https://developer.spotify.com/console/get-available-genre-seeds/) y lista los resultados en una tabla.