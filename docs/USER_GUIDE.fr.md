# HL-Spot — Guide d'utilisation

Version 1.0.2

HL-Spot est un bot de trading pour **Hyperliquid** : marchés spot et perpétuels (perp),
plusieurs paires, ordres automatiques et manuels. Il tourne **sur votre propre ordinateur**
(Windows, Linux ou Docker) et se pilote depuis votre navigateur web.

> **Site web** : https://hlspot.com
> **Téléchargement** : https://github.com/HL-Spot-Bot/HL-Spot-Bot
> **Support** : HL-spot@cmails.eu

---

## 1. Avant de commencer

Il vous faut :

- un ordinateur à processeur x86 64 bits (x86_64) sous **Windows** ou **Linux**, ou toute
  machine avec **Docker** ;
- ou un compte **Flux**, pour le faire tourner dans le cloud (section 16) ;
- un compte **Hyperliquid** approvisionné (votre wallet principal) ;
- un wallet capable de **« signer un message »** avec l'adresse de votre wallet principal.
  Une extension de navigateur (MetaMask, Rabby…) est le plus simple : le bot l'ouvre pour
  vous. Tout autre wallet fonctionne par copier-coller ;
- une connexion Internet.

## 2. Sécurité : ce que vous devez savoir

- HL-Spot n'accepte que la clé d'un **API wallet** Hyperliquid. **Ne saisissez jamais la clé
  privée de votre wallet principal.** Un API wallet peut trader pour vous mais ne peut pas
  retirer vos fonds.
- La clé de l'API wallet est **chiffrée** sur votre ordinateur. Elle n'est **jamais envoyée**
  au serveur de licences.
- Votre wallet principal sert uniquement à **signer des messages** (création du compte, mot
  de passe oublié, adresse BTC, suppression du compte). Un message signé n'est pas une
  transaction : il ne coûte rien et ne déplace aucun fonds.
- La page web du bot est protégée par votre mot de passe. Utilisez-la de préférence depuis
  la machine du bot (`http://localhost:60000`) : depuis une autre machine de votre réseau,
  la page n'est pas chiffrée (voir section 15).

## 3. Créer votre API wallet Hyperliquid

1. Allez sur **https://app.hyperliquid.xyz/API** et connectez votre wallet principal.
2. Donnez un nom à l'API wallet, puis générez-le.
3. **Copiez la clé privée** affichée et gardez-la en lieu sûr : Hyperliquid ne l'affiche
   qu'une fois.
4. Autorisez l'API wallet (signature avec votre wallet principal).
5. Notez la **date d'expiration** de l'API wallet indiquée par Hyperliquid.

Vous saisirez dans HL-Spot : l'**adresse de votre wallet principal** (0x…) et la **clé privée
de l'API wallet**.

## 4. Installer HL-Spot

Téléchargez le fichier de votre système et son fichier `.sha256` depuis
https://github.com/HL-Spot-Bot/HL-Spot-Bot. Le fichier `.sha256` permet de vérifier que le
téléchargement est intact.

### Windows

1. Décompressez `HL-Spot-1.0.2-prod-windows-x64.zip`.
2. Dans le dossier décompressé, lancez **`HL-Spot.exe`**. Une fenêtre de console s'ouvre :
   laissez-la ouverte tant que le bot tourne.
3. Ouvrez **http://localhost:60000** dans votre navigateur.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 ou plus récent)

```
unzip HL-Spot-1.0.2-prod-linux-x64.zip
cd HL-Spot-1.0.2-prod-linux-x64
./hl-spot
```

Puis ouvrez **http://localhost:60000** dans votre navigateur.

### Docker

```
docker load -i HL-Spot-1.0.2-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.2
```

- `-p 60000:60000` est obligatoire pour accéder à la page web.
- `TZ` règle le fuseau horaire (UTC s'il est omis).
- Vos données restent dans le volume `hl-spot-data`, même si le conteneur est supprimé ou
  l'image mise à jour.
- `docker stop hl-spot` arrête le bot proprement.

Puis ouvrez **http://localhost:60000** (ou `http://<adresse de la machine>:60000`).

### Où sont gardées vos données

Vos données (réglages, clé chiffrée, base de données, log) sont gardées **en dehors du
programme** :

| Système | Dossier |
|---|---|
| Windows | `%LOCALAPPDATA%\HL-Spot` |
| Linux | `~/.local/share/hl-spot` |
| Docker | le volume `/data` |

Réinstaller ou mettre à jour le programme n'y touche jamais.

## 5. Premier lancement

La première page est **Premier lancement**. Choisissez :

- **Créer un compte** si vous êtes nouveau ;
- **J'ai déjà un compte** si vous avez déjà un compte HL-Spot (nouvel ordinateur,
  réinstallation).

### Créer un compte

1. **Adresse du wallet** : l'adresse de votre wallet principal (0x…).
2. **Clé privée de l'API wallet** : la clé copiée à la section 3. Elle est vérifiée auprès
   d'Hyperliquid avant toute autre chose.
3. **Mot de passe** : au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et
   un caractère spécial. Il protège à la fois votre compte HL-Spot et la page web du bot.
4. **Signature du wallet principal** :
   - **Signer avec mon wallet** : le bot ouvre l'extension de votre wallet ; vérifiez
     l'adresse et confirmez la signature ;
   - ou **Obtenir le message à signer** : copiez le message tel quel dans votre wallet,
     signez-le et collez la signature (0x…). Le message est valable 15 minutes.
5. Cliquez sur **Créer le compte**.

Votre **essai gratuit de 7 jours** démarre. Il n'est accordé qu'une fois par wallet et par
installation. Le trading démarre dès que votre compte Hyperliquid est vérifié.

### J'ai déjà un compte

Saisissez l'adresse de votre wallet et votre mot de passe. Cette installation est
enregistrée et la précédente est libérée (**un changement d'installation par 30 jours**).

## 6. Utiliser le bot

Le menu du haut donne accès à :

| Page | Usage |
|---|---|
| 📊 Tableau de bord | soldes, état du marché, état de chaque cycle spot |
| 📈 Statistiques | résultats des cycles spot et perp, par période |
| 🧩 Paires tradées | paires spot et perp configurées pour le bot, et leurs réglages |
| 🟣 Cycles perp | entrées, take-profits, stop-loss et clôtures des paires perp |
| 🖐️ Ordres manuels | placez un ordre à la main ; le bot suit ensuite le cycle comme les autres |
| 🌐 Paires Hyperliquid | liste des paires spot et perp d'Hyperliquid ; ajoutez une paire au bot depuis cette page |
| ⚙️ Paramètres | réglages globaux (appliqués sans redémarrer, sauf le port et l'adresse d'écoute) |
| 📝 Log | erreurs (et avertissements si activés) |
| 🔑 Compte Hyperliquid | wallet, clé de l'API wallet, date d'expiration |
| 📜 Licence | licence, abonnement, paiement, installation, suppression du compte |

Le bot ne trade que si **votre compte Hyperliquid est vérifié** et **votre licence est
valable**. Sans licence valable, seules les pages Compte Hyperliquid et Licence sont
accessibles.

Quand le bot arrête de trader (licence terminée, API wallet expiré ou refusé), il **ne touche
pas aux ordres et positions déjà ouverts** : ils restent sous votre responsabilité.

Les sous-sections suivantes expliquent comment le bot décide, puis chaque champ des pages
**Paires tradées** et **Paramètres**.

### 6.1 Analyse du marché : BULL, BEAR ou RANGE

Avant chaque achat (spot) ou entrée (perp), le bot analyse **la paire elle-même**, sur les
bougies de cette paire :

1. Il récupère les **Nombre de bougies récupérées** dernières bougies (réglage `LIMIT`) de
   l'**Intervalle des bougies** de la paire (vide = le réglage global **Intervalle des bougies**).
2. Le **prix actuel** est la clôture de la bougie la plus récente.
3. Il calcule trois moyennes mobiles des clôtures : **MA4**, **MA8** et **MA12** (leur
   nombre de bougies se règle dans **Paramètres → Analyse du marché**).
4. Il détermine le type de marché, dans cet ordre :
   - **RANGE** si la MA12 est plate : sur les dernières **Périodes MA12 vérifiées**, la MA12 a
     varié d'au plus **Seuil RANGE MA12 (%)** entre sa valeur la plus basse et la plus haute ;
   - sinon **BULL** si MA4 > MA8 > MA12 ;
   - sinon **BEAR** si MA4 < MA8 < MA12 ;
   - sinon **RANGE**.
5. Il calcule aussi le **range** : la clôture la plus haute et la plus basse sur les
   **RANGE - périodes du range** dernières bougies. Son amplitude est haut − bas.

Chaque paire utilise ensuite **ses propres réglages pour le type de marché détecté** (bloc
BULL, BEAR ou RANGE de la paire). Si l'analyse échoue (Hyperliquid injoignable), rien n'est
placé et le bot réessaie au passage suivant.

### 6.2 Cycle spot, étape par étape

Un cycle spot est un achat suivi d'une vente de la même quantité.

1. **Quand.** Le bot vérifie chaque paire spot activée toutes les **Pause courte de la boucle d'achat (min)**.
   Un achat est tenté quand :
   - la paire n'est pas en pause (voir étape 6) ;
   - depuis la tentative précédente sur cette paire, au moins la **plus petite** des trois
     valeurs **Intervalle entre achats (min)** de la paire (BULL, BEAR, RANGE) s'est écoulée,
     quel que soit le marché actuel. La première tentative après le démarrage du bot attend
     **Délai avant le premier achat (min)**.
2. **Autorisé ?** Les achats doivent être activés globalement (**Achats activés (global)**) **et**
   dans le bloc de la paire correspondant au marché actuel (**Achats activés**). Sinon, la
   tentative compte mais rien n'est placé.
3. **Prix.** Avec *P* = prix actuel :
   - prix d'achat = *P* + **Offset d'achat** ; prix de vente cible = *P* + **Offset de vente** ;
   - avec l'**Unité de l'offset** `abs`, les offsets sont en USDC ; avec `pct`, en % de *P* ;
   - **en marché RANGE**, les offsets sont **dynamiques** : achat = *P* − *d*, vente = *P* + *d*,
     avec *d* = amplitude du range × **RANGE - % du range utilisé** / 100 / 2. Les offsets
     RANGE statiques de la paire ne servent que si le range ne peut pas être calculé (amplitude 0).
4. **Quantité.** Montant = **% du solde USDC** × les USDC **disponibles** (non déjà bloqués
   par des ordres ouverts). Quantité = montant / prix d'achat, arrondie **à l'inférieur** au pas
   de taille de la paire. Si la valeur de l'ordre est inférieure à **Valeur minimale d'ordre (USDC)**
   (au moins 10 USDC, minimum d'Hyperliquid), l'achat est refusé et le log affiche « Value too low ».
5. **Ordre.** Un ordre d'achat limite est placé au prix d'achat. Le cycle apparaît sur le
   Tableau de bord en **Achat en attente**, avec le prix de vente cible déjà enregistré.
6. **Pause.** Après chaque tentative, ordre placé ou non, la paire attend
   **Pause après une tentative (min)** du bloc du marché actuel.
7. **Achat exécuté.** Le bot l'apprend par l'historique Hyperliquid, récupéré toutes les
   **Intervalle de récupération Hyperliquid (min)**. Le cycle passe en **Vente en attente**. Un
   achat partiellement exécuté encore ouvert reste en **Achat en attente**.
8. **Vente.** La boucle de vente (toutes les **Intervalle de la boucle de vente (s)**) place un
   ordre de vente limite au **prix de vente cible enregistré à l'étape 3**. Elle vend la
   quantité réellement reçue : Hyperliquid prélève les frais d'achat dans le jeton acheté, donc
   le bot vend la quantité achetée moins ces frais, arrondie à l'inférieur au pas de taille. Un
   petit reliquat peut rester dans votre wallet ; un cycle ultérieur le vend quand le solde le
   permet.
   - Le prix de vente n'est pas recalculé. Si le marché est déjà au-dessus, la vente est
     exécutée immédiatement au prix du marché (mieux que prévu).
   - Si le solde ne suffit pas, le bot réessaie ; après 3 tentatives, le problème est
     enregistré comme **erreur** dans le log.
9. **Vente exécutée.** Le cycle passe en **Terminé**. Le profit est calculé avec le prix et la
   quantité de vente réels et les frais réels : quantité vendue × (prix de vente − prix d'achat)
   − frais d'achat − frais de vente.

Les interrupteurs **Ventes activées** n'ont actuellement aucun effet : une fois un achat
exécuté, sa vente est toujours placée.

**Exemple chiffré (RANGE).** Prix actuel 85 000 ; sur les 20 dernières bougies, la clôture la
plus haute est 85 200 et la plus basse 84 770 : amplitude 430. Avec **RANGE - % du range utilisé** =
75 : *d* = 430 × 75 / 100 / 2 = 161,25. Achat à 85 000 − 161,25 = 84 838,75 ; vente cible à
85 000 + 161,25 = 85 161,25. Avec **% du solde USDC** = 5 et 400 USDC disponibles : 20 USDC,
soit 20 / 84 838,75 = 0,0002357 du jeton de base, arrondi à l'inférieur au pas de taille de la paire.

### 6.3 Cycle perp, étape par étape

Un cycle perp est une entrée (long ou short), puis une sortie par take-profit, stop-loss ou clôture.

1. **Quand.** Mêmes règles qu'en spot : chaque paire perp activée est vérifiée toutes les
   **Pause courte de la boucle d'achat (min)** ; pause après chaque tentative (**Pause après une tentative (min)**
   du bloc du marché actuel) et plus petite des trois valeurs **Intervalle entre entrées (min)**.
2. **Avant toute entrée, à chaque passage**, le bot applique la **Direction** actuelle aux cycles
   déjà ouverts sur la paire :
   - direction **none** : les entrées pas encore exécutées sont annulées ; les positions ouvertes
     suivent **Direction réglée sur « none » avec une position ouverte** (`keep_tp_sl` = laisser
     le take-profit et le stop-loss en place ; `close_market` / `close_limit` = clôturer la position) ;
   - direction **opposée** à un cycle ouvert (par exemple `short` alors qu'un long est ouvert) :
     une entrée pas encore exécutée est annulée, une position ouverte est clôturée selon
     **Clôturer sur un retournement** (`market` = ordre au marché ; `limit` = ordre limite au prix actuel).
3. **Quel côté.** `long` ou `short` : ce côté. `none` : aucune entrée. `both` : selon la
   **Règle de la direction « both »** :
   - `first_filled` : une entrée long et une entrée short sont placées ; la première exécutée
     annule l'autre ;
   - `range_position` : long si le prix est dans la moitié basse du range, short dans la
     moitié haute ; hors marché RANGE, aucune entrée ;
   - `alternate` : le côté opposé au cycle précédent de la paire.
4. **Filtre de funding.** Pas de long si le taux de funding est supérieur à +**Seuil de funding (%)** ;
   pas de short s'il est inférieur à −seuil. Si le funding n'est pas disponible, aucune entrée.
5. **Levier et marge.** Si besoin, le bot règle le **Levier** et le **Mode de marge** de la
   paire sur Hyperliquid avant l'entrée.
6. **Prix et taille.** Avec *P* = prix actuel : entrée = *P* + offset d'entrée du côté, take-
   profit = *P* + offset de take-profit du côté (USDC ou % selon l'**Unité de l'offset**).
   Marge utilisée = **% de la marge disponible** × marge disponible ; taille = marge × levier
   / prix d'entrée, arrondie à l'inférieur.
7. **Entrée.** Ordre limite au prix d'entrée. Quand il est exécuté, le bot place un
   **take-profit** (limite, reduce-only) au prix enregistré et un **stop-loss** (stop
   market, reduce-only) à **Stop-loss (% du prix d'entrée)** du prix d'entrée réel.
8. **Sortie.** Le cycle se termine quand le take-profit, le stop-loss ou une clôture est exécuté.
   Les ordres market et stop market acceptent un écart d'au plus **Slippage des ordres market (%)**.

Suivez les cycles perp sur la page **🟣 Cycles perp**.

### 6.4 Page Paires tradées

La page **🧩 Paires tradées** liste les paires configurées pour le bot.

- **Ajouter une paire** : sur **🌐 Paires Hyperliquid**, cliquez sur **Ajouter** sur la ligne de
  la paire. Une nouvelle paire est à l'état **désactivé** ; ses réglages spot sont pré-remplis avec les
  valeurs par défaut BULL / BEAR / RANGE de la page **Paramètres**. Les réglages perp doivent
  être saisis.
- **Modifier** : ouvre les réglages de la paire : une partie générale, puis un bloc par type de
  marché (BULL, BEAR, RANGE). **Enregistrer** vérifie chaque valeur ; les champs erronés sont
  mis en évidence.
- Colonne **Configuration** : **complet**, ou le nombre de champs **à compléter**. Une paire
  ne peut être activée que lorsqu'elle est complète.
- **Activer / Désactiver** : seules les paires activées et complètes sont tradées. Seules les
  paires spot cotées en USDC peuvent être activées. Une paire désactivée ne place aucune
  nouvelle entrée, mais **ses cycles ouverts continuent jusqu'à leur clôture**.
- **Supprimer** : possible uniquement quand la paire n'a aucun cycle en cours. Désactivez-la
  d'abord et attendez la fin de ses cycles.
- Les modifications s'appliquent au passage suivant de la boucle concernée, sans redémarrer.

**Offsets** — prix d'achat ou d'entrée = prix actuel + offset ; prix de vente ou de take-profit =
prix actuel + offset. Un offset négatif est en dessous du prix actuel.

#### Réglages d'une paire spot

Partie générale :

| Champ | Signification |
|---|---|
| Unité de l'offset | `abs` = offsets en USDC ; `pct` = offsets en % du prix actuel |
| Intervalle des bougies | bougies de l'analyse du marché de cette paire ; vide = **Intervalle des bougies** global |
| RANGE - % du range utilisé | offsets dynamiques en RANGE = ± (amplitude du range × ce %) / 2 |

Un bloc pour BULL, un pour BEAR, un pour RANGE :

| Champ | Signification |
|---|---|
| Achats activés | achats autorisés quand ce type de marché est détecté |
| Ventes activées | actuellement sans effet : les ventes sont toujours placées |
| Offset d'achat | prix d'achat = prix actuel + cet offset (en général négatif) ; en RANGE, remplacé par l'offset dynamique |
| Offset de vente | prix de vente cible = prix actuel + cet offset ; en RANGE, remplacé par l'offset dynamique |
| % du solde USDC | part des USDC disponibles utilisée pour chaque achat |
| Pause après une tentative (min) | attente après chaque tentative d'achat dans ce marché |
| Intervalle entre achats (min) | temps minimum entre deux tentatives d'achat ; la plus petite valeur des trois blocs est utilisée |

#### Réglages d'une paire perp

Partie générale :

| Champ | Signification |
|---|---|
| Unité de l'offset | `abs` = USDC ; `pct` = % du prix actuel |
| Intervalle des bougies | comme en spot |
| Levier | limité au levier maximum de l'actif |
| Mode de marge | `cross` ou `isolated` (certains actifs imposent `isolated`) |
| Stop-loss (% du prix d'entrée) | ordre stop market à ce % du prix d'entrée réel |
| Seuil de funding (%) | pas de long si funding > +seuil ; pas de short si funding < −seuil |
| Slippage des ordres market (%) | écart maximum accepté sur les ordres market et stop market |
| Règle de la direction « both » | `first_filled`, `range_position` ou `alternate` (voir 6.3) ; obligatoire dès qu'un bloc utilise `both` |
| Clôturer sur un retournement | `market` ou `limit` |
| Direction réglée sur « none » avec une position ouverte | `keep_tp_sl`, `close_market` ou `close_limit` |

Un bloc pour BULL, un pour BEAR, un pour RANGE :

| Champ | Signification |
|---|---|
| Direction | `long`, `short`, `both` ou `none` (aucune entrée) |
| Offset d'entrée long / Offset de take-profit long | le take-profit doit être au-dessus de l'entrée |
| Offset d'entrée short / Offset de take-profit short | le take-profit doit être en dessous de l'entrée |
| % de la marge disponible | part de la marge disponible utilisée pour chaque entrée, identique en long et en short |
| Pause après une tentative (min) | attente après chaque tentative d'entrée dans ce marché |
| Intervalle entre entrées (min) | temps minimum entre deux tentatives d'entrée ; la plus petite valeur des trois blocs est utilisée |

### 6.5 Page Paramètres

**⚙️ Paramètres** regroupe les réglages globaux. Une valeur modifiée ici est enregistrée et
appliquée immédiatement (port et adresse d'écoute : au prochain redémarrage). **Valeur par défaut**
revient à la valeur d'origine. L'adresse du wallet et la clé de l'API wallet ne se règlent pas
ici (page **🔑 Compte Hyperliquid**).

**Mode de fonctionnement**

| Réglage | Défaut | Signification |
|---|---|---|
| Mode simulation (DRY_RUN) | non | le bot lit Hyperliquid normalement mais n'envoie aucun ordre et n'enregistre aucun cycle |

**Analyse du marché** — commune à toutes les paires (voir 6.1)

| Réglage | Défaut | Signification |
|---|---|---|
| Intervalle des bougies | 1h | bougies utilisées quand une paire n'a pas son propre intervalle des bougies |
| Période MA4 / Période MA8 / Période MA12 | 4 / 8 / 12 | nombre de bougies de chaque moyenne mobile |
| Seuil RANGE MA12 (%) | 0,25 | variation maximale de la MA12 pour détecter un marché RANGE |
| Périodes MA12 vérifiées | 5 | nombre de périodes sur lesquelles la MA12 est vérifiée |
| Nombre de bougies récupérées | 100 | doit couvrir la plus grande période utilisée (MA12 + périodes vérifiées, périodes du range) |

**Activation des ordres**

| Réglage | Défaut | Signification |
|---|---|---|
| Achats activés (global) | oui | interrupteur général : désactivé = aucun achat sur aucune paire spot |
| Achats en BULL / BEAR / RANGE | oui / non / oui | valeur par défaut des nouvelles paires spot |
| Ventes activées (global), Ventes en BULL / BEAR / RANGE | — | actuellement sans effet |

**Marché BULL / BEAR / RANGE — valeurs par défaut des nouvelles paires spot** : offsets d'achat
et de vente (USDC), % du solde USDC, pause après une tentative, intervalle entre achats. Ils
pré-remplissent une paire spot quand elle est ajoutée ; **les modifier ne change pas les paires
déjà ajoutées**. Le bloc RANGE contient aussi :

| Réglage | Défaut | Signification |
|---|---|---|
| RANGE - périodes du range | 20 | nombre de bougies utilisées pour le haut et le bas du range (toutes les paires) |
| RANGE - % du range utilisé | 75 | valeur par défaut des nouvelles paires spot |

Valeurs par défaut : BULL achat 0 / vente +1000, 3 %, pause 10 min, intervalle 360 min ; BEAR
achat −1000 / vente 0, 3 %, pause 10 min, intervalle 360 min ; RANGE achat −400 / vente +400,
5 %, pause 10 min, intervalle 180 min.

**Ordres et frais**

| Réglage | Défaut | Signification |
|---|---|---|
| Valeur minimale d'ordre (USDC) | 10 | les ordres plus petits ne sont pas placés (minimum d'Hyperliquid : 10) |
| Frais maker (%) | 0,04 | utilisés uniquement quand les frais réels d'un trade sont manquants |
| Frais taker (%) | 0,07 | estimation des frais des ordres market et stop market |

**Cadencement et synchronisation**

| Réglage | Défaut | Signification |
|---|---|---|
| Intervalle de récupération Hyperliquid (min) | 10 | fréquence de récupération des ordres ouverts, exécutions et historique : une exécution est vue au plus tard ce délai après avoir eu lieu |
| Délai avant le premier achat (min) | 0 | après le démarrage du bot ; appliqué au prochain démarrage |
| Pause courte de la boucle d'achat (min) | 1 | attente entre deux vérifications de l'intervalle d'achat, et après une erreur |
| Intervalle de la boucle de vente (s) | 120 | attente entre deux passages de la boucle de vente |

**Notifications Telegram** — voir section 9.

**Interface web**

| Réglage | Défaut | Signification |
|---|---|---|
| Langue | English | langue de l'interface web et des messages Telegram |
| Thème | Sombre | affichage sombre ou clair |
| Adresse d'écoute | 0.0.0.0 | 0.0.0.0 = accessible depuis le réseau local ; 127.0.0.1 = cet ordinateur uniquement (redémarrage) |
| Port de l'interface web | 60000 | appliqué au redémarrage |
| Cache de la liste des paires (s) | 43200 | la liste des paires Hyperliquid est gardée 12 h et rafraîchie en arrière-plan |
| Délai entre les requêtes au catalogue (ms) | 150 | pause entre deux requêtes lors du chargement de la liste des paires |
| Durée de session (h) | 12 | s'applique aux connexions suivantes |
| Échecs de connexion avant blocage | 5 | par adresse IP |
| Durée de blocage (min) | 15 | |

**Fichier de log**

| Réglage | Défaut | Signification |
|---|---|---|
| Enregistrer les avertissements | non | les erreurs sont toujours enregistrées ; les avertissements seulement si activé (section 12) |

## 7. Licence et abonnement

### Prix

| Abonnement | Prix |
|---|---|
| 7 jours | 2 $ |
| 30 jours | 6 $ |

La période payée s'ajoute à la fin de votre licence en cours (ou part de la date du paiement
si la licence est terminée).

### Comment payer

Page **Licence**, bloc **Abonnement et paiement** :

1. choisissez l'abonnement, le jeton et le réseau ;
2. le bot affiche le **montant exact**, l'**adresse de réception** et l'adresse **depuis
   laquelle payer**. Le montant est valable **1 heure** (moins si le cours bouge de plus de
   10 %) ;
3. envoyez **exactement ce montant**, sur **ce réseau**, **depuis le wallet de votre compte
   HL-Spot** ;
4. le paiement est reconnu automatiquement (quelques minutes selon le réseau) et la licence
   est prolongée.

Les jetons et réseaux proposés sont ceux affichés sur la page Licence.

**Règles — lisez-les avant de payer :**

- payez **exactement** le montant demandé, ni plus ni moins ; **les frais de réseau sont à
  votre charge** ;
- payez **depuis le wallet de votre compte** (pour le BTC : depuis votre adresse BTC
  déclarée) ;
- payez sur le réseau affiché, pendant la validité du montant ;
- un paiement qui ne respecte pas ces règles (adresse inconnue, montant différent, autre
  réseau, après la validité) **est perdu : aucun remboursement**.

### Payer en BTC

Avant votre premier paiement en BTC, déclarez votre **adresse BTC** sur la page Licence
(preuve par une signature de votre wallet principal). Le paiement n'est reconnu que s'il part
**de cette adresse BTC** : dans votre wallet BTC, choisissez cette adresse comme source du
paiement (« coin control »).

### Contrôles de la licence

- La licence est contrôlée auprès du serveur **toutes les 6 heures**.
- Si le serveur est injoignable, le bot continue jusqu'à la date de fin connue de la
  licence.
- **24 heures avant la fin** : avertissement sur les pages web et par Telegram.
- Après la fin : **24 heures de grâce** (le trading continue, avec un avertissement), puis le
  trading s'arrête.
- Ne reculez pas l'horloge de votre ordinateur : une horloge reculée de plus de 5 minutes
  arrête le trading jusqu'au contrôle réussi suivant.

## 8. API wallet : expiration et remplacement

- La page **Compte Hyperliquid** affiche la date d'expiration de votre API wallet. Vous
  pouvez la saisir vous-même si besoin.
- Pendant les **7 derniers jours** : bandeau sur les pages web et message Telegram quotidien.
- À la date d'expiration, le trading s'arrête. Créez un nouvel API wallet (section 3) et
  saisissez sa clé sur la page **Compte Hyperliquid** : le trading redémarre sans relancer le
  programme.
- La nouvelle clé doit appartenir au **même wallet principal** : l'adresse du wallet ne peut
  pas être changée.
- Le bot vérifie auprès d'Hyperliquid, au démarrage puis toutes les 24 heures, que l'API
  wallet appartient toujours à votre wallet.

## 9. Notifications Telegram

Dans **Paramètres → Notifications Telegram** :

1. créez un bot Telegram avec **@BotFather** et copiez son token ;
2. obtenez votre identifiant de conversation (par exemple avec **@userinfobot**) ;
3. saisissez le token et l'identifiant, puis activez les notifications et choisissez les
   messages (ordres placés, achats exécutés, cycles terminés, erreurs, résumé quotidien).

## 10. Utiliser HL-Spot sur un autre ordinateur

Installez le bot sur le nouvel ordinateur et choisissez **J'ai déjà un compte** au premier
lancement. L'ancienne installation est libérée. **Un changement par 30 jours.** La page
Licence indique la date du prochain changement possible.

## 11. Mot de passe oublié

Sur la page de connexion, cliquez sur **Mot de passe oublié ?**. Prouvez que le wallet vous
appartient par une **signature de votre wallet principal**, puis choisissez un nouveau mot de
passe.

## 12. Log

La page **📝 Log** affiche les erreurs enregistrées par le bot (et les avertissements si
**Paramètres → Fichier de log → Enregistrer les avertissements** est activé). Le fichier est
limité à 1 Mo : les entrées les plus anciennes sont retirées. Vous pouvez filtrer, télécharger
le fichier (utile pour le support) et le vider.

## 13. Supprimer votre compte

Page **Licence**, **🗑️ Supprimer mon compte** : mot de passe + signature de votre wallet
principal.

- Votre compte HL-Spot est supprimé **définitivement**.
- Le temps de licence restant est **perdu et non remboursé**.
- L'essai gratuit n'est **pas** accordé de nouveau pour ce wallet.
- Sur cet ordinateur, l'adresse du wallet, la clé de l'API wallet et le mot de passe sont
  effacés ; l'historique des trades est gardé.

## 14. Mises à jour et sauvegarde

- **Mise à jour** : installez la nouvelle version (décompressez-la, ou chargez la nouvelle
  image Docker) ; vos données sont gardées (section 4).
- **Sauvegarde** : copiez le dossier des données (section 4). Le fichier `.env` et le fichier
  `secret.key` vont **ensemble** : les valeurs chiffrées du `.env` et de la base ne peuvent pas être
  lues sans `secret.key`. Si `secret.key` est perdu, ces valeurs (clé de l'API wallet, token
  Telegram…) doivent être ressaisies.

## 15. Accès depuis une autre machine

Par défaut, la page web écoute sur toutes les interfaces réseau, port **60000**
(**Paramètres → Interface web**, appliqué au redémarrage). Depuis une autre machine de votre
réseau : `http://<adresse de la machine du bot>:60000`.

Sur le réseau, la page **n'est pas chiffrée** : saisissez la clé de votre API wallet et votre
mot de passe de préférence depuis la machine du bot. N'exposez jamais le port 60000
directement sur Internet.

## 16. Faire tourner HL-Spot sur Flux

[Flux](https://runonflux.com) est un cloud décentralisé : il loue des conteneurs sur des
serveurs (nœuds) tenus par des tiers. HL-Spot peut y tourner jour et nuit sans votre
ordinateur. Flux est indépendant de HL-Spot et se paie à Flux.

### La clé de votre API wallet sur Flux : à lire d'abord

Sur Flux, les données du bot (`/data` : la clé chiffrée de l'API wallet **et** le fichier
`secret.key` qui la déchiffre) sont sur des serveurs tenus par d'autres personnes, en copie sur
3 nœuds. Vous choisissez le type d'application au déploiement :

- **Application « enterprise »** (nœuds ArcaneOS) — conseillé : Flux indique que les
  opérateurs des nœuds ne peuvent pas accéder aux données de l'application (disque chiffré,
  accès root restreint) et que les variables d'environnement restent privées.
- **Application ordinaire** : un opérateur de nœud peut lire `/data`, donc la clé de votre API
  wallet ; les variables d'environnement, dont le code de premier lancement, sont lisibles par
  tous. Un API wallet ne peut pas retirer vos fonds, mais qui détient sa clé peut trader sur
  votre compte. À vos risques.

Quel que soit le type, vous pouvez révoquer l'API wallet sur Hyperliquid à tout moment
(section 3).

### Réglages de l'application

| Champ Flux | Valeur |
|---|---|
| Image | `olivier1246/hl-spot:1.0.2` |
| Port et port du conteneur | `60000` |
| Données du conteneur | `g:/data` (**obligatoire**) |
| CPU | 0,2 |
| RAM | 300 Mo (à augmenter si l'application redémarre faute de mémoire) |
| SSD | 3 Go |
| Instances | 3 (minimum de Flux) |
| Environnement | `HL_SPOT_SETUP_CODE=<votre code>` (**obligatoire**), `TZ=Europe/Paris` (facultatif) |

- `g:/data` : **une seule** instance fait tourner le bot ; les 2 autres gardent une copie
  synchronisée des données et prennent le relais si elle s'arrête. N'utilisez jamais une autre
  valeur : le bot tournerait sur 3 machines à la fois et passerait chaque ordre 3 fois.
- `HL_SPOT_SETUP_CODE` : un code de 12 caractères ou plus, différent de votre mot de passe.
  Sans lui, quiconque trouve l'adresse de l'application pourrait créer le compte avant vous.

### Premier lancement sur Flux

1. Ouvrez l'adresse **https** que Flux donne pour l'application.
2. Suivez la section 5, et saisissez votre code dans le cadre **Code de premier lancement**.
3. Utilisez un navigateur avec l'extension de votre wallet : le bot signe le message avec elle.

### Bon à savoir

- L'installation suit les données : quand le bot change de nœud, cela ne compte pas comme un
  changement d'installation (section 10).
- Après un changement de nœud, le bot repart de la copie synchronisée : vérifiez vos ordres
  ouverts sur Hyperliquid.
- **Mise à jour** : remplacez l'image par la nouvelle version dans les réglages de
  l'application sur Flux.
- La page est accessible depuis Internet : elle est protégée par votre mot de passe. Choisissez-le
  robuste.

## 17. Support

- E-mail : HL-spot@cmails.eu

Quand vous contactez le support, joignez le fichier de log (page **📝 Log** → Télécharger le
fichier). N'envoyez jamais la clé de votre API wallet, votre fichier `secret.key` ni votre mot
de passe.
