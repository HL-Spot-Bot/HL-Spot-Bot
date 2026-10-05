# HL-Spot — Guía del usuario

Versión 1.0.2

HL-Spot es un bot de trading para **Hyperliquid**: mercados spot y perpetuos (perp), varios pares,
órdenes automáticas y manuales. Se ejecuta **en su propio ordenador** (Windows, Linux o Docker) y
usted lo controla desde su navegador web.

> **Sitio web**: https://hlspot.com
> **Descarga**: https://github.com/HL-Spot-Bot/HL-Spot-Bot
> **Soporte**: HL-spot@cmails.eu

---

## 1. Antes de empezar

Necesita:

- un ordenador con un procesador x86 de 64 bits (x86_64) con **Windows** o **Linux**, o cualquier
  máquina con **Docker**;
- o una cuenta de **Flux**, para ejecutarlo en la nube (sección 16);
- una cuenta de **Hyperliquid** con fondos (su wallet principal);
- un wallet capaz de **"firmar un mensaje"** con la dirección de su wallet principal. Una extensión
  del navegador (MetaMask, Rabby…) es lo más sencillo: el bot la abre por usted. Cualquier otro wallet
  funciona copiando y pegando;
- una conexión a Internet.

## 2. Seguridad: lo que debe saber

- HL-Spot solo acepta una clave de **API wallet** de Hyperliquid. **Nunca introduzca la clave privada
  de su wallet principal.** Un API wallet puede operar por usted, pero no puede retirar sus fondos.
- La clave del API wallet se **cifra** en su ordenador. **Nunca se envía** al servidor de
  licencias.
- Su wallet principal solo se utiliza para **firmar mensajes** (creación de la cuenta, contraseña
  olvidada, dirección BTC, eliminación de la cuenta). Un mensaje firmado no es una transacción: no
  cuesta nada y no mueve ningún fondo.
- La página web del bot está protegida por su contraseña. Es preferible usarla desde la máquina del
  bot (`http://localhost:60000`): desde otra máquina de su red, la página no está
  cifrada (véase la sección 15).

## 3. Crear su API wallet de Hyperliquid

1. Vaya a **https://app.hyperliquid.xyz/API** y conecte su wallet principal.
2. Asigne un nombre al API wallet y luego genérelo.
3. **Copie la clave privada** mostrada y guárdela en un lugar seguro: Hyperliquid solo la muestra una vez.
4. Autorice el API wallet (firma con su wallet principal).
5. Anote la **fecha de caducidad** del API wallet que muestra Hyperliquid.

En HL-Spot introducirá: la **dirección de su wallet principal** (0x…) y la **clave privada del API
wallet**.

## 4. Instalar HL-Spot

Descargue el archivo correspondiente a su sistema y su archivo `.sha256` desde
https://github.com/HL-Spot-Bot/HL-Spot-Bot. El archivo `.sha256` permite comprobar que la descarga está
intacta.

### Windows

1. Descomprima `HL-Spot-1.0.2-prod-windows-x64.zip`.
2. En la carpeta descomprimida, ejecute **`HL-Spot.exe`**. Se abre una ventana de consola: manténgala
   abierta mientras el bot esté en funcionamiento.
3. Abra **http://localhost:60000** en su navegador.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 o posterior)

```
unzip HL-Spot-1.0.2-prod-linux-x64.zip
cd HL-Spot-1.0.2-prod-linux-x64
./hl-spot
```

A continuación, abra **http://localhost:60000** en su navegador.

### Docker

```
docker load -i HL-Spot-1.0.2-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.2
```

- `-p 60000:60000` es necesario para acceder a la página web.
- `TZ` define la zona horaria (UTC si se omite).
- Sus datos permanecen en el volumen `hl-spot-data`, incluso si se elimina el contenedor o se
  actualiza la imagen.
- `docker stop hl-spot` detiene el bot de forma limpia.

A continuación, abra **http://localhost:60000** (o `http://<machine address>:60000`).

### Dónde se guardan sus datos

Sus datos (configuración, clave cifrada, base de datos, log) se guardan **fuera del programa**:

| Sistema | Carpeta |
|---|---|
| Windows | `%LOCALAPPDATA%\HL-Spot` |
| Linux | `~/.local/share/hl-spot` |
| Docker | el volumen `/data` |

Reinstalar o actualizar el programa nunca los modifica.

## 5. Primer inicio

La primera página es **Primer inicio**. Elija:

- **Crear una cuenta** si es nuevo;
- **Ya tengo una cuenta** si ya tiene una cuenta de HL-Spot (nuevo ordenador,
  reinstalación).

### Crear una cuenta

1. **Dirección del wallet**: la dirección de su wallet principal (0x…).
2. **Clave privada del API wallet**: la clave copiada en la sección 3. Se verifica con Hyperliquid
   antes de cualquier otra cosa.
3. **Contraseña**: al menos 8 caracteres, con una letra mayúscula, una letra minúscula, un
   dígito y un carácter especial. Protege tanto su cuenta de HL-Spot como la página web del
   bot.
4. **Firma del wallet principal**:
   - **Firmar con mi wallet**: el bot abre la extensión de su wallet; compruebe la dirección y
     confirme la firma;
   - o **Obtener el mensaje a firmar**: copie el mensaje tal cual en su wallet, fírmelo y
     pegue la firma (0x…). El mensaje es válido durante 15 minutos.
5. Haga clic en **Crear la cuenta**.

Comienza su **prueba gratuita de 7 días**. Solo se concede una vez por wallet y por
instalación. El trading comienza una vez verificada su cuenta de Hyperliquid.

### Ya tengo una cuenta

Introduzca la dirección de su wallet y su contraseña. Esta instalación queda registrada y la
anterior se libera (**un cambio de instalación cada 30 días**).

## 6. Uso del bot

El menú de la parte superior da acceso a:

| Página | Uso |
|---|---|
| 📊 Panel | saldos, estado del mercado, estado de cada par |
| 📈 Estadísticas | Resultados de los ciclos spot y perp, por periodo |
| 🧩 Pares operados | Pares spot y perp configurados para el bot |
| 🟣 Ciclos perp | Entradas, take-profits, stop-losses y cierres de los pares perp |
| 🖐️ Órdenes manuales | Coloque una orden manualmente; el bot sigue luego el ciclo como los demás |
| 🌐 Pares Hyperliquid | lista de los pares spot y perp de Hyperliquid |
| ⚙️ Configuración | toda la configuración (se aplica sin reiniciar, excepto el puerto y la dirección de escucha) |
| 📝 Log | errores (y advertencias si están activadas) |
| 🔑 Cuenta Hyperliquid | wallet, clave del API wallet, fecha de caducidad |
| 📜 Licencia | licencia, suscripción, pago, instalación, eliminación de la cuenta |

El bot solo opera si **su cuenta de Hyperliquid está verificada** y **su licencia es
válida**. Sin una licencia válida, solo están disponibles las páginas Cuenta Hyperliquid y
Licencia.

Cuando el bot deja de operar (licencia finalizada, API wallet caducado o rechazado), **no
toca las órdenes ni las posiciones ya abiertas**: quedan bajo su responsabilidad.

## 7. Licencia y suscripción

### Precios

| Suscripción | Precio |
|---|---|
| 7 días | 2 $ |
| 30 días | 6 $ |

El periodo pagado se añade al final de su licencia actual (o comienza en la fecha de pago
si la licencia ha finalizado).

### Cómo pagar

En la página **Licencia**, bloque **Suscripción y pago**:

1. elija la suscripción, el token y la red;
2. el bot muestra el **importe exacto**, la **dirección de recepción** y la dirección **desde la
   que debe pagar**. El importe es válido durante **1 hora** (menos si el precio varía más de un
   10 %);
3. envíe **exactamente este importe**, en **esta red**, **desde el wallet de su cuenta de
   HL-Spot**;
4. el pago se reconoce automáticamente (unos minutos según la red) y la
   licencia se prolonga.

Los tokens y las redes disponibles son los que se muestran en la página Licencia.

**Reglas — léalas antes de pagar:**

- pague **exactamente** el importe solicitado, ni más ni menos; **las comisiones de red corren de su cuenta**;
- pague **desde el wallet de su cuenta** (para BTC: desde su dirección BTC declarada);
- pague en la red indicada, mientras el importe sea válido;
- un pago que no respete estas reglas (dirección desconocida, importe diferente, otra
  red, fuera del periodo de validez) **se pierde: sin reembolso**.

### Pagar en BTC

Antes de su primer pago en BTC, declare su **dirección BTC** en la página Licencia (prueba mediante
una firma de su wallet principal). El pago solo se reconoce si se envía **desde esta dirección
BTC**: en su wallet BTC, elija esta dirección como origen del pago ("coin
control").

### Comprobaciones de la licencia

- La licencia se comprueba con el servidor **cada 6 horas**.
- Si no se puede contactar con el servidor, el bot continúa hasta la fecha de finalización conocida
  de la licencia.
- **24 horas antes del final**: aviso en las páginas web y por Telegram.
- Después del final: **24 horas de gracia** (el trading continúa, con un aviso) y luego el trading
  se detiene.
- No atrase el reloj de su ordenador: un reloj atrasado más de 5 minutos detiene el
  trading hasta la siguiente comprobación correcta.

## 8. API wallet: caducidad y sustitución

- La página **Cuenta Hyperliquid** muestra la fecha de caducidad de su API wallet. Puede
  introducirla usted mismo si es necesario.
- Durante los **últimos 7 días**: aviso en las páginas web y un mensaje diario por Telegram.
- En la fecha de caducidad, el trading se detiene. Cree un nuevo API wallet (sección 3) e introduzca su clave en
  la página **Cuenta Hyperliquid**: el trading se reanuda sin reiniciar el programa.
- La nueva clave debe pertenecer al **mismo wallet principal**: la dirección del wallet no se puede cambiar.
- El bot comprueba con Hyperliquid al arrancar y cada 24 horas que el API wallet sigue
  perteneciendo a su wallet.

## 9. Notificaciones de Telegram

En **Configuración → Notificaciones de Telegram**:

1. cree un bot de Telegram con **@BotFather** y copie su token;
2. obtenga su chat ID (por ejemplo, con **@userinfobot**);
3. introduzca el token y el chat ID, luego active las notificaciones y elija los mensajes
   (órdenes colocadas, compras ejecutadas, ciclos completados, errores, resumen diario).

## 10. Usar HL-Spot en otro ordenador

Instale el bot en el nuevo ordenador y elija **Ya tengo una cuenta** en el primer
inicio. La instalación anterior se libera. **Un cambio cada 30 días.** La página Licencia
muestra la fecha del próximo cambio posible.

## 11. Contraseña olvidada

En la página de inicio de sesión, haga clic en **¿Olvidó su contraseña?**. Demuestre que es el propietario del wallet mediante una
**firma de su wallet principal** y luego elija una nueva contraseña.

## 12. Log

La página **📝 Log** muestra los errores registrados por el bot (y las advertencias si
**Configuración → Archivo de log → Registrar las advertencias** está activado). El archivo está limitado a 1 MB: las
entradas más antiguas se eliminan. Puede filtrar, descargar el archivo (útil para el soporte) y
vaciarlo.

## 13. Eliminar su cuenta

Página **Licencia**, **🗑️ Eliminar mi cuenta**: contraseña + firma de su wallet principal.

- Su cuenta de HL-Spot se elimina **de forma definitiva**.
- El tiempo de licencia restante **se pierde y no se reembolsa**.
- La prueba gratuita **no** se vuelve a conceder para este wallet.
- En este ordenador, se borran la dirección del wallet, la clave del API wallet y la contraseña; el
  historial de trading se conserva.

## 14. Actualizaciones y copia de seguridad

- **Actualización**: instale la nueva versión (descomprímala o cargue la nueva imagen Docker); sus datos
  se conservan (sección 4).
- **Copia de seguridad**: copie la carpeta de datos (sección 4). El archivo `.env` y el archivo `secret.key` van
  **juntos**: los valores cifrados de `.env` y de la base de datos no se pueden leer sin
  `secret.key`. Si se pierde `secret.key`, estos valores (clave del API wallet, token de Telegram…) deben
  volver a introducirse.

## 15. Acceso desde otra máquina

Por defecto, la página web escucha en todas las interfaces de red, puerto **60000** (**Configuración → Interfaz
web**, se aplica al reiniciar). Desde otra máquina de su red: `http://<bot
machine address>:60000`.

En la red, la página **no está cifrada**: introduzca la clave de su API wallet y su contraseña
preferiblemente desde la máquina del bot. Nunca exponga el puerto 60000 directamente a Internet.

## 16. Ejecutar HL-Spot en Flux

[Flux](https://runonflux.com) es una nube descentralizada: alquila contenedores en servidores
(nodos) gestionados por terceros. HL-Spot puede funcionar allí día y noche sin su ordenador.
Flux es independiente de HL-Spot y se paga a Flux.

### La clave de su API wallet en Flux: lea esto primero

En Flux, los datos del bot (`/data`: la clave cifrada del API wallet **y** el archivo
`secret.key` que la descifra) están en servidores gestionados por otras personas, copiados en
3 nodos. Usted elige el tipo de aplicación al desplegarla:

- **Aplicación «enterprise»** (nodos ArcaneOS), recomendada: Flux indica que los operadores
  de los nodos no pueden acceder a los datos de la aplicación (disco cifrado, acceso root
  restringido) y que las variables de entorno siguen siendo privadas.
- **Aplicación ordinaria**: un operador de nodo puede leer `/data` y, por tanto, la clave de su
  API wallet; las variables de entorno, incluido el código de primer inicio, pueden ser leídas
  por cualquiera. Un API wallet no puede retirar sus fondos, pero quien tenga su clave puede
  operar en su cuenta. Bajo su propio riesgo.

Sea cual sea el tipo, puede revocar el API wallet en Hyperliquid en cualquier momento
(sección 3).

### Ajustes de la aplicación

| Campo de Flux | Valor |
|---|---|
| Imagen | `olivier1246/hl-spot:1.0.2` |
| Puerto y puerto del contenedor | `60000` |
| Datos del contenedor | `g:/data` (**obligatorio**) |
| CPU | 0,2 |
| RAM | 300 MB (auméntela si la aplicación se reinicia por falta de memoria) |
| SSD | 3 GB |
| Instancias | 3 (mínimo de Flux) |
| Entorno | `HL_SPOT_SETUP_CODE=<su código>` (**obligatorio**), `TZ=Europe/Paris` (opcional) |

- `g:/data`: **una sola** instancia ejecuta el bot; las otras 2 guardan una copia sincronizada
  de los datos y toman el relevo si se detiene. No use nunca otro valor: el bot funcionaría en
  3 máquinas a la vez y enviaría cada orden 3 veces.
- `HL_SPOT_SETUP_CODE`: un código de 12 caracteres o más, distinto de su contraseña. Sin él,
  cualquiera que encuentre la dirección de la aplicación podría crear la cuenta antes que usted.

### Primer inicio en Flux

1. Abra la dirección **https** que Flux da para la aplicación.
2. Siga la sección 5 e introduzca su código en el recuadro **Código de primer inicio**.
3. Use un navegador con la extensión de su wallet: el bot firma el mensaje con ella.

### Conviene saber

- La instalación sigue a los datos: cuando el bot cambia de nodo, no cuenta como un cambio de
  instalación (sección 10).
- Tras un cambio de nodo, el bot se reinicia desde la copia sincronizada: compruebe sus órdenes
  abiertas en Hyperliquid.
- **Actualización**: cambie la imagen por la nueva versión en los ajustes de la aplicación en
  Flux.
- La página es accesible desde Internet: está protegida por su contraseña. Elija una robusta.

## 17. Soporte

- Correo electrónico: HL-spot@cmails.eu

Cuando contacte con el soporte, adjunte el archivo de log (página **📝 Log** → Descargar el archivo). Nunca
envíe la clave de su API wallet, su archivo `secret.key` ni su contraseña.
