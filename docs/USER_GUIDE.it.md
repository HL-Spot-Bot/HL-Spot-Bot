# HL-Spot — Guida utente

Versione 1.0.2

HL-Spot è un bot di trading per **Hyperliquid**: mercati spot e perpetual (perp), più coppie,
ordini automatici e manuali. Funziona **sul tuo computer** (Windows, Linux o Docker) e lo
controlli dal tuo browser web.

> **Sito web**: https://hlspot.com
> **Download**: https://github.com/HL-Spot-Bot/HL-Spot-Bot
> **Supporto**: HL-spot@cmails.eu

---

## 1. Prima di iniziare

Ti servono:

- un computer con processore x86 a 64 bit (x86_64) con **Windows** o **Linux**, oppure una
  qualsiasi macchina con **Docker**;
- oppure un account **Flux**, per eseguirlo nel cloud (sezione 16);
- un account **Hyperliquid** con fondi (il tuo wallet principale);
- un wallet in grado di **"firmare un messaggio"** con l'indirizzo del tuo wallet principale. Un'estensione
  del browser (MetaMask, Rabby…) è la soluzione più semplice: il bot la apre per te. Qualsiasi altro wallet funziona tramite
  copia e incolla;
- una connessione Internet.

## 2. Sicurezza: cosa devi sapere

- HL-Spot accetta solo una chiave di **API wallet** di Hyperliquid. **Non inserire mai la chiave privata
  del tuo wallet principale.** Un API wallet può fare trading per te ma non può prelevare i tuoi fondi.
- La chiave dell'API wallet è **cifrata** sul tuo computer. Non viene **mai inviata** al server
  delle licenze.
- Il tuo wallet principale serve solo a **firmare messaggi** (creazione dell'account, password dimenticata,
  indirizzo BTC, eliminazione dell'account). Un messaggio firmato non è una transazione: non costa nulla
  e non sposta fondi.
- La pagina web del bot è protetta dalla tua password. È preferibile usarla dalla macchina del bot
  (`http://localhost:60000`): da un'altra macchina della tua rete, la pagina non è
  cifrata (vedi sezione 15).

## 3. Crea il tuo API wallet Hyperliquid

1. Vai su **https://app.hyperliquid.xyz/API** e collega il tuo wallet principale.
2. Assegna un nome all'API wallet, poi generalo.
3. **Copia la chiave privata** mostrata e conservala in un luogo sicuro: Hyperliquid la mostra una sola volta.
4. Autorizza l'API wallet (firma con il tuo wallet principale).
5. Annota la **data di scadenza** dell'API wallet indicata da Hyperliquid.

In HL-Spot inserirai: l'**indirizzo del tuo wallet principale** (0x…) e la **chiave privata
dell'API wallet**.

## 4. Installa HL-Spot

Scarica il file per il tuo sistema e il relativo file `.sha256` da
https://github.com/HL-Spot-Bot/HL-Spot-Bot. Il file `.sha256` ti permette di verificare che il download sia
integro.

### Windows

1. Decomprimi `HL-Spot-1.0.2-prod-windows-x64.zip`.
2. Nella cartella decompressa, esegui **`HL-Spot.exe`**. Si apre una finestra di console: tienila aperta finché
   il bot è in funzione.
3. Apri **http://localhost:60000** nel tuo browser.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 o successivi)

```
unzip HL-Spot-1.0.2-prod-linux-x64.zip
cd HL-Spot-1.0.2-prod-linux-x64
./hl-spot
```

Poi apri **http://localhost:60000** nel tuo browser.

### Docker

```
docker load -i HL-Spot-1.0.2-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.2
```

- `-p 60000:60000` è necessario per raggiungere la pagina web.
- `TZ` imposta il fuso orario (UTC se omesso).
- I tuoi dati restano nel volume `hl-spot-data`, anche se il container viene rimosso o l'immagine
  aggiornata.
- `docker stop hl-spot` arresta il bot in modo pulito.

Poi apri **http://localhost:60000** (oppure `http://<machine address>:60000`).

### Dove sono conservati i tuoi dati

I tuoi dati (impostazioni, chiave cifrata, database, log) sono conservati **al di fuori del programma**:

| Sistema | Cartella |
|---|---|
| Windows | `%LOCALAPPDATA%\HL-Spot` |
| Linux | `~/.local/share/hl-spot` |
| Docker | il volume `/data` |

Reinstallare o aggiornare il programma non li tocca mai.

## 5. Primo avvio

La prima pagina è **Primo avvio**. Scegli:

- **Crea un account** se sei un nuovo utente;
- **Ho già un account** se hai già un account HL-Spot (nuovo computer,
  reinstallazione).

### Crea un account

1. **Indirizzo del wallet**: l'indirizzo del tuo wallet principale (0x…).
2. **Chiave privata dell'API wallet**: la chiave copiata nella sezione 3. Viene verificata presso Hyperliquid
   prima di ogni altra cosa.
3. **Password**: almeno 8 caratteri, con una lettera maiuscola, una lettera minuscola, una
   cifra e un carattere speciale. Protegge sia il tuo account HL-Spot sia la pagina web
   del bot.
4. **Firma del wallet principale**:
   - **Firma con il mio wallet**: il bot apre l'estensione del tuo wallet; verifica l'indirizzo e
     conferma la firma;
   - oppure **Ottieni il messaggio da firmare**: copia il messaggio così com'è nel tuo wallet, firmalo e
     incolla la firma (0x…). Il messaggio è valido per 15 minuti.
5. Fai clic su **Crea l'account**.

Inizia la tua **prova gratuita di 7 giorni**. Viene concessa una sola volta per wallet e per
installazione. Il trading inizia non appena il tuo account Hyperliquid è verificato.

### Ho già un account

Inserisci l'indirizzo del tuo wallet e la tua password. Questa installazione viene registrata e la
precedente viene liberata (**un cambio di installazione ogni 30 giorni**).

## 6. Usare il bot

Il menu in alto dà accesso a:

| Pagina | Uso |
|---|---|
| 📊 Dashboard | Saldi, stato del mercato, stato di ogni ciclo spot |
| 📈 Statistiche | Risultati dei cicli spot e perp, per periodo |
| 🧩 Coppie negoziate | Coppie spot e perp configurate per il bot, e le loro impostazioni |
| 🟣 Cicli perp | Entrate, take-profit, stop-loss e chiusure delle coppie perp |
| 🖐️ Ordini manuali | Piazza un ordine manualmente; il bot segue poi il ciclo come gli altri |
| 🌐 Coppie Hyperliquid | Elenco delle coppie spot e perp di Hyperliquid; da qui aggiungi una coppia al bot |
| ⚙️ Impostazioni | Impostazioni globali (applicate senza riavvio, tranne porta e indirizzo di ascolto) |
| 📝 Log | Errori (e avvisi se attivati) |
| 🔑 Account Hyperliquid | Wallet, chiave dell'API wallet, data di scadenza |
| 📜 Licenza | Licenza, abbonamento, pagamento, installazione, eliminazione dell'account |

Il bot fa trading solo se **il tuo account Hyperliquid è verificato** e **la tua licenza è
valida**. Senza una licenza valida, sono disponibili solo le pagine Account Hyperliquid e
Licenza.

Quando il bot smette di fare trading (licenza scaduta, API wallet scaduto o rifiutato), **non
tocca gli ordini e le posizioni già aperti**: restano sotto la tua responsabilità.

Le sottosezioni seguenti spiegano come decide il bot, poi ogni campo delle pagine **Coppie
negoziate** e **Impostazioni**.

### 6.1 Analisi di mercato: BULL, BEAR o RANGE

Prima di ogni acquisto (spot) o entrata (perp), il bot analizza **la coppia stessa**, sulle
candele di quella coppia:

1. Recupera le ultime **Numero di candele recuperate** candele (impostazione `LIMIT`)
   dell'**Intervallo delle candele** della coppia (vuoto = l'impostazione globale **Intervallo delle candele**).
2. Il **prezzo attuale** è la chiusura della candela più recente.
3. Calcola tre medie mobili delle chiusure: **MA4**, **MA8** e **MA12** (il loro numero di
   candele si imposta in **Impostazioni → Analisi di mercato**).
4. Determina il tipo di mercato, in quest'ordine:
   - **RANGE** se la MA12 è piatta: negli ultimi **Periodi MA12 verificati**, la MA12 si è
     mossa al massimo di **Soglia RANGE MA12 (%)** tra il suo valore più basso e quello più alto;
   - altrimenti **BULL** se MA4 > MA8 > MA12;
   - altrimenti **BEAR** se MA4 < MA8 < MA12;
   - altrimenti **RANGE**.
5. Calcola anche il **range**: la chiusura più alta e quella più bassa nelle ultime
   **RANGE - periodi del range** candele. La sua ampiezza è massimo − minimo.

Ogni coppia usa quindi **le proprie impostazioni per il tipo di mercato rilevato** (blocco
BULL, BEAR o RANGE della coppia). Se l'analisi fallisce (Hyperliquid non raggiungibile), non
viene piazzato nulla e il bot riprova al passaggio successivo.

### 6.2 Ciclo spot, passo per passo

Un ciclo spot è un acquisto seguito da una vendita della stessa quantità.

1. **Quando.** Il bot controlla ogni coppia spot attiva ogni **Pausa breve del ciclo di acquisto (min)**.
   Un acquisto viene tentato quando:
   - la coppia non è in pausa (vedi passo 6);
   - dal tentativo precedente su questa coppia è trascorso almeno il **più piccolo** dei tre
     valori **Intervallo tra acquisti (min)** della coppia (BULL, BEAR, RANGE), qualunque sia il
     mercato attuale. Il primo tentativo dopo l'avvio del bot attende **Ritardo prima del primo
     acquisto (min)**.
2. **Consentito?** Gli acquisti devono essere attivi a livello globale (**Acquisti attivi (globale)**) **e** nel
   blocco della coppia per il mercato attuale (**Acquisti attivi**). In caso contrario, il tentativo conta ma
   non viene piazzato nulla.
3. **Prezzi.** Con *P* = prezzo attuale:
   - prezzo di acquisto = *P* + **Offset di acquisto**; prezzo di vendita obiettivo = *P* + **Offset di vendita**;
   - con l'**Unità dell'offset** `abs`, gli offset sono in USDC; con `pct`, in % di *P*;
   - **in un mercato RANGE**, gli offset sono **dinamici**: acquisto = *P* − *d*, vendita = *P* + *d*,
     con *d* = ampiezza del range × **RANGE - % del range usata** / 100 / 2. Gli offset statici
     RANGE della coppia sono usati solo se il range non può essere calcolato (ampiezza 0).
4. **Quantità.** Importo = **% del saldo USDC** × gli USDC **disponibili** (non già impegnati in
   ordini aperti). Quantità = importo / prezzo di acquisto, arrotondata **per difetto** al passo di quantità della
   coppia. Se il valore dell'ordine è inferiore a **Valore minimo dell'ordine (USDC)** (almeno 10 USDC,
   minimo di Hyperliquid), l'acquisto viene rifiutato e il log mostra "Value too low".
5. **Ordine.** Viene piazzato un ordine di acquisto limit al prezzo di acquisto. Il ciclo appare nella
   Dashboard come **Acquisto in attesa**, con il prezzo di vendita obiettivo già registrato.
6. **Pausa.** Dopo ogni tentativo, piazzato o no, la coppia attende **Pausa dopo un tentativo
   (min)** del blocco del mercato attuale.
7. **Acquisto eseguito.** Il bot lo apprende dallo storico di Hyperliquid, recuperato ogni
   **Intervallo di recupero Hyperliquid (min)**. Il ciclo diventa **Vendita in attesa**. Un acquisto
   parzialmente eseguito e ancora aperto resta **Acquisto in attesa**.
8. **Vendita.** Il ciclo di vendita (ogni **Intervallo del ciclo di vendita (s)**) piazza un ordine di vendita limit al
   **prezzo di vendita obiettivo registrato al passo 3**. Vende la quantità effettivamente ricevuta:
   Hyperliquid preleva la commissione di acquisto nel token acquistato, quindi il bot vende la quantità acquistata
   meno questa commissione, arrotondata per difetto al passo di quantità. Un piccolo residuo può restare nel tuo wallet;
   un ciclo successivo lo vende quando il saldo lo consente.
   - Il prezzo di vendita non viene ricalcolato. Se il mercato è già sopra di esso, la vendita viene
     eseguita immediatamente al prezzo di mercato (meglio del previsto).
   - Se il saldo non è sufficiente, il bot riprova; dopo 3 tentativi il problema viene
     scritto come **errore** nel log.
9. **Vendita eseguita.** Il ciclo diventa **Completato**. Il profitto è calcolato con il prezzo e la quantità
   di vendita reali e le commissioni reali: quantità venduta × (prezzo di vendita − prezzo di acquisto) − commissione
   di acquisto − commissione di vendita.

Gli interruttori **Vendite attive** attualmente non hanno alcun effetto: una volta eseguito un acquisto, la sua vendita viene
sempre piazzata.

**Esempio pratico (RANGE).** Prezzo attuale 85.000; nelle ultime 20 candele la chiusura più alta
è 85.200 e la più bassa 84.770: ampiezza 430. Con **RANGE - % del range usata** =
75: *d* = 430 × 75 / 100 / 2 = 161,25. Acquisto a 85.000 − 161,25 = 84.838,75; vendita obiettivo a
85.000 + 161,25 = 85.161,25. Con **% del saldo USDC** = 5 e 400 USDC disponibili: 20 USDC,
quindi 20 / 84.838,75 = 0,0002357 del token base, arrotondato per difetto al passo di quantità della coppia.

### 6.3 Ciclo perp, passo per passo

Un ciclo perp è un'entrata (long o short), poi un'uscita tramite take-profit, stop-loss o chiusura.

1. **Quando.** Stesse regole dello spot: ogni coppia perp attiva viene controllata ogni **Pausa breve del
   ciclo di acquisto (min)**; pausa dopo ogni tentativo (**Pausa dopo un tentativo (min)** del blocco del mercato
   attuale) e il più piccolo dei tre **Intervallo tra entrate (min)**.
2. **Prima di ogni entrata, a ogni passaggio**, il bot applica la **Direzione** attuale ai cicli
   già aperti sulla coppia:
   - direzione **none**: le entrate non ancora eseguite vengono annullate; le posizioni aperte seguono
     **Direzione impostata su «none» con una posizione aperta** (`keep_tp_sl` = lascia in essere il take-profit
     e lo stop-loss; `close_market` / `close_limit` = chiudi la posizione);
   - direzione **opposta** a un ciclo aperto (ad esempio `short` mentre è aperto un long):
     un'entrata non ancora eseguita viene annullata, una posizione aperta viene chiusa secondo **Chiudi
     in caso di inversione** (`market` = ordine market; `limit` = ordine limit al prezzo attuale).
3. **Quale lato.** `long` o `short`: quel lato. `none`: nessuna entrata. `both`: secondo la
   **Regola della direzione «both»**:
   - `first_filled`: vengono piazzate un'entrata long e un'entrata short; la prima eseguita annulla
     l'altra;
   - `range_position`: long se il prezzo è nella metà inferiore del range, short nella
     metà superiore; al di fuori di un mercato RANGE, nessuna entrata;
   - `alternate`: il lato opposto rispetto al ciclo precedente della coppia.
4. **Filtro del funding.** Nessun long se il funding rate è superiore a +**Soglia di funding (%)**; nessuno
   short se è inferiore a −soglia. Se il funding non è disponibile, nessuna entrata.
5. **Leva e margine.** Se necessario, il bot imposta la **Leva** e la **Modalità
   margine** della coppia su Hyperliquid prima dell'entrata.
6. **Prezzi e dimensione.** Con *P* = prezzo attuale: entrata = *P* + offset di entrata del lato, take-
   profit = *P* + offset di take-profit del lato (USDC o % secondo l'**Unità dell'offset**).
   Margine usato = **% del margine disponibile** × margine disponibile; dimensione = margine × leva
   / prezzo di entrata, arrotondata per difetto.
7. **Entrata.** Ordine limit al prezzo di entrata. Quando è eseguito, il bot piazza un
   **take-profit** (limit, reduce-only) al prezzo registrato e uno **stop-loss** (stop
   market, reduce-only) a **Stop-loss (% del prezzo di entrata)** dal prezzo di entrata reale.
8. **Uscita.** Il ciclo termina quando il take-profit, lo stop-loss o una chiusura viene eseguito. Gli ordini market e
   stop market accettano uno scostamento massimo di **Slippage degli ordini market (%)**.

Segui i cicli perp nella pagina **🟣 Cicli perp**.

### 6.4 Pagina Coppie negoziate

La pagina **🧩 Coppie negoziate** elenca le coppie configurate per il bot.

- **Aggiungi una coppia**: in **🌐 Coppie Hyperliquid**, fai clic su **Aggiungi** sulla riga della coppia. Una nuova coppia è
  **disattivata**; le sue impostazioni spot sono precompilate con i valori predefiniti BULL / BEAR / RANGE della
  pagina **Impostazioni**. Le impostazioni perp devono essere inserite.
- **Modifica**: apre le impostazioni della coppia: una parte generale, poi un blocco per tipo di mercato
  (BULL, BEAR, RANGE). **Salva** verifica ogni valore; i campi errati vengono evidenziati.
- Colonna **Configurazione**: **completo**, oppure il numero di campi **da completare**. Una coppia
  può essere attivata solo quando è completa.
- **Attiva / Disattiva**: vengono negoziate solo le coppie attive e complete. Possono essere attivate solo le coppie
  spot quotate in USDC. Una coppia disattivata non piazza nuove entrate, ma **i suoi cicli aperti continuano
  fino alla loro chiusura**.
- **Elimina**: possibile solo quando la coppia non ha cicli in corso. Disattivala prima e
  attendi la fine dei suoi cicli.
- Le modifiche si applicano al passaggio successivo del ciclo interessato, senza riavvio.

**Offset** — prezzo di acquisto o di entrata = prezzo attuale + offset; prezzo di vendita o di take-profit =
prezzo attuale + offset. Un offset negativo è al di sotto del prezzo attuale.

#### Impostazioni delle coppie spot

Parte generale:

| Campo | Significato |
|---|---|
| Unità dell'offset | `abs` = offset in USDC; `pct` = offset in % del prezzo attuale |
| Intervallo delle candele | candele dell'analisi di mercato di questa coppia; vuoto = **Intervallo delle candele** globale |
| RANGE - % del range usata | offset dinamici in RANGE = ± (ampiezza del range × questa %) / 2 |

Un blocco per BULL, uno per BEAR, uno per RANGE:

| Campo | Significato |
|---|---|
| Acquisti attivi | acquisti consentiti quando viene rilevato questo tipo di mercato |
| Vendite attive | attualmente nessun effetto: le vendite vengono sempre piazzate |
| Offset di acquisto | prezzo di acquisto = prezzo attuale + questo offset (di solito negativo); in RANGE, sostituito dall'offset dinamico |
| Offset di vendita | prezzo di vendita obiettivo = prezzo attuale + questo offset; in RANGE, sostituito dall'offset dinamico |
| % del saldo USDC | quota degli USDC disponibili usata per ogni acquisto |
| Pausa dopo un tentativo (min) | attesa dopo ogni tentativo di acquisto in questo mercato |
| Intervallo tra acquisti (min) | tempo minimo tra due tentativi di acquisto; viene usato il più piccolo dei tre blocchi |

#### Impostazioni delle coppie perp

Parte generale:

| Campo | Significato |
|---|---|
| Unità dell'offset | `abs` = USDC; `pct` = % del prezzo attuale |
| Intervallo delle candele | come per lo spot |
| Leva | limitata alla leva massima dell'asset |
| Modalità margine | `cross` o `isolated` (alcuni asset richiedono `isolated`) |
| Stop-loss (% del prezzo di entrata) | ordine stop market a questa % del prezzo di entrata reale |
| Soglia di funding (%) | nessun long se funding > +soglia; nessuno short se funding < −soglia |
| Slippage degli ordini market (%) | scostamento massimo accettato sugli ordini market e stop market |
| Regola della direzione «both» | `first_filled`, `range_position` o `alternate` (vedi 6.3); obbligatoria non appena un blocco usa `both` |
| Chiudi in caso di inversione | `market` o `limit` |
| Direzione impostata su «none» con una posizione aperta | `keep_tp_sl`, `close_market` o `close_limit` |

Un blocco per BULL, uno per BEAR, uno per RANGE:

| Campo | Significato |
|---|---|
| Direzione | `long`, `short`, `both` o `none` (nessuna entrata) |
| Offset di entrata long / Offset di take-profit long | il take-profit deve essere sopra l'entrata |
| Offset di entrata short / Offset di take-profit short | il take-profit deve essere sotto l'entrata |
| % del margine disponibile | quota del margine disponibile usata per ogni entrata, uguale per long e short |
| Pausa dopo un tentativo (min) | attesa dopo ogni tentativo di entrata in questo mercato |
| Intervallo tra entrate (min) | tempo minimo tra due tentativi di entrata; viene usato il più piccolo dei tre blocchi |

### 6.5 Pagina Impostazioni

**⚙️ Impostazioni** contiene le impostazioni globali. Un valore modificato qui viene salvato e applicato
immediatamente (porta e indirizzo di ascolto: al riavvio successivo). **Valore predefinito** ripristina
il valore originale. L'indirizzo del wallet e la chiave dell'API wallet non si impostano qui (pagina
**🔑 Account Hyperliquid**).

**Modalità operativa**

| Impostazione | Predefinito | Significato |
|---|---|---|
| Modalità simulazione (DRY_RUN) | no | il bot legge Hyperliquid normalmente ma non invia alcun ordine e non registra alcun ciclo |

**Analisi di mercato** — comune a tutte le coppie (vedi 6.1)

| Impostazione | Predefinito | Significato |
|---|---|---|
| Intervallo delle candele | 1h | candele usate quando una coppia non ha un proprio intervallo delle candele |
| Periodo MA4 / Periodo MA8 / Periodo MA12 | 4 / 8 / 12 | numero di candele di ogni media mobile |
| Soglia RANGE MA12 (%) | 0,25 | variazione massima della MA12 per rilevare un mercato RANGE |
| Periodi MA12 verificati | 5 | numero di periodi sui quali viene verificata la MA12 |
| Numero di candele recuperate | 100 | deve coprire il periodo più lungo usato (MA12 + periodi verificati, periodi del range) |

**Attivazione ordini**

| Impostazione | Predefinito | Significato |
|---|---|---|
| Acquisti attivi (globale) | sì | interruttore generale: disattivato = nessun acquisto su nessuna coppia spot |
| Acquisti in BULL / BEAR / RANGE | sì / no / sì | valore predefinito per le nuove coppie spot |
| Vendite attive (globale), Vendite in BULL / BEAR / RANGE | — | attualmente nessun effetto |

**Mercato BULL / BEAR / RANGE — valori predefiniti per le nuove coppie spot**: offset di acquisto e di vendita (USDC),
% del saldo USDC, pausa dopo un tentativo, intervallo tra acquisti. Precompilano una coppia spot
quando viene aggiunta; **modificarli non cambia le coppie già aggiunte**. Il blocco RANGE
contiene anche:

| Impostazione | Predefinito | Significato |
|---|---|---|
| RANGE - periodi del range | 20 | numero di candele usate per il massimo e il minimo del range (tutte le coppie) |
| RANGE - % del range usata | 75 | valore predefinito per le nuove coppie spot |

Valori predefiniti: BULL acquisto 0 / vendita +1000, 3 %, pausa 10 min, intervallo 360 min; BEAR acquisto −1000 /
vendita 0, 3 %, pausa 10 min, intervallo 360 min; RANGE acquisto −400 / vendita +400, 5 %, pausa 10 min,
intervallo 180 min.

**Ordini e commissioni**

| Impostazione | Predefinito | Significato |
|---|---|---|
| Valore minimo dell'ordine (USDC) | 10 | gli ordini più piccoli non vengono piazzati (minimo di Hyperliquid: 10) |
| Commissione maker (%) | 0,04 | usata solo quando mancano le commissioni reali di un'operazione |
| Commissione taker (%) | 0,07 | stima della commissione per gli ordini market e stop market |

**Tempistiche e sincronizzazione**

| Impostazione | Predefinito | Significato |
|---|---|---|
| Intervallo di recupero Hyperliquid (min) | 10 | frequenza con cui vengono recuperati gli ordini aperti, le esecuzioni e lo storico: un'esecuzione viene rilevata al massimo dopo questo tempo |
| Ritardo prima del primo acquisto (min) | 0 | dopo l'avvio del bot; applicato all'avvio successivo |
| Pausa breve del ciclo di acquisto (min) | 1 | attesa tra due controlli dell'intervallo di acquisto, e dopo un errore |
| Intervallo del ciclo di vendita (s) | 120 | attesa tra due passaggi del ciclo di vendita |

**Notifiche Telegram** — vedi sezione 9.

**Interfaccia web**

| Impostazione | Predefinito | Significato |
|---|---|---|
| Lingua | English | lingua dell'interfaccia web e dei messaggi Telegram |
| Tema | Scuro | visualizzazione scura o chiara |
| Indirizzo di ascolto | 0.0.0.0 | 0.0.0.0 = raggiungibile dalla rete locale; 127.0.0.1 = solo questo computer (riavvio) |
| Porta dell'interfaccia web | 60000 | applicata al riavvio |
| Cache dell'elenco coppie (s) | 43200 | l'elenco delle coppie Hyperliquid viene conservato 12 h e aggiornato in background |
| Ritardo tra le richieste al catalogo (ms) | 150 | pausa tra due richieste durante il caricamento dell'elenco delle coppie |
| Durata della sessione (h) | 12 | si applica agli accessi successivi |
| Accessi falliti prima del blocco | 5 | per indirizzo IP |
| Durata del blocco (min) | 15 | |

**File di log**

| Impostazione | Predefinito | Significato |
|---|---|---|
| Registra gli avvisi | no | gli errori vengono sempre registrati; gli avvisi solo se attivati (sezione 12) |

## 7. Licenza e abbonamento

### Prezzi

| Abbonamento | Prezzo |
|---|---|
| 7 giorni | 2 $ |
| 30 giorni | 6 $ |

Il periodo pagato viene aggiunto alla fine della tua licenza attuale (oppure parte dalla data del pagamento
se la licenza è scaduta).

### Come pagare

Nella pagina **Licenza**, riquadro **Abbonamento e pagamento**:

1. scegli l'abbonamento, il token e la rete;
2. il bot mostra l'**importo esatto**, l'**indirizzo di ricezione** e l'indirizzo **da cui devi
   pagare**. L'importo è valido per **1 ora** (meno se il prezzo varia di oltre il
   10 %);
3. invia **esattamente questo importo**, su **questa rete**, **dal wallet del tuo account
   HL-Spot**;
4. il pagamento viene riconosciuto automaticamente (alcuni minuti a seconda della rete) e la
   licenza viene prolungata.

I token e le reti disponibili sono quelli mostrati nella pagina Licenza.

**Regole — leggile prima di pagare:**

- paga **esattamente** l'importo richiesto, né di più né di meno; **le commissioni di rete sono a tuo carico**;
- paga **dal wallet del tuo account** (per BTC: dal tuo indirizzo BTC dichiarato);
- paga sulla rete indicata, finché l'importo è valido;
- un pagamento che non rispetta queste regole (indirizzo sconosciuto, importo diverso, altra
  rete, dopo la scadenza della validità) **è perso: nessun rimborso**.

### Pagare in BTC

Prima del tuo primo pagamento in BTC, dichiara il tuo **indirizzo BTC** nella pagina Licenza (prova tramite una
firma del tuo wallet principale). Il pagamento viene riconosciuto solo se è inviato **da questo indirizzo
BTC**: nel tuo wallet BTC, scegli questo indirizzo come origine del pagamento ("coin
control").

### Verifiche della licenza

- La licenza viene verificata presso il server **ogni 6 ore**.
- Se il server non è raggiungibile, il bot continua fino alla data di scadenza nota della
  licenza.
- **24 ore prima della scadenza**: avviso nelle pagine web e tramite Telegram.
- Dopo la scadenza: **24 ore di tolleranza** (il trading continua, con un avviso), poi il trading
  si arresta.
- Non mandare indietro l'orologio del tuo computer: un orologio spostato indietro di oltre 5 minuti arresta
  il trading fino alla successiva verifica riuscita.

## 8. API wallet: scadenza e sostituzione

- La pagina **Account Hyperliquid** mostra la data di scadenza del tuo API wallet. Se necessario puoi inserirla
  tu stesso.
- Durante gli **ultimi 7 giorni**: banner nelle pagine web e un messaggio Telegram giornaliero.
- Alla data di scadenza, il trading si arresta. Crea un nuovo API wallet (sezione 3) e inserisci la sua chiave nella
  pagina **Account Hyperliquid**: il trading riparte senza riavviare il programma.
- La nuova chiave deve appartenere allo **stesso wallet principale**: l'indirizzo del wallet non può essere modificato.
- All'avvio e ogni 24 ore, il bot verifica presso Hyperliquid che l'API wallet appartenga ancora
  al tuo wallet.

## 9. Notifiche Telegram

In **Impostazioni → Notifiche Telegram**:

1. crea un bot Telegram con **@BotFather** e copia il suo token;
2. ottieni il tuo chat ID (ad esempio con **@userinfobot**);
3. inserisci il token e il chat ID, poi attiva le notifiche e scegli i messaggi
   (ordini piazzati, acquisti eseguiti, cicli completati, errori, riepilogo giornaliero).

## 10. Usare HL-Spot su un altro computer

Installa il bot sul nuovo computer e scegli **Ho già un account** al primo
avvio. La vecchia installazione viene liberata. **Un cambio ogni 30 giorni.** La pagina Licenza
mostra la data del prossimo cambio possibile.

## 11. Password dimenticata

Nella pagina di accesso, fai clic su **Password dimenticata?**. Dimostra di possedere il wallet tramite una
**firma del tuo wallet principale**, poi scegli una nuova password.

## 12. Log

La pagina **📝 Log** mostra gli errori registrati dal bot (e gli avvisi se
**Impostazioni → File di log → Registra gli avvisi** è attivato). Il file è limitato a 1 MB: le
voci più vecchie vengono rimosse. Puoi filtrare, scaricare il file (utile per il supporto) e
svuotarlo.

## 13. Eliminare il tuo account

Pagina **Licenza**, **🗑️ Elimina il mio account**: password + firma del tuo wallet principale.

- Il tuo account HL-Spot viene eliminato **definitivamente**.
- Il tempo di licenza rimanente è **perso e non rimborsato**.
- La prova gratuita **non** viene concessa di nuovo per questo wallet.
- Su questo computer, l'indirizzo del wallet, la chiave dell'API wallet e la password vengono cancellati; lo
  storico del trading viene conservato.

## 14. Aggiornamenti e backup

- **Aggiornamento**: installa la nuova versione (decomprimila, oppure carica la nuova immagine Docker); i tuoi dati
  vengono conservati (sezione 4).
- **Backup**: copia la cartella dei dati (sezione 4). Il file `.env` e il file `secret.key` vanno
  **insieme**: i valori cifrati di `.env` e del database non possono essere letti senza
  `secret.key`. Se `secret.key` va perso, questi valori (chiave dell'API wallet, token Telegram…) devono
  essere inseriti di nuovo.

## 15. Accesso da un'altra macchina

Per impostazione predefinita, la pagina web è in ascolto su tutte le interfacce di rete, porta **60000** (**Impostazioni → Interfaccia
web**, applicata al riavvio). Da un'altra macchina della tua rete: `http://<bot
machine address>:60000`.

In rete, la pagina **non è cifrata**: inserisci la chiave dell'API wallet e la password
preferibilmente dalla macchina del bot. Non esporre mai la porta 60000 direttamente su Internet.

## 16. Eseguire HL-Spot su Flux

[Flux](https://runonflux.com) è un cloud decentralizzato: noleggia container su server (nodi)
gestiti da terzi. HL-Spot può girarvi giorno e notte senza il tuo computer. Flux è
indipendente da HL-Spot e si paga a Flux.

### La chiave del tuo API wallet su Flux: da leggere prima

Su Flux, i dati del bot (`/data`: la chiave cifrata dell'API wallet **e** il file `secret.key`
che la decifra) si trovano su server gestiti da altre persone, copiati su 3 nodi. Scegli il
tipo di applicazione al momento del deployment:

- **Applicazione «enterprise»** (nodi ArcaneOS), consigliata: Flux dichiara che gli operatori
  dei nodi non possono accedere ai dati dell'applicazione (disco cifrato, accesso root
  limitato) e che le variabili d'ambiente restano private.
- **Applicazione ordinaria**: un operatore di nodo può leggere `/data`, quindi la chiave del
  tuo API wallet; le variabili d'ambiente, compreso il codice di primo avvio, sono leggibili da
  chiunque. Un API wallet non può prelevare i tuoi fondi, ma chi ne possiede la chiave può fare
  trading sul tuo conto. A tuo rischio.

Qualunque sia il tipo, puoi revocare l'API wallet su Hyperliquid in qualsiasi momento
(sezione 3).

### Impostazioni dell'applicazione

| Campo Flux | Valore |
|---|---|
| Immagine | `olivier1246/hl-spot:1.0.2` |
| Porta e porta del container | `60000` |
| Dati del container | `g:/data` (**obbligatorio**) |
| CPU | 0,2 |
| RAM | 300 MB (aumentala se l'applicazione si riavvia per mancanza di memoria) |
| SSD | 3 GB |
| Istanze | 3 (minimo di Flux) |
| Ambiente | `HL_SPOT_SETUP_CODE=<il tuo codice>` (**obbligatorio**), `TZ=Europe/Paris` (facoltativo) |

- `g:/data`: **una sola** istanza esegue il bot; le altre 2 conservano una copia sincronizzata
  dei dati e subentrano se si ferma. Non usare mai un altro valore: il bot girerebbe su 3
  macchine contemporaneamente e invierebbe ogni ordine 3 volte.
- `HL_SPOT_SETUP_CODE`: un codice di almeno 12 caratteri, diverso dalla tua password. Senza di
  esso, chiunque trovi l'indirizzo dell'applicazione potrebbe creare l'account prima di te.

### Primo avvio su Flux

1. Apri l'indirizzo **https** che Flux fornisce per l'applicazione.
2. Segui la sezione 5 e inserisci il tuo codice nel riquadro **Codice di primo avvio**.
3. Usa un browser con l'estensione del tuo wallet: il bot firma il messaggio con essa.

### Da sapere

- L'installazione segue i dati: quando il bot cambia nodo, non conta come un cambio di
  installazione (sezione 10).
- Dopo un cambio di nodo, il bot riparte dalla copia sincronizzata: controlla i tuoi ordini
  aperti su Hyperliquid.
- **Aggiornamento**: sostituisci l'immagine con la nuova versione nelle impostazioni
  dell'applicazione su Flux.
- La pagina è raggiungibile da Internet: è protetta dalla tua password. Sceglila robusta.

## 17. Supporto

- E-mail: HL-spot@cmails.eu

Quando contatti il supporto, allega il file di log (pagina **📝 Log** → Scarica il file). Non
inviare mai la chiave del tuo API wallet, il tuo file `secret.key` o la tua password.
