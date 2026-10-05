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
| 📊 Dashboard | Saldi, stato del mercato, stato di ogni coppia |
| 📈 Statistiche | Risultati dei cicli spot e perp, per periodo |
| 🧩 Coppie negoziate | Coppie spot e perp configurate per il bot |
| 🟣 Cicli perp | Entrate, take-profit, stop-loss e chiusure delle coppie perp |
| 🖐️ Ordini manuali | Piazza un ordine manualmente; il bot segue poi il ciclo come gli altri |
| 🌐 Coppie Hyperliquid | Elenco delle coppie spot e perp di Hyperliquid |
| ⚙️ Impostazioni | Tutte le impostazioni (applicate senza riavvio, tranne porta e indirizzo di ascolto) |
| 📝 Log | Errori (e avvisi se attivati) |
| 🔑 Account Hyperliquid | Wallet, chiave dell'API wallet, data di scadenza |
| 📜 Licenza | Licenza, abbonamento, pagamento, installazione, eliminazione dell'account |

Il bot fa trading solo se **il tuo account Hyperliquid è verificato** e **la tua licenza è
valida**. Senza una licenza valida, sono disponibili solo le pagine Account Hyperliquid e Licenza.

Quando il bot smette di fare trading (licenza scaduta, API wallet scaduto o rifiutato), **non
tocca gli ordini e le posizioni già aperti**: restano sotto la tua responsabilità.

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
