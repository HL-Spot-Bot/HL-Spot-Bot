# HL-Spot — User guide

Version 1.0.2

HL-Spot is a trading bot for **Hyperliquid**: spot and perpetual (perp) markets, several pairs,
automatic and manual orders. It runs **on your own computer** (Windows, Linux or Docker) and you
control it from your web browser.

> **Website**: https://hlspot.com
> **Download**: https://github.com/HL-Spot-Bot/HL-Spot-Bot
> **Support**: HL-spot@cmails.eu

---

## 1. Before you start

You need:

- a computer with a 64-bit x86 processor (x86_64) running **Windows** or **Linux**, or any
  machine with **Docker**;
- or a **Flux** account, to run it in the cloud (section 16);
- a **Hyperliquid** account with funds (your main wallet);
- a wallet able to **"sign a message"** with your main wallet address. A browser extension
  (MetaMask, Rabby…) is the simplest: the bot opens it for you. Any other wallet works by
  copy and paste;
- an Internet connection.

## 2. Security: what you must know

- HL-Spot only accepts an **API wallet** key from Hyperliquid. **Never enter the private key
  of your main wallet.** An API wallet can trade for you but cannot withdraw your funds.
- The API wallet key is **encrypted** on your computer. It is **never sent** to the license
  server.
- Your main wallet is used only to **sign messages** (account creation, forgotten password,
  BTC address, account deletion). A signed message is not a transaction: it costs nothing
  and moves no funds.
- The bot's web page is protected by your password. Prefer to use it from the bot's machine
  (`http://localhost:60000`): from another machine of your network, the page is not
  encrypted (see section 15).

## 3. Create your Hyperliquid API wallet

1. Go to **https://app.hyperliquid.xyz/API** and connect your main wallet.
2. Give the API wallet a name, then generate it.
3. **Copy the private key** shown and keep it in a safe place: Hyperliquid shows it only once.
4. Authorize the API wallet (signature with your main wallet).
5. Note the **expiry date** of the API wallet shown by Hyperliquid.

You will enter in HL-Spot: your **main wallet address** (0x…) and the **API wallet private
key**.

## 4. Install HL-Spot

Download the file for your system and its `.sha256` file from
https://github.com/HL-Spot-Bot/HL-Spot-Bot. The `.sha256` file lets you check that the download is
intact.

### Windows

1. Unzip `HL-Spot-1.0.2-prod-windows-x64.zip`.
2. In the unzipped folder, run **`HL-Spot.exe`**. A console window opens: keep it open while
   the bot runs.
3. Open **http://localhost:60000** in your browser.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 or newer)

```
unzip HL-Spot-1.0.2-prod-linux-x64.zip
cd HL-Spot-1.0.2-prod-linux-x64
./hl-spot
```

Then open **http://localhost:60000** in your browser.

### Docker

```
docker load -i HL-Spot-1.0.2-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.2
```

- `-p 60000:60000` is required to reach the web page.
- `TZ` sets the time zone (UTC if omitted).
- Your data stay in the `hl-spot-data` volume, even if the container is removed or the image
  updated.
- `docker stop hl-spot` stops the bot cleanly.

Then open **http://localhost:60000** (or `http://<machine address>:60000`).

### Where your data are kept

Your data (settings, encrypted key, database, log) are kept **outside the program**:

| System | Folder |
|---|---|
| Windows | `%LOCALAPPDATA%\HL-Spot` |
| Linux | `~/.local/share/hl-spot` |
| Docker | the `/data` volume |

Reinstalling or updating the program never touches them.

## 5. First launch

The first page is **First launch**. Choose:

- **Create an account** if you are new;
- **I already have an account** if you already have an HL-Spot account (new computer,
  reinstallation).

### Create an account

1. **Wallet address**: your main wallet address (0x…).
2. **API wallet private key**: the key copied in section 3. It is checked with Hyperliquid
   before anything else.
3. **Password**: at least 8 characters, with an uppercase letter, a lowercase letter, a
   digit and a special character. It protects both your HL-Spot account and the bot's web
   page.
4. **Main wallet signature**:
   - **Sign with my wallet**: the bot opens your wallet extension; check the address and
     confirm the signature;
   - or **Get the message to sign**: copy the message as is into your wallet, sign it, and
     paste the signature (0x…). The message is valid for 15 minutes.
5. Click **Create the account**.

Your **free trial of 7 days** starts. It is granted only once per wallet and per
installation. Trading starts once your Hyperliquid account is verified.

### I already have an account

Enter your wallet address and your password. This installation is registered and the
previous one is released (**one installation change per 30 days**).

## 6. Using the bot

The menu at the top gives access to:

| Page | Use |
|---|---|
| 📊 Dashboard | balances, market status, state of each pair |
| 📈 Statistics | spot and perp cycle results, by period |
| 🧩 Traded pairs | spot and perp pairs configured for the bot |
| 🟣 Perp cycles | entries, take-profits, stop-losses and closes of perp pairs |
| 🖐️ Manual orders | place an order by hand; the bot then follows the cycle like the others |
| 🌐 Hyperliquid pairs | list of Hyperliquid spot and perp pairs |
| ⚙️ Settings | all settings (applied without restart, except port and listening address) |
| 📝 Log | errors (and warnings if enabled) |
| 🔑 Hyperliquid account | wallet, API wallet key, expiry date |
| 📜 License | license, subscription, payment, installation, account deletion |

The bot trades only if **your Hyperliquid account is verified** and **your license is
valid**. Without a valid license, only the Hyperliquid account and License pages are
available.

When the bot stops trading (license ended, API wallet expired or refused), it **does not
touch orders and positions already open**: they remain your responsibility.

## 7. License and subscription

### Prices

| Subscription | Price |
|---|---|
| 7 days | 2 $ |
| 30 days | 6 $ |

The period paid is added to the end of your current license (or starts on the payment date
if the license has ended).

### How to pay

On the **License** page, **Subscription and payment** block:

1. choose the subscription, the token and the network;
2. the bot shows the **exact amount**, the **receiving address** and the address you must
   **pay from**. The amount is valid for **1 hour** (less if the price moves by more than
   10 %);
3. send **exactly this amount**, on **this network**, **from the wallet of your HL-Spot
   account**;
4. the payment is recognized automatically (a few minutes depending on the network) and the
   license is extended.

The tokens and networks offered are those shown on the License page.

**Rules — read them before paying:**

- pay **exactly** the amount requested, neither more nor less; **network fees are yours**;
- pay **from your account's wallet** (for BTC: from your declared BTC address);
- pay on the network shown, while the amount is valid;
- a payment that does not follow these rules (unknown address, different amount, other
  network, after the validity) **is lost: no refund**.

### Paying in BTC

Before your first BTC payment, declare your **BTC address** on the License page (proof by a
signature of your main wallet). The payment is recognized only if it is sent **from this BTC
address**: in your BTC wallet, choose this address as the source of the payment ("coin
control").

### License checks

- The license is checked with the server **every 6 hours**.
- If the server cannot be reached, the bot continues until the known end date of the
  license.
- **24 hours before the end**: warning on the web pages and by Telegram.
- After the end: **24 hours of grace** (trading continues, with a warning), then trading
  stops.
- Do not set your computer's clock back: a clock moved back by more than 5 minutes stops
  trading until the next successful check.

## 8. API wallet: expiry and replacement

- The **Hyperliquid account** page shows the expiry date of your API wallet. You can enter
  it yourself if needed.
- During the **last 7 days**: banner on the web pages and a daily Telegram message.
- At the expiry date, trading stops. Create a new API wallet (section 3) and enter its key on
  the **Hyperliquid account** page: trading restarts without restarting the program.
- The new key must belong to the **same main wallet**: the wallet address cannot be changed.
- The bot checks with Hyperliquid at startup and every 24 hours that the API wallet still
  belongs to your wallet.

## 9. Telegram notifications

In **Settings → Telegram notifications**:

1. create a Telegram bot with **@BotFather** and copy its token;
2. get your chat ID (for example with **@userinfobot**);
3. enter the token and the chat ID, then enable notifications and choose the messages
   (orders placed, buys filled, completed cycles, errors, daily summary).

## 10. Using HL-Spot on another computer

Install the bot on the new computer and choose **I already have an account** at first
launch. The old installation is released. **One change per 30 days.** The License page
shows the date of the next possible change.

## 11. Forgotten password

On the login page, click **Forgot your password?**. Prove that you own the wallet by a
**signature of your main wallet**, then choose a new password.

## 12. Log

The **📝 Log** page shows the errors recorded by the bot (and the warnings if
**Settings → Log file → Record warnings** is enabled). The file is limited to 1 MB: the
oldest entries are removed. You can filter, download the file (useful for support) and clear
it.

## 13. Delete your account

**License** page, **🗑️ Delete my account**: password + signature of your main wallet.

- Your HL-Spot account is deleted **permanently**.
- The remaining license time is **lost and not refunded**.
- The free trial is **not** granted again for this wallet.
- On this computer, the wallet address, the API wallet key and the password are erased; the
  trading history is kept.

## 14. Updates and backup

- **Update**: install the new version (unzip it, or load the new Docker image); your data
  are kept (section 4).
- **Backup**: copy the data folder (section 4). The `.env` file and the `secret.key` file go
  **together**: the encrypted values of `.env` and of the database cannot be read without
  `secret.key`. If `secret.key` is lost, these values (API wallet key, Telegram token…) must
  be entered again.

## 15. Access from another machine

By default the web page listens on all network interfaces, port **60000** (**Settings → Web
interface**, applied at restart). From another machine of your network: `http://<bot
machine address>:60000`.

On the network, the page is **not encrypted**: enter your API wallet key and your password
preferably from the bot's machine. Never expose port 60000 directly to the Internet.

## 16. Running HL-Spot on Flux

[Flux](https://runonflux.com) is a decentralized cloud: it rents containers on servers (nodes)
run by third parties. HL-Spot can run there day and night without your computer. Flux is
independent of HL-Spot and is paid to Flux.

### Your API wallet key on Flux: read this first

On Flux, the bot's data (`/data`: the encrypted API wallet key **and** the `secret.key` file
that decrypts it) are on servers run by other people, copied on 3 nodes. You choose the type
of app when you deploy it:

- **Enterprise app** (ArcaneOS nodes) — recommended: Flux states that node operators cannot
  access the app's data (encrypted disk, restricted root access) and that environment
  variables stay private.
- **Ordinary app**: a node operator can read `/data`, so your API wallet key; environment
  variables, including the first-launch code, can be read by anyone. An API wallet cannot
  withdraw your funds, but whoever holds its key can trade on your account. At your own risk.

Whatever the type, you can revoke the API wallet on Hyperliquid at any time (section 3).

### App settings

| Flux field | Value |
|---|---|
| Image | `olivier1246/hl-spot:1.0.2` |
| Port and container port | `60000` |
| Container data | `g:/data` (**required**) |
| CPU | 0.2 |
| RAM | 300 MB (increase it if the app restarts for lack of memory) |
| SSD | 3 GB |
| Instances | 3 (Flux minimum) |
| Environment | `HL_SPOT_SETUP_CODE=<your code>` (**required**), `TZ=Europe/Paris` (optional) |

- `g:/data`: only **one** instance runs the bot; the 2 others keep a synchronized copy of the
  data and take over if it stops. Never use another value: the bot would run on 3 machines
  at once and place each order 3 times.
- `HL_SPOT_SETUP_CODE`: a code of 12 characters or more, different from your password. Without
  it, anyone who finds the address of the app could create the account before you.

### First launch on Flux

1. Open the **https** address that Flux gives for the app.
2. Follow section 5, and enter your code in the **First-launch code** box.
3. Use a browser with your wallet extension: the bot signs the message with it.

### Good to know

- The installation follows the data: when the bot moves to another node, this does not count
  as an installation change (section 10).
- After a move, the bot restarts from the synchronized copy: check your open orders on
  Hyperliquid.
- **Update**: change the image to the new version in the app settings on Flux.
- The page is reachable from the Internet: it is protected by your password. Choose a strong
  one.

## 17. Support

- E-mail: HL-spot@cmails.eu

When you contact support, attach the log file (**📝 Log** page → Download the file). Never
send your API wallet key, your `secret.key` file or your password.
