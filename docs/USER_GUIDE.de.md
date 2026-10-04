# HL-Spot — Benutzerhandbuch

Version 1.0.1

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

1. Entpacken Sie `HL-Spot-1.0.1-prod-windows-x64.zip`.
2. Starten Sie im entpackten Ordner **`HL-Spot.exe`**. Ein Konsolenfenster öffnet sich: Lassen Sie es geöffnet, solange
   der Bot läuft.
3. Öffnen Sie **http://localhost:60000** in Ihrem Browser.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 oder neuer)

```
unzip HL-Spot-1.0.1-prod-linux-x64.zip
cd HL-Spot-1.0.1-prod-linux-x64
./hl-spot
```

Öffnen Sie anschließend **http://localhost:60000** in Ihrem Browser.

### Docker

```
docker load -i HL-Spot-1.0.1-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.1
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
| 📊 Dashboard | Guthaben, Marktstatus, Zustand jedes Paares |
| 📈 Statistiken | Ergebnisse der spot- und perp-Zyklen nach Zeitraum |
| 🧩 Gehandelte Paare | Für den Bot konfigurierte spot- und perp-Paare |
| 🟣 Perp-Zyklen | Einstiege, Take-Profits, Stop-Losses und Schließungen der perp-Paare |
| 🖐️ Manuelle Orders | Platzieren Sie eine Order manuell; der Bot verfolgt den Zyklus dann wie die anderen |
| 🌐 Hyperliquid-Paare | Liste der spot- und perp-Paare von Hyperliquid |
| ⚙️ Einstellungen | alle Einstellungen (ohne Neustart übernommen, außer Port und Listen-Adresse) |
| 📝 Log | Fehler (und Warnungen, falls aktiviert) |
| 🔑 Hyperliquid-Konto | Wallet, Schlüssel des API wallet, Ablaufdatum |
| 📜 Lizenz | Lizenz, Abonnement, Zahlung, Installation, Kontolöschung |

Der Bot handelt nur, wenn **Ihr Hyperliquid-Konto verifiziert** und **Ihre Lizenz
gültig** ist. Ohne gültige Lizenz sind nur die Seiten Hyperliquid-Konto und Lizenz
verfügbar.

Wenn der Bot den Handel einstellt (Lizenz abgelaufen, API wallet abgelaufen oder abgelehnt), **lässt er bereits offene
Orders und Positionen unberührt**: Sie liegen in Ihrer Verantwortung.

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

- **Update**: Installieren Sie die neue Version (entpacken Sie sie oder laden Sie das neue Docker-Image); Ihre Daten
  bleiben erhalten (Abschnitt 4).
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
| Image | `olivier1246/hl-spot:1.0.1` |
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

## 17. Support

- E-mail: HL-spot@cmails.eu

Wenn Sie den Support kontaktieren, hängen Sie die Logdatei an (Seite **📝 Log** → Datei herunterladen). Senden Sie niemals
den Schlüssel Ihres API wallet, Ihre Datei `secret.key` oder Ihr Passwort.
