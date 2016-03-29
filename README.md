# English:

## FreePascal implementation of AFIP Argentina REST Public API

Please see the documentation included in the Docs folder

Dependencies: (all included ./Third-Party)

lkJSON Library: https://sourceforge.net/projects/lkjson/
Synapse Library: https://sourceforge.net/p/synalist/code/HEAD/tree/trunk/
dathox Generics.Collections:  https://github.com/dathox/generics.collections

Please note that the REST Server requires HTTPS protocol. Synapse implements SSL in a plugin-based architecture

See more here: http://synapse.ararat.cz/doku.php/public:howto:sslplugin

In the included demo, the project uses the OpenSSL implementation. OpenSSL external libraries are included:

./Third-Party/OpenSSL - 32 bits -- for Windows 32 bit
./Third-Party/OpenSSL - 64 bits -- for Windows 64 bit

These libraries are loaded dynamically at runtime; you need to copy the two libraries to your binary folder (or add them to the system path)

If you get an `ESynapseException` with an ErrorCode 500 you didn't setup Synapse to load the SSL libraries

For a Delphi version, please go to https://github.com/ortuagustin/Delphi-Utils

# Español:

## Implementacion que encapsula consultas al padron de contribuyentes de Argentina, utilizando la API REST que expone la AFIP

Documentacion oficial incluida en el directorio ./Docs

Dependencias (todas incluidas en el directorio ./Third-Party)

Biblioteca lkJSON: https://sourceforge.net/projects/lkjson/
Biblioteca Synapse: https://sourceforge.net/p/synalist/code/HEAD/tree/trunk/
dathox Generics.Collections:  https://github.com/dathox/generics.collections

El servidor REST requiere que se establezca una conexion mediante el protocolo HTTPS

La biblioteca Synapse implementa el protocolo SSL usando una arquitectura basada en plugins
Mas informacion: http://synapse.ararat.cz/doku.php/public:howto:sslplugin

En el demo incluido, se usa la implementacion OpenSSL, que requiere ademas bibliotecas externas, incluidas en:

./Third-Party/OpenSSL - 32 bits -- para Windows 32 bit
./Third-Party/OpenSSL - 64 bits -- para Windows 64 bit

Estas bibliotecas son cargadas dinamicamente en tiempo de ejecucion, asi que es necesario que:

- Esten en la misma ruta que el binario ejecutable
- Esten incluidas en la variable Path del sistema

Si se eleva una excepcion `ESynapseException` con un ErrorCode 500 la biblioteca Synapse no pudo inicializar correctamente el plugin que implementa SSL

Para una version para Delphi, visita: https://github.com/ortuagustin/Delphi-Utils

