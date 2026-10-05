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
| 📊 Tableau de bord | soldes, état du marché, état de chaque paire |
| 📈 Statistiques | résultats des cycles spot et perp, par période |
| 🧩 Paires tradées | paires spot et perp configurées pour le bot |
| 🟣 Cycles perp | entrées, take-profits, stop-loss et clôtures des paires perp |
| 🖐️ Ordres manuels | placez un ordre à la main ; le bot suit ensuite le cycle comme les autres |
| 🌐 Paires Hyperliquid | liste des paires spot et perp d'Hyperliquid |
| ⚙️ Paramètres | tous les réglages (appliqués sans redémarrer, sauf le port et l'adresse d'écoute) |
| 📝 Log | erreurs (et avertissements si activés) |
| 🔑 Compte Hyperliquid | wallet, clé de l'API wallet, date d'expiration |
| 📜 Licence | licence, abonnement, paiement, installation, suppression du compte |

Le bot ne trade que si **votre compte Hyperliquid est vérifié** et **votre licence est
valable**. Sans licence valable, seules les pages Compte Hyperliquid et Licence sont
accessibles.

Quand le bot arrête de trader (licence terminée, API wallet expiré ou refusé), il **ne touche
pas aux ordres et positions déjà ouverts** : ils restent sous votre responsabilité.

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
