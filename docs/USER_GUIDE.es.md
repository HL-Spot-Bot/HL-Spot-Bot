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
| 📊 Panel | saldos, estado del mercado, estado de cada ciclo spot |
| 📈 Estadísticas | resultados de los ciclos spot y perp, por periodo |
| 🧩 Pares operados | pares spot y perp configurados para el bot, y sus ajustes |
| 🟣 Ciclos perp | entradas, take-profits, stop-losses y cierres de los pares perp |
| 🖐️ Órdenes manuales | coloque una orden manualmente; el bot sigue luego el ciclo como los demás |
| 🌐 Pares Hyperliquid | lista de los pares spot y perp de Hyperliquid; añada un par al bot desde aquí |
| ⚙️ Configuración | configuración global (se aplica sin reiniciar, excepto el puerto y la dirección de escucha) |
| 📝 Log | errores (y advertencias si están activadas) |
| 🔑 Cuenta Hyperliquid | wallet, clave del API wallet, fecha de caducidad |
| 📜 Licencia | licencia, suscripción, pago, instalación, eliminación de la cuenta |

El bot solo opera si **su cuenta de Hyperliquid está verificada** y **su licencia es
válida**. Sin una licencia válida, solo están disponibles las páginas Cuenta Hyperliquid y
Licencia.

Cuando el bot deja de operar (licencia finalizada, API wallet caducado o rechazado), **no
toca las órdenes ni las posiciones ya abiertas**: quedan bajo su responsabilidad.

Las subsecciones siguientes explican cómo decide el bot y, a continuación, cada campo de las páginas
**Pares operados** y **Configuración**.

### 6.1 Análisis de mercado: BULL, BEAR o RANGE

Antes de cada compra (spot) o entrada (perp), el bot analiza **el propio par**, con las velas
de ese par:

1. Obtiene las últimas **Número de velas obtenidas** velas (ajuste `LIMIT`) del
   **Intervalo de velas** del par (vacío = el ajuste global **Intervalo de velas**).
2. El **precio actual** es el cierre de la vela más reciente.
3. Calcula tres medias móviles de los cierres: **MA4**, **MA8** y **MA12** (su
   número de velas se define en **Configuración → Análisis de mercado**).
4. Determina el tipo de mercado, en este orden:
   - **RANGE** si la MA12 es plana: durante los últimos **Periodos MA12 verificados**, la MA12 se
     ha movido como máximo un **Umbral RANGE de MA12 (%)** entre su valor más bajo y el más alto;
   - si no, **BULL** si MA4 > MA8 > MA12;
   - si no, **BEAR** si MA4 < MA8 < MA12;
   - si no, **RANGE**.
5. También calcula el **rango**: el cierre más alto y el más bajo de las últimas
   **RANGE - periodos del rango** velas. Su amplitud es máximo − mínimo.

Cada par utiliza entonces **sus propios ajustes para el tipo de mercado detectado** (bloque BULL,
BEAR o RANGE del par). Si el análisis falla (Hyperliquid inaccesible), no se coloca nada
y el bot vuelve a intentarlo en la siguiente pasada.

### 6.2 Ciclo spot, paso a paso

Un ciclo spot es una compra seguida de una venta de la misma cantidad.

1. **Cuándo.** El bot comprueba cada par spot activado cada **Pausa corta del bucle de compra (min)**.
   Se intenta una compra cuando:
   - el par no está en pausa (véase el paso 6);
   - desde el intento anterior en este par ha transcurrido al menos el **menor** de los tres
     valores de **Intervalo entre compras (min)** del par (BULL, BEAR, RANGE), sea cual sea el
     mercado actual. El primer intento tras el arranque del bot espera el **Retraso antes de la primera compra (min)**.
2. **¿Permitido?** Las compras deben estar activadas globalmente (**Compras activadas (global)**) **y** en el
   bloque del par correspondiente al mercado actual (**Compras activadas**). Si no, el intento cuenta pero
   no se coloca nada.
3. **Precios.** Con *P* = precio actual:
   - precio de compra = *P* + **Offset de compra**; precio de venta objetivo = *P* + **Offset de venta**;
   - con la **Unidad del offset** `abs`, los offsets están en USDC; con `pct`, en % de *P*;
   - **en un mercado RANGE**, los offsets son **dinámicos**: compra = *P* − *d*, venta = *P* + *d*,
     con *d* = amplitud del rango × **RANGE - % del rango usado** / 100 / 2. Los offsets RANGE
     estáticos del par solo se usan si no se puede calcular el rango (amplitud 0).
4. **Cantidad.** Importe = **% del saldo USDC** × el USDC **disponible** (no retenido ya por
   órdenes abiertas). Cantidad = importe / precio de compra, redondeada **hacia abajo** al paso de tamaño del
   par. Si el valor de la orden es inferior al **Valor mínimo de orden (USDC)** (al menos 10 USDC,
   mínimo de Hyperliquid), la compra se rechaza y el log muestra "Value too low".
5. **Orden.** Se coloca una orden de compra limit al precio de compra. El ciclo aparece en el
   Panel como **Compra pendiente**, con el precio de venta objetivo ya registrado.
6. **Pausa.** Tras cada intento, se coloque o no la orden, el par espera la **Pausa tras un intento (min)** del bloque del mercado actual.
7. **Compra ejecutada.** El bot lo sabe por el historial de Hyperliquid, obtenido cada
   **Intervalo de obtención de Hyperliquid (min)**. El ciclo pasa a **Venta pendiente**. Una compra
   ejecutada parcialmente que sigue abierta permanece en **Compra pendiente**.
8. **Venta.** El bucle de venta (cada **Intervalo del bucle de venta (s)**) coloca una orden de venta limit al
   **precio de venta objetivo registrado en el paso 3**. Vende la cantidad realmente recibida:
   Hyperliquid cobra la comisión de compra en el token comprado, por lo que el bot vende la cantidad comprada
   menos esa comisión, redondeada hacia abajo al paso de tamaño. Puede quedar un pequeño resto en su wallet;
   un ciclo posterior lo vende cuando el saldo lo permite.
   - El precio de venta no se recalcula. Si el mercado ya está por encima, la venta se
     ejecuta inmediatamente al precio de mercado (mejor de lo previsto).
   - Si el saldo no es suficiente, el bot vuelve a intentarlo; tras 3 intentos, el problema se
     registra como **error** en el log.
9. **Venta ejecutada.** El ciclo pasa a **Completado**. El beneficio se calcula con el precio
   y la cantidad de venta reales y las comisiones reales: cantidad vendida × (precio de venta − precio de compra) − comisión
   de compra − comisión de venta.

Los interruptores **Ventas activadas** no tienen efecto actualmente: una vez ejecutada una compra, su venta
se coloca siempre.

**Ejemplo práctico (RANGE).** Precio actual 85.000; en las últimas 20 velas, el cierre más alto
es 85.200 y el más bajo 84.770: amplitud 430. Con **RANGE - % del rango usado** =
75: *d* = 430 × 75 / 100 / 2 = 161,25. Compra a 85.000 − 161,25 = 84.838,75; venta objetivo a
85.000 + 161,25 = 85.161,25. Con **% del saldo USDC** = 5 y 400 USDC disponibles: 20 USDC,
es decir, 20 / 84.838,75 = 0,0002357 del token base, redondeado hacia abajo al paso de tamaño del par.

### 6.3 Ciclo perp, paso a paso

Un ciclo perp es una entrada (long o short) y luego una salida por take-profit, stop-loss o cierre.

1. **Cuándo.** Mismas reglas que en spot: cada par perp activado se comprueba cada **Pausa corta del bucle de compra (min)**; pausa tras cada intento (**Pausa tras un intento (min)** del bloque del mercado
   actual) y el menor de los tres **Intervalo entre entradas (min)**.
2. **Antes de cualquier entrada, en cada pasada**, el bot aplica la **Dirección** actual a los ciclos
   ya abiertos en el par:
   - dirección **none**: las entradas aún no ejecutadas se cancelan; las posiciones abiertas siguen
     **Dirección fijada en "ninguna" con una posición abierta** (`keep_tp_sl` = dejar el take-profit
     y el stop-loss en su sitio; `close_market` / `close_limit` = cerrar la posición);
   - dirección **opuesta** a un ciclo abierto (por ejemplo `short` mientras hay un long abierto):
     una entrada aún no ejecutada se cancela y una posición abierta se cierra según **Cerrar en una inversión** (`market` = orden market; `limit` = orden limit al precio actual).
3. **Qué lado.** `long` o `short`: ese lado. `none`: ninguna entrada. `both`: según la
   **Regla de la dirección "both"**:
   - `first_filled`: se colocan una entrada long y una entrada short; la primera ejecutada cancela la
     otra;
   - `range_position`: long si el precio está en la mitad inferior del rango, short en la
     mitad superior; fuera de un mercado RANGE, ninguna entrada;
   - `alternate`: el lado opuesto al del ciclo anterior del par.
4. **Filtro de funding.** Ningún long si la tasa de funding es superior a +**Umbral de funding (%)**; ningún
   short si es inferior a −umbral. Si el funding no está disponible, ninguna entrada.
5. **Apalancamiento y margen.** Si es necesario, el bot fija el **Apalancamiento** y el **Modo de margen** del par en Hyperliquid antes de la entrada.
6. **Precios y tamaño.** Con *P* = precio actual: entrada = *P* + offset de entrada del lado, take-profit
   = *P* + offset de take-profit del lado (USDC o % según la **Unidad del offset**).
   Margen usado = **% del margen disponible** × margen disponible; tamaño = margen × apalancamiento
   / precio de entrada, redondeado hacia abajo.
7. **Entrada.** Orden limit al precio de entrada. Cuando se ejecuta, el bot coloca un
   **take-profit** (limit, reduce-only) al precio registrado y un **stop-loss** (stop
   market, reduce-only) a **Stop-loss (% del precio de entrada)** del precio de entrada real.
8. **Salida.** El ciclo termina cuando se ejecuta el take-profit, el stop-loss o un cierre. Las órdenes market y
   stop market aceptan una desviación máxima de **Slippage de las órdenes market (%)**.

Siga los ciclos perp en la página **🟣 Ciclos perp**.

### 6.4 Página Pares operados

La página **🧩 Pares operados** enumera los pares configurados para el bot.

- **Añadir un par**: en **🌐 Pares Hyperliquid**, haga clic en **Añadir** en la línea del par. Un par nuevo está
  **desactivado**; sus ajustes spot se rellenan previamente con los valores por defecto BULL / BEAR / RANGE de la
  página **Configuración**. Los ajustes perp deben introducirse.
- **Editar**: abre los ajustes del par: una parte general y luego un bloque por tipo de mercado
  (BULL, BEAR, RANGE). **Guardar** verifica cada valor; los campos incorrectos se resaltan.
- Columna **Configuración**: **completo**, o el número de campos **por completar**. Un par
  solo se puede activar cuando está completo.
- **Activar / Desactivar**: solo se operan los pares activados y completos. Solo se pueden activar los pares
  spot cotizados en USDC. Un par desactivado no coloca ninguna entrada nueva, pero **sus ciclos abiertos continúan
  hasta que se cierran**.
- **Eliminar**: solo es posible cuando el par no tiene ningún ciclo en curso. Desactívelo primero y
  espere a que terminen sus ciclos.
- Los cambios se aplican en la siguiente pasada del bucle correspondiente, sin reiniciar.

**Offsets** — precio de compra o de entrada = precio actual + offset; precio de venta o de take-profit =
precio actual + offset. Un offset negativo queda por debajo del precio actual.

#### Ajustes de un par spot

Parte general:

| Campo | Significado |
|---|---|
| Unidad del offset | `abs` = offsets en USDC; `pct` = offsets en % del precio actual |
| Intervalo de velas | velas del análisis de mercado de este par; vacío = **Intervalo de velas** global |
| RANGE - % del rango usado | offsets dinámicos en RANGE = ± (amplitud del rango × este %) / 2 |

Un bloque para BULL, uno para BEAR y uno para RANGE:

| Campo | Significado |
|---|---|
| Compras activadas | compras permitidas cuando se detecta este tipo de mercado |
| Ventas activadas | actualmente sin efecto: las ventas se colocan siempre |
| Offset de compra | precio de compra = precio actual + este offset (normalmente negativo); en RANGE, sustituido por el offset dinámico |
| Offset de venta | precio de venta objetivo = precio actual + este offset; en RANGE, sustituido por el offset dinámico |
| % del saldo USDC | parte del USDC disponible usada en cada compra |
| Pausa tras un intento (min) | espera tras cada intento de compra en este mercado |
| Intervalo entre compras (min) | tiempo mínimo entre dos intentos de compra; se usa el menor de los tres bloques |

#### Ajustes de un par perp

Parte general:

| Campo | Significado |
|---|---|
| Unidad del offset | `abs` = USDC; `pct` = % del precio actual |
| Intervalo de velas | igual que en spot |
| Apalancamiento | limitado al apalancamiento máximo del activo |
| Modo de margen | `cross` o `isolated` (algunos activos exigen `isolated`) |
| Stop-loss (% del precio de entrada) | orden stop market a este % del precio de entrada real |
| Umbral de funding (%) | ningún long si funding > +umbral; ningún short si funding < −umbral |
| Slippage de las órdenes market (%) | desviación máxima aceptada en las órdenes market y stop market |
| Regla de la dirección "both" | `first_filled`, `range_position` o `alternate` (véase 6.3); obligatoria en cuanto un bloque usa `both` |
| Cerrar en una inversión | `market` o `limit` |
| Dirección fijada en "ninguna" con una posición abierta | `keep_tp_sl`, `close_market` o `close_limit` |

Un bloque para BULL, uno para BEAR y uno para RANGE:

| Campo | Significado |
|---|---|
| Dirección | `long`, `short`, `both` o `none` (ninguna entrada) |
| Offset de entrada Long / Offset de take-profit Long | el take-profit debe estar por encima de la entrada |
| Offset de entrada Short / Offset de take-profit Short | el take-profit debe estar por debajo de la entrada |
| % del margen disponible | parte del margen disponible usada en cada entrada, igual para long y short |
| Pausa tras un intento (min) | espera tras cada intento de entrada en este mercado |
| Intervalo entre entradas (min) | tiempo mínimo entre dos intentos de entrada; se usa el menor de los tres bloques |

### 6.5 Página Configuración

**⚙️ Configuración** contiene los ajustes globales. Un valor modificado aquí se guarda y se aplica
inmediatamente (puerto y dirección de escucha: en el siguiente reinicio). **Valor por defecto** restablece
el valor original. La dirección del wallet y la clave del API wallet no se definen aquí (página
**🔑 Cuenta Hyperliquid**).

**Modo de funcionamiento**

| Ajuste | Por defecto | Significado |
|---|---|---|
| Modo simulación (DRY_RUN) | no | el bot lee Hyperliquid con normalidad, pero no envía ninguna orden ni registra ningún ciclo |

**Análisis de mercado** — común a todos los pares (véase 6.1)

| Ajuste | Por defecto | Significado |
|---|---|---|
| Intervalo de velas | 1h | velas usadas cuando un par no tiene un intervalo de velas propio |
| Periodo MA4 / Periodo MA8 / Periodo MA12 | 4 / 8 / 12 | número de velas de cada media móvil |
| Umbral RANGE de MA12 (%) | 0,25 | variación máxima de la MA12 para detectar un mercado RANGE |
| Periodos MA12 verificados | 5 | número de periodos durante los que se verifica la MA12 |
| Número de velas obtenidas | 100 | debe cubrir el mayor periodo usado (MA12 + periodos verificados, periodos del rango) |

**Activación de órdenes**

| Ajuste | Por defecto | Significado |
|---|---|---|
| Compras activadas (global) | sí | interruptor general: desactivado = ninguna compra en ningún par spot |
| Compras en BULL / BEAR / RANGE | sí / no / sí | valor por defecto para los nuevos pares spot |
| Ventas activadas (global), Ventas en BULL / BEAR / RANGE | — | actualmente sin efecto |

**Mercado BULL / BEAR / RANGE — valores por defecto para nuevos pares spot**: offsets de compra y de venta (USDC),
% del saldo USDC, pausa tras un intento, intervalo entre compras. Rellenan previamente un par spot
cuando se añade; **modificarlos no cambia los pares ya añadidos**. El bloque RANGE
contiene además:

| Ajuste | Por defecto | Significado |
|---|---|---|
| RANGE - periodos del rango | 20 | número de velas usadas para el máximo y el mínimo del rango (todos los pares) |
| RANGE - % del rango usado | 75 | valor por defecto para los nuevos pares spot |

Valores por defecto: BULL compra 0 / venta +1000, 3 %, pausa 10 min, intervalo 360 min; BEAR compra −1000 /
venta 0, 3 %, pausa 10 min, intervalo 360 min; RANGE compra −400 / venta +400, 5 %, pausa 10 min,
intervalo 180 min.

**Órdenes y comisiones**

| Ajuste | Por defecto | Significado |
|---|---|---|
| Valor mínimo de orden (USDC) | 10 | las órdenes más pequeñas no se colocan (mínimo de Hyperliquid: 10) |
| Comisión maker (%) | 0,04 | solo se usa cuando faltan las comisiones reales de una operación |
| Comisión taker (%) | 0,07 | estimación de la comisión de las órdenes market y stop market |

**Temporización y sincronización**

| Ajuste | Por defecto | Significado |
|---|---|---|
| Intervalo de obtención de Hyperliquid (min) | 10 | frecuencia con la que se obtienen las órdenes abiertas, las ejecuciones y el historial: una ejecución se detecta como máximo este tiempo después de producirse |
| Retraso antes de la primera compra (min) | 0 | tras el arranque del bot; se aplica en el siguiente arranque |
| Pausa corta del bucle de compra (min) | 1 | espera entre dos comprobaciones del intervalo de compra, y tras un error |
| Intervalo del bucle de venta (s) | 120 | espera entre dos pasadas del bucle de venta |

**Notificaciones de Telegram** — véase la sección 9.

**Interfaz web**

| Ajuste | Por defecto | Significado |
|---|---|---|
| Idioma | English | idioma de la interfaz web y de los mensajes de Telegram |
| Tema | Oscuro | visualización oscura o clara |
| Dirección de escucha | 0.0.0.0 | 0.0.0.0 = accesible desde la red local; 127.0.0.1 = solo este ordenador (reinicio) |
| Puerto de la interfaz web | 60000 | se aplica al reiniciar |
| Caché de la lista de pares (s) | 43200 | la lista de pares de Hyperliquid se conserva 12 h y se actualiza en segundo plano |
| Retraso entre solicitudes al catálogo (ms) | 150 | pausa entre dos solicitudes al cargar la lista de pares |
| Duración de la sesión (h) | 12 | se aplica a los siguientes inicios de sesión |
| Inicios de sesión fallidos antes del bloqueo | 5 | por dirección IP |
| Duración del bloqueo (min) | 15 | |

**Archivo de log**

| Ajuste | Por defecto | Significado |
|---|---|---|
| Registrar las advertencias | no | los errores se registran siempre; las advertencias solo si está activado (sección 12) |

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
