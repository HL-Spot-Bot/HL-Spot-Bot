# HL-Spot — Benutzerhandbuch

Version 1.0.7

HL-Spot ist ein Trading-Bot für **Hyperliquid**: spot- und Perpetual-Märkte (perp), mehrere Paare,
automatische und manuelle Orders. Er läuft **auf Ihrem eigenen Computer** (Windows, Linux oder Docker), und Sie
steuern ihn über Ihren Webbrowser.

> **Website**: https://hlspot.com
> **Download**: https://github.com/HL-Spot-Bot/HL-Spot-Bot
> **Support**: HL-spot@cmails.eu

---

## 1. Bevor Sie beginnen

Sie benötigen:

- einen Computer mit einem 64-Bit-x86-Prozessor (x86_64) unter **Windows** oder **Linux** oder einen beliebigen
  Rechner mit **Docker**;
- oder ein **Flux**-Konto, um ihn in der Cloud zu betreiben (Abschnitt 16);
- oder ein **gemieteter Server (VPS)** mit Linux oder Windows, erreichbar über HTTPS (Abschnitt 17);
- ein **Hyperliquid**-Konto mit Guthaben (Ihre Haupt-Wallet);
- eine Wallet, die mit der Adresse Ihrer Haupt-Wallet **„eine Nachricht signieren“** kann. Eine Browsererweiterung
  (MetaMask, Rabby…) ist am einfachsten: Der Bot öffnet sie für Sie. Jede andere Wallet funktioniert per
  Kopieren und Einfügen;
- eine Internetverbindung.

## 2. Sicherheit: Was Sie wissen müssen

- HL-Spot akzeptiert ausschließlich einen **API wallet**-Schlüssel von Hyperliquid. **Geben Sie niemals den privaten Schlüssel
  Ihrer Haupt-Wallet ein.** Ein API wallet kann für Sie handeln, aber Ihr Guthaben nicht abheben.
- Der Schlüssel des API wallet wird auf Ihrem Computer **verschlüsselt**. Er wird **niemals** an den Lizenzserver
  **gesendet**.
- Ihre Haupt-Wallet dient nur zum **Signieren von Nachrichten** (Kontoerstellung, vergessenes Passwort,
  BTC-Adresse, Kontolöschung). Eine signierte Nachricht ist keine Transaktion: Sie kostet nichts
  und bewegt kein Guthaben.
- Die Webseite des Bots ist durch Ihr Passwort geschützt. Nutzen Sie sie vorzugsweise auf dem Rechner des Bots
  (`http://localhost:60000`): Von einem anderen Rechner in Ihrem Netzwerk aus ist die Seite nicht
  verschlüsselt (siehe Abschnitt 15).

## 3. Ihr Hyperliquid API wallet erstellen

1. Öffnen Sie **https://app.hyperliquid.xyz/API** und verbinden Sie Ihre Haupt-Wallet.
2. Geben Sie dem API wallet einen Namen und generieren Sie es anschließend.
3. **Kopieren Sie den angezeigten privaten Schlüssel** und bewahren Sie ihn an einem sicheren Ort auf: Hyperliquid zeigt ihn nur einmal an.
4. Autorisieren Sie das API wallet (Signatur mit Ihrer Haupt-Wallet).
5. Notieren Sie das von Hyperliquid angezeigte **Ablaufdatum** des API wallet.

In HL-Spot geben Sie ein: die **Adresse Ihrer Haupt-Wallet** (0x…) und den **privaten Schlüssel des API
wallet**.

## 4. HL-Spot installieren

Laden Sie die Datei für Ihr System und die zugehörige `.sha256`-Datei herunter von
https://github.com/HL-Spot-Bot/HL-Spot-Bot. Mit der `.sha256`-Datei können Sie prüfen, ob der Download
unbeschädigt ist.

### Windows

1. Entpacken Sie `HL-Spot-1.0.7-prod-windows-x64.zip`.
2. Starten Sie im entpackten Ordner **`HL-Spot.exe`**. Ein Konsolenfenster öffnet sich: Lassen Sie es geöffnet, solange
   der Bot läuft.
3. Öffnen Sie **http://localhost:60000** in Ihrem Browser.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 oder neuer)

```
unzip HL-Spot-1.0.7-prod-linux-x64.zip
cd HL-Spot-1.0.7-prod-linux-x64
./hl-spot
```

Öffnen Sie anschließend **http://localhost:60000** in Ihrem Browser.

### Docker

```
docker load -i HL-Spot-1.0.7-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.7
```

- `-p 60000:60000` ist erforderlich, um die Webseite zu erreichen.
- `TZ` legt die Zeitzone fest (UTC, falls weggelassen).
- Ihre Daten bleiben im Volume `hl-spot-data` erhalten, auch wenn der Container entfernt oder das Image
  aktualisiert wird.
- `docker stop hl-spot` beendet den Bot sauber.

Öffnen Sie anschließend **http://localhost:60000** (oder `http://<machine address>:60000`).

### Wo Ihre Daten gespeichert werden

Ihre Daten (Einstellungen, verschlüsselter Schlüssel, Datenbank, Log) werden **außerhalb des Programms** gespeichert:

| System | Ordner |
|---|---|
| Windows | `%LOCALAPPDATA%\HL-Spot` |
| Linux | `~/.local/share/hl-spot` |
| Docker | das Volume `/data` |

Eine Neuinstallation oder ein Update des Programms verändert sie nie.

## 5. Erster Start

Die erste Seite ist **Erster Start**. Wählen Sie:

- **Konto erstellen**, wenn Sie neu sind;
- **Ich habe bereits ein Konto**, wenn Sie bereits ein HL-Spot-Konto haben (neuer Computer,
  Neuinstallation).

### Konto erstellen

1. **Wallet-Adresse**: die Adresse Ihrer Haupt-Wallet (0x…).
2. **Privater Schlüssel des API wallet**: der in Abschnitt 3 kopierte Schlüssel. Er wird vor allem anderen
   bei Hyperliquid überprüft.
3. **Passwort**: mindestens 8 Zeichen, mit einem Großbuchstaben, einem Kleinbuchstaben, einer
   Ziffer und einem Sonderzeichen. Es schützt sowohl Ihr HL-Spot-Konto als auch die Webseite
   des Bots.
4. **Signatur der Haupt-Wallet**:
   - **Mit meinem Wallet signieren**: Der Bot öffnet Ihre Wallet-Erweiterung; prüfen Sie die Adresse und
     bestätigen Sie die Signatur;
   - oder **Zu signierende Nachricht abrufen**: Kopieren Sie die Nachricht unverändert in Ihre Wallet, signieren Sie sie und
     fügen Sie die Signatur (0x…) ein. Die Nachricht ist 15 Minuten lang gültig.
5. Klicken Sie auf **Konto erstellen**.

Ihr **kostenloser Testzeitraum von 7 Tagen** beginnt. Er wird pro Wallet und pro
Installation nur einmal gewährt. Der Handel beginnt, sobald Ihr Hyperliquid-Konto verifiziert ist.

### Ich habe bereits ein Konto

Geben Sie Ihre Wallet-Adresse und Ihr Passwort ein. Diese Installation wird registriert und die
vorherige freigegeben (**ein Installationswechsel pro 30 Tage**).

## 6. Den Bot verwenden

Das Menü oben bietet Zugriff auf:

| Seite | Verwendung |
|---|---|
| 📊 Dashboard | Ihr Hyperliquid-Portfolio (Guthaben, PNL), der Live-Preis des Paares im aktiven Tab und ein Tab pro spot-Paar: seine Zyklen und sein Marktstatus; Schaltfläche **Abbrechen** bei laufenden Zyklen |
| 📈 Statistiken | Ergebnisse der spot- und perp-Zyklen nach Zeitraum |
| 🧩 Gehandelte Paare | Für den Bot konfigurierte spot- und perp-Paare und ihre Einstellungen |
| 🟣 Perp-Zyklen | Einstiege, Take-Profits, Stop-Losses und Schließungen der perp-Paare; Schaltflächen **Abbrechen** und **Schließen** |
| 🖐️ Manuelle Orders | Platzieren Sie eine Order manuell; der Bot verfolgt den Zyklus dann wie die anderen |
| 🌐 Hyperliquid-Paare | Liste der spot- und perp-Paare von Hyperliquid; fügen Sie hier ein Paar zum Bot hinzu |
| ⚙️ Einstellungen | globale Einstellungen (ohne Neustart übernommen, außer Port und Listen-Adresse) |
| 📝 Log | Fehler (und Warnungen, falls aktiviert) |
| 🔑 Hyperliquid-Konto | Wallet, Schlüssel des API wallet, Ablaufdatum |
| 📜 Lizenz | Lizenz, Abonnement, Zahlung, Installation, Kontolöschung |

Der Bot handelt nur, wenn **Ihr Hyperliquid-Konto verifiziert** und **Ihre Lizenz
gültig** ist. Ohne gültige Lizenz sind nur die Seiten Hyperliquid-Konto und Lizenz
verfügbar.

Wenn der Bot den Handel einstellt (Lizenz abgelaufen, API wallet abgelaufen oder abgelehnt), **lässt er bereits offene
Orders und Positionen unberührt**: Sie liegen in Ihrer Verantwortung.

Die folgenden Unterabschnitte erklären, wie der Bot entscheidet, und anschließend jedes Feld der Seiten **Gehandelte
Paare** und **Einstellungen**.

### 6.1 Marktanalyse: BULL, BEAR oder RANGE

Vor jedem Kauf (spot) oder Einstieg (perp) analysiert der Bot **das Paar selbst**, anhand der Kerzen
dieses Paares:

1. Er ruft die letzten **Anzahl abgerufener Kerzen** Kerzen (Einstellung `LIMIT`) im
   **Kerzenintervall** des Paares ab (leer = die globale Einstellung **Kerzenintervall**).
2. Der **aktuelle Preis** ist der Schlusskurs der jüngsten Kerze.
3. Er berechnet drei gleitende Durchschnitte der Schlusskurse: **MA4**, **MA8** und **MA12** (ihre
   Kerzenanzahl wird unter **Einstellungen → Marktanalyse** festgelegt).
4. Er bestimmt den Markttyp in dieser Reihenfolge:
   - **RANGE**, wenn der MA12 flach ist: Über die letzten **Geprüfte MA12-Perioden** hat sich der MA12
     zwischen seinem niedrigsten und höchsten Wert um höchstens **MA12 RANGE-Schwelle (%)** bewegt;
   - andernfalls **BULL**, wenn MA4 > MA8 > MA12;
   - andernfalls **BEAR**, wenn MA4 < MA8 < MA12;
   - andernfalls **RANGE**.
5. Er berechnet außerdem die **Range**: den höchsten und den niedrigsten Schlusskurs über die letzten
   **RANGE - Range-Perioden** Kerzen. Ihre Spanne ist Hoch − Tief.

Jedes Paar verwendet dann **seine eigenen Einstellungen für den erkannten Markttyp** (Block BULL, BEAR oder
RANGE des Paares). Schlägt die Analyse fehl (Hyperliquid nicht erreichbar), wird nichts platziert
und der Bot versucht es beim nächsten Durchlauf erneut.

### 6.2 Spot-Zyklus Schritt für Schritt

Ein spot-Zyklus besteht aus einem Kauf, gefolgt von einem Verkauf derselben Menge.

1. **Wann.** Der Bot prüft jedes aktivierte spot-Paar alle **Kurze Pause der Kaufschleife (min)**.
   Ein Kauf wird versucht, wenn:
   - das Paar sich nicht in einer Pause befindet (siehe Schritt 6);
   - seit dem vorherigen Versuch für dieses Paar mindestens der **kleinste** der drei Werte
     **Intervall zwischen Käufen (min)** des Paares (BULL, BEAR, RANGE) vergangen ist, unabhängig vom
     aktuellen Markt. Der erste Versuch nach dem Start des Bots wartet **Verzögerung vor dem ersten
     Kauf (min)** ab.
2. **Erlaubt?** Käufe müssen global (**Käufe aktiviert (global)**) **und** im
   Block des aktuellen Marktes des Paares (**Käufe aktiviert**) aktiviert sein. Andernfalls zählt der Versuch, aber
   es wird nichts platziert.
3. **Preise.** Mit *P* = aktueller Preis:
   - Kaufpreis = *P* + **Kauf-Offset**; Ziel-Verkaufspreis = *P* + **Verkaufs-Offset**;
   - mit der **Offset-Einheit** `abs` sind die Offsets in USDC angegeben; mit `pct` in % von *P*;
   - **in einem RANGE-Markt** sind die Offsets **dynamisch**: Kauf = *P* − *d*, Verkauf = *P* + *d*,
     mit *d* = Range-Spanne × **RANGE - % der genutzten Range** / 100 / 2. Die statischen
     RANGE-Offsets des Paares werden nur verwendet, wenn die Range nicht berechnet werden kann (Spanne 0).
4. **Betrag.** Gemäß **Betrag jedes Kaufs** im Block des aktuellen Markts:
   - **% des Guthabens**: Betrag = dieser % × das **verfügbare** USDC (nicht bereits durch
     offene Orders gebunden);
   - **Feste USDC**: Betrag = dieser Wert, mindestens 10 USDC + Hyperliquid-Kaufgebühren
     (10,01 USDC mit den Basisgebühren). Ist das verfügbare USDC geringer, **wird kein Kauf
     platziert** und ein Fehler wird im Log erfasst;
   - Menge = Betrag / Kaufpreis, **abgerundet** auf die Größenschrittweite des Paares (bei
     festen USDC ein Schritt mehr, wenn die Rundung den Wert unter das Minimum bringt);
   - liegt der Orderwert unter **Mindestwert einer Order (USDC)** (mindestens 10 USDC,
     Hyperliquid-Minimum), wird der Kauf abgelehnt und das Log zeigt „Value too low“.
5. **Order.** Eine Limit-Kauforder wird zum Kaufpreis platziert. Der Zyklus erscheint im
   Dashboard als **Kauf ausstehend**, mit dem bereits gespeicherten Ziel-Verkaufspreis.
6. **Pause.** Nach jedem Versuch, ob platziert oder nicht, wartet das Paar **Pause nach einem Versuch
   (min)** des Blocks des aktuellen Marktes.
7. **Kauf ausgeführt.** Der Bot erfährt dies aus der Hyperliquid-Historie, die alle
   **Hyperliquid-Abrufintervall (min)** abgerufen wird. Der Zyklus wechselt zu **Verkauf ausstehend**. Ein teilweise
   ausgeführter Kauf, der noch offen ist, bleibt **Kauf ausstehend**.
8. **Verkauf.** Die Verkaufsschleife (alle **Intervall der Verkaufsschleife (s)**) platziert eine Limit-Verkaufsorder zum
   **in Schritt 3 gespeicherten Ziel-Verkaufspreis**. Sie verkauft die tatsächlich erhaltene Menge:
   Hyperliquid zieht die Kaufgebühr im gekauften Token ab, daher verkauft der Bot die gekaufte Menge
   abzüglich dieser Gebühr, abgerundet auf die Größenschrittweite. Ein kleiner Rest kann in Ihrer Wallet verbleiben;
   ein späterer Zyklus verkauft ihn, sobald das Guthaben es erlaubt.
   - Der Verkaufspreis wird nicht neu berechnet. Liegt der Markt bereits darüber, wird der Verkauf
     sofort zum Marktpreis ausgeführt (besser als geplant).
   - Reicht das Guthaben nicht aus, versucht es der Bot erneut; nach 3 Versuchen wird das Problem
     als **Fehler** in das Log geschrieben.
9. **Verkauf ausgeführt.** Der Zyklus wechselt zu **Abgeschlossen**. Der Gewinn wird mit dem tatsächlichen
   Verkaufspreis, der tatsächlichen Menge und den tatsächlichen Gebühren berechnet: verkaufte Menge × (Verkaufspreis − Kaufpreis) −
   Kaufgebühr − Verkaufsgebühr.

Die Schalter **Verkäufe aktiviert** haben derzeit keine Wirkung: Sobald ein Kauf ausgeführt ist, wird sein Verkauf
immer platziert.

**Durchgerechnetes Beispiel (RANGE).** Aktueller Preis 85.000; über die letzten 20 Kerzen liegt der höchste
Schlusskurs bei 85.200 und der niedrigste bei 84.770: Spanne 430. Mit **RANGE - % der genutzten Range** =
75: *d* = 430 × 75 / 100 / 2 = 161,25. Kauf bei 85.000 − 161,25 = 84.838,75; Ziel-Verkauf bei
85.000 + 161,25 = 85.161,25. Mit **% des USDC-Guthabens** = 5 und 400 verfügbaren USDC: 20 USDC,
also 20 / 84.838,75 = 0,0002357 des Basis-Tokens, abgerundet auf die Größenschrittweite des Paares.

### 6.3 Perp-Zyklus Schritt für Schritt

Ein perp-Zyklus besteht aus einem Einstieg (long oder short) und anschließend einem Ausstieg per Take-Profit, Stop-Loss oder Schließung.

1. **Wann.** Gleiche Regeln wie bei spot: Jedes aktivierte perp-Paar wird alle **Kurze Pause der
   Kaufschleife (min)** geprüft; Pause nach jedem Versuch (**Pause nach einem Versuch (min)** des Blocks des aktuellen
   Marktes) und der kleinste der drei Werte **Intervall zwischen Einstiegen (min)**.
2. **Vor jedem Einstieg, bei jedem Durchlauf**, wendet der Bot die aktuelle **Richtung** auf die bereits
   offenen Zyklen des Paares an:
   - Richtung **none**: Noch nicht ausgeführte Einstiege werden storniert; offene Positionen folgen
     **Richtung auf „none“ gesetzt bei offener Position** (`keep_tp_sl` = Take-Profit
     und Stop-Loss bestehen lassen; `close_market` / `close_limit` = Position schließen);
   - Richtung **entgegengesetzt** zu einem offenen Zyklus (zum Beispiel `short`, während ein Long offen ist):
     Ein noch nicht ausgeführter Einstieg wird storniert, eine offene Position wird gemäß **Bei einer Umkehr
     schließen** geschlossen (`market` = Market-Order; `limit` = Limit-Order zum aktuellen Preis).
3. **Welche Seite.** `long` oder `short`: diese Seite. `none`: kein Einstieg. `both`: gemäß
   **Regel der Richtung „both“**:
   - `first_filled`: Ein Long-Einstieg und ein Short-Einstieg werden platziert; der zuerst ausgeführte storniert den
     anderen;
   - `range_position`: Long, wenn der Preis in der unteren Hälfte der Range liegt, Short in der
     oberen Hälfte; außerhalb eines RANGE-Marktes kein Einstieg;
   - `alternate`: die Gegenseite des vorherigen Zyklus des Paares.
4. **Funding-Filter.** Kein Long, wenn die Funding-Rate über +**Funding-Schwelle (%)** liegt; kein
   Short, wenn sie unter −Schwelle liegt. Ist das Funding nicht verfügbar, erfolgt kein Einstieg.
5. **Hebel und Margin.** Falls nötig, setzt der Bot vor dem Einstieg den **Hebel** und den **Margin-Modus**
   des Paares auf Hyperliquid.
6. **Preise und Größe.** Mit *P* = aktueller Preis: Einstieg = *P* + Einstiegs-Offset der Seite,
   Take-Profit = *P* + Take-Profit-Offset der Seite (USDC oder % gemäß **Offset-Einheit**).
   Margin gemäß **Margin jedes Einstiegs**: **% der Margin** × verfügbare Margin oder **Feste USDC**
   (Margin × Hebel von mindestens 10 USDC + Gebühren; ist die verfügbare Margin geringer, wird
   kein Einstieg platziert und ein Fehler im Log erfasst). Größe = Margin × Hebel /
   Einstiegspreis, abgerundet.
7. **Einstieg.** Limit-Order zum Einstiegspreis. Sobald sie ausgeführt ist, platziert der Bot einen
   **Take-Profit** (Limit, reduce-only) zum gespeicherten Preis und einen **Stop-Loss** (Stop-Market,
   reduce-only) bei **Stop-Loss (% des Einstiegspreises)** vom tatsächlichen Einstiegspreis.
8. **Ausstieg.** Der Zyklus endet, wenn der Take-Profit, der Stop-Loss oder eine Schließung ausgeführt wird. Market- und
   Stop-Market-Orders akzeptieren eine Abweichung von höchstens **Slippage von Market-Orders (%)**.

Verfolgen Sie die perp-Zyklen auf der Seite **🟣 Perp-Zyklen**.

### 6.4 Seite Gehandelte Paare

Die Seite **🧩 Gehandelte Paare** listet die für den Bot konfigurierten Paare auf.

- **Paar hinzufügen**: Klicken Sie auf **🌐 Hyperliquid-Paare** in der Zeile des Paares auf **Hinzufügen**. Ein neues Paar ist
  **deaktiviert**; seine spot-Einstellungen sind mit den BULL- / BEAR- / RANGE-Standardwerten der Seite
  **Einstellungen** vorausgefüllt. Die perp-Einstellungen müssen eingegeben werden.
- **Bearbeiten**: öffnet die Einstellungen des Paares: einen allgemeinen Teil, dann einen Block pro Markttyp
  (BULL, BEAR, RANGE). **Speichern** prüft jeden Wert; fehlerhafte Felder werden hervorgehoben.
- Spalte **Konfiguration**: **vollständig** oder die Anzahl der Felder **zu vervollständigen**. Ein Paar
  kann erst aktiviert werden, wenn es vollständig ist.
- **Aktivieren / Deaktivieren**: Nur aktivierte und vollständige Paare werden gehandelt. Nur in USDC notierte
  spot-Paare können aktiviert werden. Ein deaktiviertes Paar platziert keinen neuen Einstieg, aber **seine offenen Zyklen laufen weiter,
  bis sie geschlossen sind**.
- **Löschen**: nur möglich, wenn das Paar keinen laufenden Zyklus hat. Deaktivieren Sie es zuerst und
  warten Sie, bis seine Zyklen beendet sind.
- Änderungen werden beim nächsten Durchlauf der betreffenden Schleife ohne Neustart übernommen.

**Offsets** — Kauf- oder Einstiegspreis = aktueller Preis + Offset; Verkaufs- oder Take-Profit-Preis =
aktueller Preis + Offset. Ein negativer Offset liegt unter dem aktuellen Preis.

#### Einstellungen eines spot-Paares

Allgemeiner Teil:

| Feld | Bedeutung |
|---|---|
| Offset-Einheit | `abs` = Offsets in USDC; `pct` = Offsets in % des aktuellen Preises |
| Kerzenintervall | Kerzen der Marktanalyse dieses Paares; leer = globales **Kerzenintervall** |
| RANGE - % der genutzten Range | dynamische Offsets in RANGE = ± (Range-Spanne × dieser %) / 2 |

Ein Block für BULL, einer für BEAR, einer für RANGE:

| Feld | Bedeutung |
|---|---|
| Käufe aktiviert | Käufe erlaubt, wenn dieser Markttyp erkannt wird |
| Verkäufe aktiviert | derzeit ohne Wirkung: Verkäufe werden immer platziert |
| Kauf-Offset | Kaufpreis = aktueller Preis + dieser Offset (normalerweise negativ); in RANGE durch den dynamischen Offset ersetzt |
| Verkaufs-Offset | Ziel-Verkaufspreis = aktueller Preis + dieser Offset; in RANGE durch den dynamischen Offset ersetzt |
| Betrag jedes Kaufs | **% des Guthabens**: Anteil des verfügbaren USDC, der für jeden Kauf verwendet wird; **Feste USDC**: gleicher Betrag bei jedem Kauf, mindestens 10 USDC + Hyperliquid-Kaufgebühren |
| Pause nach einem Versuch (min) | Wartezeit nach jedem Kaufversuch in diesem Markt |
| Intervall zwischen Käufen (min) | Mindestzeit zwischen zwei Kaufversuchen; der kleinste Wert der drei Blöcke wird verwendet |

#### Einstellungen eines perp-Paares

Allgemeiner Teil:

| Feld | Bedeutung |
|---|---|
| Offset-Einheit | `abs` = USDC; `pct` = % des aktuellen Preises |
| Kerzenintervall | wie bei spot |
| Hebel | begrenzt auf den maximalen Hebel des Assets |
| Margin-Modus | `cross` oder `isolated` (einige Assets erfordern `isolated`) |
| Stop-Loss (% des Einstiegspreises) | Stop-Market-Order bei diesem % des tatsächlichen Einstiegspreises |
| Funding-Schwelle (%) | kein Long, wenn Funding > +Schwelle; kein Short, wenn Funding < −Schwelle |
| Slippage von Market-Orders (%) | maximal akzeptierte Abweichung bei Market- und Stop-Market-Orders |
| Regel der Richtung „both“ | `first_filled`, `range_position` oder `alternate` (siehe 6.3); erforderlich, sobald ein Block `both` verwendet |
| Bei einer Umkehr schließen | `market` oder `limit` |
| Richtung auf „none“ gesetzt bei offener Position | `keep_tp_sl`, `close_market` oder `close_limit` |

Ein Block für BULL, einer für BEAR, einer für RANGE:

| Feld | Bedeutung |
|---|---|
| Richtung | `long`, `short`, `both` oder `none` (kein Einstieg) |
| Long-Einstiegs-Offset / Long-Take-Profit-Offset | der Take-Profit muss über dem Einstieg liegen |
| Short-Einstiegs-Offset / Short-Take-Profit-Offset | der Take-Profit muss unter dem Einstieg liegen |
| Margin jedes Einstiegs | **% der Margin** (verfügbar) oder **Feste USDC** (Margin × Hebel von mindestens 10 USDC + Gebühren); gleich für Long und Short |
| Pause nach einem Versuch (min) | Wartezeit nach jedem Einstiegsversuch in diesem Markt |
| Intervall zwischen Einstiegen (min) | Mindestzeit zwischen zwei Einstiegsversuchen; der kleinste Wert der drei Blöcke wird verwendet |

### 6.5 Seite Einstellungen

**⚙️ Einstellungen** enthält die globalen Einstellungen. Ein hier geänderter Wert wird gespeichert und sofort
übernommen (Port und Listen-Adresse: beim nächsten Neustart). **Standardwert** stellt den ursprünglichen
Wert wieder her. Die Wallet-Adresse und der Schlüssel des API wallet werden nicht hier festgelegt (Seite
**🔑 Hyperliquid-Konto**).

**Betriebsmodus**

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Simulationsmodus (DRY_RUN) | nein | der Bot liest Hyperliquid normal, sendet aber keine Order und speichert keinen Zyklus |

**Marktanalyse** — gemeinsam für alle Paare (siehe 6.1)

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Kerzenintervall | 1h | Kerzen, die verwendet werden, wenn ein Paar kein eigenes Kerzenintervall hat |
| MA4-Periode / MA8-Periode / MA12-Periode | 4 / 8 / 12 | Anzahl der Kerzen jedes gleitenden Durchschnitts |
| MA12 RANGE-Schwelle (%) | 0,25 | maximale Veränderung des MA12, um einen RANGE-Markt zu erkennen |
| Geprüfte MA12-Perioden | 5 | Anzahl der Perioden, über die der MA12 geprüft wird |
| Anzahl abgerufener Kerzen | 100 | muss die größte verwendete Periode abdecken (MA12 + geprüfte Perioden, Range-Perioden) |

**Order-Aktivierung**

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Käufe aktiviert (global) | ja | Hauptschalter: aus = kein Kauf auf irgendeinem spot-Paar |
| Käufe in BULL / BEAR / RANGE | ja / nein / ja | Standardwert für neue spot-Paare |
| Verkäufe aktiviert (global), Verkäufe in BULL / BEAR / RANGE | — | derzeit ohne Wirkung |

**BULL- / BEAR- / RANGE-Markt — Standardwerte für neue spot-Paare**: Kauf- und Verkaufs-Offsets (USDC),
% des USDC-Guthabens, Kaufbetrag (% des USDC-Guthabens oder Festbetrag; Standard: %), Festbetrag (Standard 15 USDC), Pause nach einem Versuch, Intervall zwischen Käufen. Sie füllen ein spot-Paar vor,
wenn es hinzugefügt wird; **ihre Änderung wirkt sich nicht auf bereits hinzugefügte Paare aus**. Der RANGE-Block
enthält außerdem:

| Einstellung | Standard | Bedeutung |
|---|---|---|
| RANGE - Range-Perioden | 20 | Anzahl der Kerzen für Hoch und Tief der Range (alle Paare) |
| RANGE - % der genutzten Range | 75 | Standardwert für neue spot-Paare |

Standardwerte: BULL Kauf 0 / Verkauf +1000, 3 %, Pause 10 min, Intervall 360 min; BEAR Kauf −1000 /
Verkauf 0, 3 %, Pause 10 min, Intervall 360 min; RANGE Kauf −400 / Verkauf +400, 5 %, Pause 10 min,
Intervall 180 min.

**Orders**

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Mindestwert einer Order (USDC) | 10 | kleinere Orders werden nicht platziert (Hyperliquid-Minimum: 10) |

**Hyperliquid-Gebühren** (nur Anzeige): Ihre Gebühren werden beim Start des Bots und danach stündlich bei Hyperliquid gelesen, getrennt für **spot** und **perp** (Maker = Limit-Order, Taker = Market-Order). Sie berücksichtigen Ihre Volumenstufe, Ihre gestakten HYPE und Ihren Empfehlungsrabatt. Sie dienen nur zur Schätzung der Gebühren eines Trades, dessen tatsächliche Gebühren noch nicht bekannt sind: Gewinne verwenden immer die tatsächlichen Gebühren jeder Ausführung. Die Schaltfläche **Aktualisieren** liest sie sofort neu. Solange sie nicht gelesen werden konnten, verwendet der Bot die Hyperliquid-Basissätze (spot: Maker 0,040 %, Taker 0,070 %; perp: Maker 0,015 %, Taker 0,045 %).

**Timing und Synchronisierung**

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Hyperliquid-Abrufintervall (min) | 10 | wie oft offene Orders, Ausführungen und Historie abgerufen werden: Eine Ausführung wird höchstens so lange nach ihrem Eintreten erkannt |
| Verzögerung vor dem ersten Kauf (min) | 0 | nach dem Start des Bots; wird beim nächsten Start übernommen |
| Kurze Pause der Kaufschleife (min) | 1 | Wartezeit zwischen zwei Prüfungen des Kaufintervalls und nach einem Fehler |
| Intervall der Verkaufsschleife (s) | 120 | Wartezeit zwischen zwei Durchläufen der Verkaufsschleife |

**Telegram-Benachrichtigungen** — siehe Abschnitt 9.

**Web-Oberfläche**

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Sprache | English | Sprache der Web-Oberfläche und der Telegram-Nachrichten |
| Design | Dunkel | dunkle oder helle Darstellung |
| Listen-Adresse | 0.0.0.0 | 0.0.0.0 = aus dem lokalen Netzwerk erreichbar; 127.0.0.1 = nur dieser Computer (Neustart) |
| Port der Web-Oberfläche | 60000 | wird beim Neustart übernommen |
| Cache der Paarliste (s) | 43200 | die Paarliste von Hyperliquid wird 12 h lang gespeichert und im Hintergrund aktualisiert |
| Verzögerung zwischen Katalog-Anfragen (ms) | 150 | Pause zwischen zwei Anfragen beim Laden der Paarliste |
| Sitzungsdauer (h) | 12 | gilt für die nächsten Anmeldungen |
| Fehlgeschlagene Anmeldungen vor Sperre | 5 | pro IP-Adresse |
| Sperrdauer (min) | 15 | |

**Logdatei**

| Einstellung | Standard | Bedeutung |
|---|---|---|
| Warnungen aufzeichnen | nein | Fehler werden immer aufgezeichnet; Warnungen nur, wenn aktiviert (Abschnitt 12) |

### 6.6 Dashboard: Portfolio, Preis, Stornieren eines Zyklus

Rahmen **Hyperliquid-Portfolio**:

- **Gesamtwert** des Kontos in USDC.
- **PNL** über 24 h, 7 Tage, 30 Tage und insgesamt, auf zwei Arten:
  **Hyperliquid (gesamtes Konto)**, von Hyperliquid berechnet, einschließlich der außerhalb des
  Bots ausgeführten Operationen; **Bot (abgeschlossene Zyklen)**, der Nettogewinn der vom Bot
  abgeschlossenen Zyklen.
- Eine Zeile pro Asset: **Gesamt**, **Verfügbar**, **In Orders** (durch offene Orders gebunden),
  **Preis** und **Wert (USDC)**. Die Zeile **Perp-Konto** zeigt die Margin des perp-Kontos. Ist
  Ihr Hyperliquid-Konto im Unified-Modus, wird die perp-Margin aus dem USDC-Guthaben entnommen:
  Dann wird nur der unrealisierte PnL der Positionen zur Summe addiert.

Rahmen **Preis**: Live-Preis des Paares im aktiven Tab (alle 5 Sekunden aktualisiert) und seine
Änderung über 24 h.

Schaltfläche **Abbrechen** (Dashboard, laufende spot-Zyklen), nach Bestätigung:

- **Kauf ausstehend**: Die Kauforder wird auf Hyperliquid storniert. Wurde bereits ein Teil
  gekauft, bleibt dieser Teil auf Ihrem Konto.
- **Verkauf ausstehend**: Die Verkaufsorder wird storniert; die Kryptowährung bleibt auf Ihrem
  Konto.

Der Zyklus erhält den Status **Storniert** (Filter **Storniert**) und wird nicht mehr vom Bot
verwaltet. Beim nächsten Durchlauf kann der Bot einen neuen Kauf platzieren, wenn der Markt es
zulässt: Um ein Paar zu stoppen, deaktivieren Sie es (Seite **Gehandelte Paare**).

Seite **Perp-Zyklen**, nach Bestätigung:

- **Abbrechen** (ausstehender Einstieg): Die Einstiegsorder wird storniert. Wurde bereits ein
  Teil ausgeführt, wird dieser Teil zum Marktpreis geschlossen; schlägt diese Schließung fehl,
  behält er seinen Take-Profit und Stop-Loss.
- **Schließen** (offene Position): Die Position wird zum Marktpreis geschlossen. Take-Profit und
  Stop-Loss werden erst storniert, sobald die Schließungsorder platziert ist: Schlägt die
  Schließungsorder fehl, behält die Position ihren Schutz.
- Keine Schaltfläche, während eine Schließung läuft.

Ein Zyklus wird erst als storniert markiert, wenn Hyperliquid bestätigt, dass die Order nicht
mehr aktiv ist. Wurde die Order gerade ausgeführt, wird die Stornierung abgelehnt und der Zyklus
läuft normal weiter. Diese Aktionen können nicht rückgängig gemacht werden.

## 7. Lizenz und Abonnement

### Preise

| Abonnement | Preis |
|---|---|
| 7 Tage | 2 $ |
| 30 Tage | 6 $ |

Der bezahlte Zeitraum wird an das Ende Ihrer aktuellen Lizenz angehängt (oder beginnt am Zahlungsdatum,
wenn die Lizenz abgelaufen ist).

### So bezahlen Sie

Auf der Seite **Lizenz**, Bereich **Abonnement und Zahlung**:

1. Wählen Sie das Abonnement, den Token und das Netzwerk;
2. der Bot zeigt den **genauen Betrag**, die **Empfangsadresse** und die Adresse an, **von der aus** Sie
   **zahlen müssen**. Der Betrag ist **1 Stunde** lang gültig (kürzer, wenn sich der Kurs um mehr als
   10 % bewegt);
3. senden Sie **genau diesen Betrag**, über **dieses Netzwerk**, **von der Wallet Ihres
   HL-Spot-Kontos**;
4. die Zahlung wird automatisch erkannt (je nach Netzwerk einige Minuten) und die
   Lizenz wird verlängert.

Die angebotenen Token und Netzwerke sind die auf der Seite Lizenz angezeigten.

**Regeln — lesen Sie sie vor dem Bezahlen:**

- zahlen Sie **genau** den geforderten Betrag, weder mehr noch weniger; **die Netzwerkgebühren tragen Sie**;
- zahlen Sie **von der Wallet Ihres Kontos** (bei BTC: von Ihrer angegebenen BTC-Adresse);
- zahlen Sie über das angezeigte Netzwerk, solange der Betrag gültig ist;
- eine Zahlung, die diese Regeln nicht einhält (unbekannte Adresse, abweichender Betrag, anderes
  Netzwerk, nach Ablauf der Gültigkeit), **geht verloren: keine Rückerstattung**.

### Zahlung in BTC

Geben Sie vor Ihrer ersten BTC-Zahlung Ihre **BTC-Adresse** auf der Seite Lizenz an (Nachweis durch eine
Signatur Ihrer Haupt-Wallet). Die Zahlung wird nur erkannt, wenn sie **von dieser BTC-Adresse** gesendet wird:
Wählen Sie in Ihrer BTC-Wallet diese Adresse als Quelle der Zahlung („Coin
Control“).

### Lizenzprüfungen

- Die Lizenz wird **alle 6 Stunden** beim Server geprüft.
- Ist der Server nicht erreichbar, läuft der Bot bis zum bekannten Enddatum der
  Lizenz weiter.
- **24 Stunden vor dem Ende**: Warnung auf den Webseiten und per Telegram.
- Nach dem Ende: **24 Stunden Kulanzzeit** (der Handel läuft mit einer Warnung weiter), danach wird der Handel
  eingestellt.
- Stellen Sie die Uhr Ihres Computers nicht zurück: Eine um mehr als 5 Minuten zurückgestellte Uhr stoppt
  den Handel bis zur nächsten erfolgreichen Prüfung.

## 8. API wallet: Ablauf und Ersetzung

- Die Seite **Hyperliquid-Konto** zeigt das Ablaufdatum Ihres API wallet an. Sie können es bei Bedarf
  selbst eingeben.
- Während der **letzten 7 Tage**: Banner auf den Webseiten und eine tägliche Telegram-Nachricht.
- Am Ablaufdatum wird der Handel eingestellt. Erstellen Sie ein neues API wallet (Abschnitt 3) und geben Sie seinen Schlüssel auf
  der Seite **Hyperliquid-Konto** ein: Der Handel startet wieder, ohne dass das Programm neu gestartet werden muss.
- Der neue Schlüssel muss zur **selben Haupt-Wallet** gehören: Die Wallet-Adresse kann nicht geändert werden.
- Der Bot prüft beim Start und alle 24 Stunden bei Hyperliquid, ob das API wallet noch
  zu Ihrer Wallet gehört.

## 9. Telegram-Benachrichtigungen

Unter **Einstellungen → Telegram-Benachrichtigungen**:

1. Erstellen Sie mit **@BotFather** einen Telegram-Bot und kopieren Sie dessen Token;
2. ermitteln Sie Ihre Chat-ID (zum Beispiel mit **@userinfobot**);
3. geben Sie den Token und die Chat-ID ein, aktivieren Sie dann die Benachrichtigungen und wählen Sie die Nachrichten
   (platzierte Orders, ausgeführte Käufe, abgeschlossene Zyklen, Fehler, tägliche Zusammenfassung).

## 10. HL-Spot auf einem anderen Computer verwenden

Installieren Sie den Bot auf dem neuen Computer und wählen Sie beim ersten Start **Ich habe bereits ein Konto**.
Die alte Installation wird freigegeben. **Ein Wechsel pro 30 Tage.** Die Seite Lizenz
zeigt das Datum des nächstmöglichen Wechsels an.

## 11. Vergessenes Passwort

Klicken Sie auf der Anmeldeseite auf **Passwort vergessen?**. Weisen Sie durch eine
**Signatur Ihrer Haupt-Wallet** nach, dass Sie Inhaber der Wallet sind, und wählen Sie dann ein neues Passwort.

## 12. Log

Die Seite **📝 Log** zeigt die vom Bot aufgezeichneten Fehler an (und die Warnungen, wenn
**Einstellungen → Logdatei → Warnungen aufzeichnen** aktiviert ist). Die Datei ist auf 1 MB begrenzt: Die
ältesten Einträge werden entfernt. Sie können filtern, die Datei herunterladen (nützlich für den Support) und sie
leeren.

## 13. Ihr Konto löschen

Seite **Lizenz**, **🗑️ Mein Konto löschen**: Passwort + Signatur Ihrer Haupt-Wallet.

- Ihr HL-Spot-Konto wird **endgültig** gelöscht.
- Die verbleibende Lizenzzeit **verfällt und wird nicht erstattet**.
- Der kostenlose Testzeitraum wird für diese Wallet **nicht** erneut gewährt.
- Auf diesem Computer werden die Wallet-Adresse, der Schlüssel des API wallet und das Passwort gelöscht; die
  Handelshistorie bleibt erhalten.

## 14. Updates und Sicherung

Wenn eine neue Version veröffentlicht wird, zeigt der Bot oben auf allen Seiten ein Banner an
(Prüfung beim Start, danach alle 6 Stunden):

- **blaues Banner**: Eine neue Version ist verfügbar. Die Schaltfläche **Diese Version ignorieren**
  blendet es bis zur nächsten Version aus;
- **rotes Banner**: **wichtiges** Update (zum Beispiel eine Sicherheitskorrektur), so bald wie
  möglich zu installieren; es kann nicht ignoriert werden.

Sind die Telegram-Benachrichtigungen aktiviert (Abschnitt 9), wird pro neuer Version nur eine
Nachricht gesendet. Der Bot lädt und installiert niemals selbst etwas: Der Link im Banner öffnet
die Seite der Version auf GitHub.

- **Update**: Installieren Sie die neue Version (entpacken Sie sie oder laden Sie das neue Docker-Image); Ihre Daten
  bleiben erhalten (Abschnitt 4). Auf Flux: Abschnitt 16; auf einem VPS: Abschnitt 17.
- **Sicherung**: Kopieren Sie den Datenordner (Abschnitt 4). Die Datei `.env` und die Datei `secret.key` gehören
  **zusammen**: Die verschlüsselten Werte in `.env` und in der Datenbank können ohne
  `secret.key` nicht gelesen werden. Geht `secret.key` verloren, müssen diese Werte (Schlüssel des API wallet, Telegram-Token…)
  erneut eingegeben werden.

## 15. Zugriff von einem anderen Rechner

Standardmäßig lauscht die Webseite auf allen Netzwerkschnittstellen, Port **60000** (**Einstellungen → Web-Oberfläche**,
wird beim Neustart übernommen). Von einem anderen Rechner in Ihrem Netzwerk: `http://<bot
machine address>:60000`.

Im Netzwerk ist die Seite **nicht verschlüsselt**: Geben Sie den Schlüssel Ihres API wallet und Ihr Passwort
vorzugsweise auf dem Rechner des Bots ein. Machen Sie Port 60000 niemals direkt aus dem Internet erreichbar.

Um den Bot aus dem Internet zu erreichen (VPS), folgen Sie Abschnitt 17: Der Zugriff über HTTPS ist Pflicht.

## 16. HL-Spot auf Flux betreiben

[Flux](https://runonflux.com) ist eine dezentrale Cloud: Sie vermietet Container auf Servern
(Nodes), die von Dritten betrieben werden. HL-Spot kann dort Tag und Nacht ohne Ihren Computer
laufen. Flux ist unabhängig von HL-Spot und wird an Flux bezahlt.

### Ihr API-Wallet-Schlüssel auf Flux: zuerst lesen

Auf Flux liegen die Daten des Bots (`/data`: der verschlüsselte API-Wallet-Schlüssel **und**
die Datei `secret.key`, die ihn entschlüsselt) auf Servern anderer Personen, als Kopie auf
3 Nodes. Den Anwendungstyp wählen Sie bei der Bereitstellung:

- **Enterprise-Anwendung** (ArcaneOS-Nodes) — empfohlen: Laut Flux können die Betreiber der
  Nodes nicht auf die Daten der Anwendung zugreifen (verschlüsselte Festplatte, eingeschränkter
  Root-Zugriff), und die Umgebungsvariablen bleiben privat.
- **Normale Anwendung**: Ein Node-Betreiber kann `/data` und damit Ihren API-Wallet-Schlüssel
  lesen; die Umgebungsvariablen, einschließlich des Codes für den ersten Start, kann jeder
  lesen. Ein API-Wallet kann Ihr Guthaben nicht abheben, aber wer seinen Schlüssel besitzt,
  kann auf Ihrem Konto handeln. Auf eigenes Risiko.

Unabhängig vom Typ können Sie das API-Wallet jederzeit auf Hyperliquid widerrufen
(Abschnitt 3).

### Einstellungen der Anwendung

| Flux-Feld | Wert |
|---|---|
| Image | `olivier1246/hl-spot:1.0.7` |
| Port und Container-Port | `60000` |
| Container-Daten | `g:/data` (**erforderlich**) |
| CPU | 0,2 |
| RAM | 300 MB (erhöhen, wenn die Anwendung wegen Speichermangels neu startet) |
| SSD | 3 GB |
| Instanzen | 3 (Minimum von Flux) |
| Umgebung | `HL_SPOT_SETUP_CODE=<Ihr Code>` (**erforderlich**), `TZ=Europe/Paris` (optional) |

- `g:/data`: Nur **eine** Instanz führt den Bot aus; die 2 anderen halten eine synchronisierte
  Kopie der Daten und übernehmen, wenn sie ausfällt. Verwenden Sie nie einen anderen Wert: Der
  Bot liefe auf 3 Maschinen gleichzeitig und würde jede Order 3-mal platzieren.
- `HL_SPOT_SETUP_CODE`: ein Code mit mindestens 12 Zeichen, verschieden von Ihrem Passwort.
  Ohne ihn könnte jeder, der die Adresse der Anwendung findet, das Konto vor Ihnen erstellen.

### Erster Start auf Flux

1. Öffnen Sie die **https**-Adresse, die Flux für die Anwendung angibt.
2. Folgen Sie Abschnitt 5 und geben Sie Ihren Code im Feld **Code für den ersten Start** ein.
3. Verwenden Sie einen Browser mit Ihrer Wallet-Erweiterung: Der Bot signiert die Nachricht
   damit.

### Gut zu wissen

- Die Installation folgt den Daten: Wechselt der Bot auf einen anderen Node, zählt das nicht
  als Installationswechsel (Abschnitt 10).
- Nach einem Wechsel startet der Bot mit der synchronisierten Kopie neu: Prüfen Sie Ihre
  offenen Orders auf Hyperliquid.
- **Update**: Ersetzen Sie das Image in den Einstellungen der Anwendung auf Flux durch die neue
  Version.
- Die Seite ist aus dem Internet erreichbar: Sie ist durch Ihr Passwort geschützt. Wählen Sie
  ein sicheres.

## 17. HL-Spot auf einem VPS installieren (HTTPS-Zugriff)

Auf einem gemieteten Server (VPS) wird die Seite des Bots über das Internet aufgerufen. Sie muss
über **HTTPS** laufen: Ohne Verschlüsselung werden Ihr Passwort und der Schlüssel Ihres API wallet
im Klartext übertragen, und Internet-Roboter tasten ständig offene Ports ab. Der Bot zeigt ein
Warnbanner an und protokolliert einen Fehler im Log, wenn er eine HTTP-Anfrage aus dem Internet
erhält.

Funktionsweise: Ein HTTPS-Proxy, **Caddy**, auf demselben Rechner installiert, nimmt die
Verbindungen auf Port 443 entgegen und leitet sie an den Bot weiter. Caddy bezieht und erneuert
selbstständig ein **Let's Encrypt**-Zertifikat:

- für die **öffentliche IP-Adresse** des VPS (Standard): kurzlebiges Zertifikat (etwa 6 Tage),
  das automatisch erneuert wird;
- oder für Ihren **Domainnamen** (z. B. `bot.example.com`), dessen DNS-Eintrag auf die
  IP-Adresse des VPS zeigen muss.

Zu öffnende Ports: **80** (Zertifikat) und **443** (HTTPS), zusätzlich zu Ihrem
Administrationszugang (SSH, Remotedesktop). **Port 60000 des Bots darf niemals geöffnet sein.**
Wenn Ihr Hoster eine eigene Firewall hat, öffnen Sie 80 und 443 auch dort.

Die benötigten Dateien befinden sich im Ordner `vps/` des Repositorys
https://github.com/HL-Spot-Bot/HL-Spot-Bot.

### Linux (Ubuntu 22.04 oder neuer, Debian 12 oder neuer)

```
curl -fLO https://raw.githubusercontent.com/HL-Spot-Bot/HL-Spot-Bot/main/vps/install-linux.sh
sudo sh install-linux.sh <öffentliche IP-Adresse oder Domainname>
```

Das Skript installiert Caddy, lädt HL-Spot herunter und prüft dessen SHA-256-Prüfsumme, erstellt
den Dienst `hl-spot` (automatischer Start, Daten in `/var/lib/hl-spot`) und richtet HTTPS sowie
die Firewall `ufw` ein (SSH, 80, 443). Am Ende zeigt es den **Code für den ersten Start** an,
der in `/etc/hl-spot/hl-spot.env` gespeichert ist.

Der Bot läuft als systemd-Dienst `hl-spot`: Er startet mit dem Rechner und wird, falls er
anhält, nach 10 Sekunden automatisch neu gestartet. Befehle für den Dienst:

```
sudo systemctl status hl-spot      # Status
journalctl -u hl-spot -f           # Log live
sudo systemctl restart hl-spot     # neu starten
sudo systemctl stop hl-spot        # anhalten (bis zum nächsten Start des Rechners)
sudo systemctl start hl-spot       # starten
```

- **Update**: Laden Sie das neue Skript herunter und führen Sie es erneut mit der Version als
  zweitem Parameter aus (z. B. `sudo sh install-linux.sh <Adresse> 1.0.8`). Ihre Daten bleiben
  erhalten.

### Docker

Laden Sie die Dateien in einen Ordner herunter:

```
for f in docker-compose.yml Caddyfile.ip Caddyfile.domain; do
  curl -fLO https://raw.githubusercontent.com/HL-Spot-Bot/HL-Spot-Bot/main/vps/$f
done
```

Erstellen Sie in diesem Ordner eine Datei `.env`:

```
HL_SPOT_SITE=<öffentliche IP-Adresse oder Domainname>
HL_SPOT_CADDYFILE=Caddyfile.ip
HL_SPOT_SETUP_CODE=<Ihr Code, mindestens 12 Zeichen>
TZ=Europe/Paris
```

(`HL_SPOT_CADDYFILE=Caddyfile.domain` für einen Domainnamen) und führen Sie dann `docker compose up -d` aus.

- Nur Caddy veröffentlicht Ports (80 und 443). Veröffentlichen Sie niemals Port 60000 des Bots:
  Docker umgeht die Firewall `ufw` für die Ports, die es veröffentlicht.
- Mit Docker bleibt die Listen-Adresse des Bots **0.0.0.0** (Caddy erreicht ihn über das interne
  Docker-Netzwerk).

### Windows Server

PowerShell-Befehle, als Administrator ausgeführt.

**1.** Installieren Sie HL-Spot (Abschnitt 4) in einem festen Ordner, zum Beispiel `C:\HL-Spot`
(`HL-Spot.exe` direkt in diesem Ordner).

**2.** Code für den ersten Start (mindestens 12 Zeichen):

```
[Environment]::SetEnvironmentVariable('HL_SPOT_SETUP_CODE', '<Ihr Code>', 'Machine')
```

**3.** Automatischer Start des Bots unter Ihrem Windows-Konto (auch ohne angemeldete Sitzung):

```
$a = New-ScheduledTaskAction -Execute 'C:\HL-Spot\HL-Spot.exe' -WorkingDirectory 'C:\HL-Spot'
$t = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName 'HL-Spot' -Action $a -Trigger $t -User $env:USERNAME -Password '<Windows-Passwort>'
Start-ScheduledTask -TaskName 'HL-Spot'
```

**4.** Caddy: Laden Sie `caddy_<version>_windows_amd64.zip` von
https://github.com/caddyserver/caddy/releases herunter und legen Sie `caddy.exe` in `C:\Caddy` ab.
Kopieren Sie `Caddyfile.ip` (oder `Caddyfile.domain`) aus dem Ordner `vps/` nach `C:\Caddy\Caddyfile`, dann:

```
(Get-Content C:\Caddy\Caddyfile) -replace '\{\$HL_SPOT_SITE\}', '<IP-Adresse oder Domain>' | Set-Content C:\Caddy\Caddyfile
sc.exe create caddy start= auto binPath= "C:\Caddy\caddy.exe run --config C:\Caddy\Caddyfile --adapter caddyfile"
sc.exe start caddy
```

**5.** Windows-Firewall:

```
New-NetFirewallRule -DisplayName 'HL-Spot HTTPS (Caddy)' -Direction Inbound -Protocol TCP -LocalPort 80,443 -Action Allow
```

### Nach der Installation

1. Öffnen Sie `https://<IP-Adresse oder Domain>` (erstes Zertifikat: einige Sekunden bis einige
   Minuten) und folgen Sie Abschnitt 5, wobei Sie den **Code für den ersten Start** eingeben.
2. Linux und Windows: **Einstellungen → Web-Oberfläche → Listen-Adresse** = `127.0.0.1`, dann
   den Bot neu starten (`sudo systemctl restart hl-spot` oder die Aufgabe `HL-Spot` unter
   Windows). Der Bot akzeptiert dann nur noch Verbindungen, die von Caddy kommen.
3. Optional: Wenn Ihre IP-Adresse fest ist, erlauben Sie im Caddyfile nur diese (Zeilen
   `remote_ip`, deren Kommentarzeichen zu entfernen ist).

Schutzmaßnahmen des Bots: 5 falsche Passwörter von derselben Adresse sperren diese für
15 Minuten; ab 10 falschen Passwörtern in 15 Minuten, über alle Adressen zusammen, werden die
Versuche verlangsamt (Wartezeit von bis zu 60 Sekunden). Eine Passwortänderung beendet alle
anderen offenen Sitzungen. Wählen Sie ein sicheres Passwort.

## 18. Support

- E-mail: HL-spot@cmails.eu

Wenn Sie den Support kontaktieren, hängen Sie die Logdatei an (Seite **📝 Log** → Datei herunterladen). Senden Sie niemals
den Schlüssel Ihres API wallet, Ihre Datei `secret.key` oder Ihr Passwort.
