#!/bin/sh
# HL-Spot - installation on a Linux VPS (Ubuntu 22.04 / 24.04 / 26.04, Debian 12 or newer)
# 1.0.4 (VPS security). Can be run again: also used for updates (data kept).
#
#   curl -fLO https://raw.githubusercontent.com/HL-Spot-Bot/HL-Spot-Bot/main/vps/install-linux.sh
#   sudo sh install-linux.sh <public-IP-address | domain-name> [version]
#
# The other kit files (Caddyfile.ip, Caddyfile.domain, hl-spot.service) are taken next to the
# script, otherwise downloaded from the public repository (vps/ folder of the requested version).
#
# What the script does:
#   1. system packages (curl, unzip, ufw...) and Caddy (official repository);
#   2. system user "hlspot", program in /opt/hl-spot, data in /var/lib/hl-spot (hlspot only);
#   3. download of the version from GitHub and check of its SHA-256 checksum;
#   4. first-launch code (HL_SPOT_SETUP_CODE) created on the first run, kept afterwards;
#   5. systemd service "hl-spot" (automatic start);
#   6. Caddy: HTTPS on the IP address ("shortlived" certificate) or on the domain name;
#   7. ufw firewall: SSH port(s), 80 and 443 only - the bot's port (60000) stays closed.
set -eu

VERSION_DEFAULT=1.0.9
REPO=https://github.com/HL-Spot-Bot/HL-Spot-Bot
SITE="${1:-}"
VERSION="${2:-$VERSION_DEFAULT}"
PROG=/opt/hl-spot
DATA=/var/lib/hl-spot
ETC=/etc/hl-spot
KIT="$(cd "$(dirname "$0")" && pwd)"

usage() {
    echo "usage: sudo sh install-linux.sh <public-IP-address | domain-name> [version]"
    exit 1
}
die() { echo "ERROR: $*" >&2; exit 1; }

[ -n "$SITE" ] || usage
[ "$(id -u)" = 0 ] || die "run as root (sudo)"
command -v apt-get >/dev/null 2>&1 || die "unsupported system (Ubuntu / Debian with apt-get)"
[ "$(uname -m)" = "x86_64" ] || die "unsupported processor: $(uname -m) (x86_64 only)"

# IPv4 address or domain name
if echo "$SITE" | grep -Eq '^([0-9]{1,3}\.){3}[0-9]{1,3}$'; then
    KIND=ip
else
    { echo "$SITE" | grep -Eq '^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?(\.[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?)+$' \
        && echo "$SITE" | grep -Eq '\.[A-Za-z][A-Za-z0-9-]*$'; } \
        || die "invalid IPv4 address or domain name: $SITE"
    KIND=domain
fi
echo "== HL-Spot $VERSION - access https://$SITE ($KIND)"

# Kit files: next to the script, otherwise from the public repository
command -v curl >/dev/null 2>&1 || { apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install curl; }
for f in Caddyfile.ip Caddyfile.domain hl-spot.service; do
    if [ ! -f "$KIT/$f" ]; then
        [ -n "${KIT_TMP:-}" ] || KIT_TMP="$(mktemp -d)"
        curl -fsSL -o "$KIT_TMP/$f" "https://raw.githubusercontent.com/HL-Spot-Bot/HL-Spot-Bot/v$VERSION/vps/$f" \
            || die "kit file not found: $f (version $VERSION)"
    fi
done
if [ -n "${KIT_TMP:-}" ]; then
    for f in Caddyfile.ip Caddyfile.domain hl-spot.service; do
        [ -f "$KIT_TMP/$f" ] || cp "$KIT/$f" "$KIT_TMP/$f"
    done
    KIT="$KIT_TMP"
fi

# An existing Caddyfile that was not written by HL-Spot is left untouched (the unmodified
# default file of the caddy package is accepted: same checksum as the package's)
caddyfile_is_stock() {
    stock="$(dpkg-query -W -f='${Conffiles}\n' caddy 2>/dev/null | awk '$1=="/etc/caddy/Caddyfile"{print $2}')"
    [ -n "$stock" ] && [ "$(md5sum /etc/caddy/Caddyfile | awk '{print $1}')" = "$stock" ]
}
if [ -f /etc/caddy/Caddyfile ] && ! grep -q "HL-Spot" /etc/caddy/Caddyfile && ! caddyfile_is_stock; then
    die "/etc/caddy/Caddyfile already exists and was not created by HL-Spot: add the content of
Caddyfile.$KIND yourself (see the user guide, VPS section)."
fi

echo "== 1. System packages"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install curl unzip ufw ca-certificates gpg \
    debian-keyring debian-archive-keyring apt-transport-https

echo "== 2. Caddy (official repository: a recent version is needed for the IP certificate)"
if [ ! -f /usr/share/keyrings/caddy-stable-archive-keyring.gpg ]; then
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
        | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
        > /etc/apt/sources.list.d/caddy-stable.list
    apt-get update
fi
DEBIAN_FRONTEND=noninteractive apt-get -y install caddy
caddy version

echo "== 3. User hlspot and folders"
id hlspot >/dev/null 2>&1 || useradd --system --home-dir "$DATA" --shell /usr/sbin/nologin hlspot
mkdir -p "$PROG" "$DATA" "$ETC"
chown hlspot:hlspot "$DATA"
chmod 700 "$DATA"
chmod 755 "$ETC"

echo "== 4. Download of HL-Spot $VERSION (GitHub) and SHA-256 check"
NAME="HL-Spot-$VERSION-prod-linux-x64"
if [ ! -x "$PROG/$NAME/hl-spot" ]; then
    TMP="$(mktemp -d)"
    curl -fL --retry 3 -o "$TMP/$NAME.zip" "$REPO/releases/download/v$VERSION/$NAME.zip"
    curl -fL --retry 3 -o "$TMP/$NAME.zip.sha256" "$REPO/releases/download/v$VERSION/$NAME.zip.sha256"
    (cd "$TMP" && sha256sum -c "$NAME.zip.sha256") || die "wrong SHA-256 checksum: file refused"
    unzip -oq "$TMP/$NAME.zip" -d "$PROG"
    rm -rf "$TMP"
    chown -R root:root "$PROG/$NAME"
    chmod -R u=rwX,go=rX "$PROG/$NAME"
    chmod 755 "$PROG/$NAME/hl-spot"
fi
"$PROG/$NAME/hl-spot" --version
ln -sfn "$PROG/$NAME" "$PROG/current"

echo "== 5. First-launch code (kept if it already exists)"
NEW_CODE=""
if [ ! -f "$ETC/hl-spot.env" ]; then
    NEW_CODE="$(tr -dc 'A-HJ-NP-Za-km-z2-9' < /dev/urandom | head -c 16)"
    umask 077
    {
        echo "# HL-Spot - service variables (readable by root only)"
        echo "HL_SPOT_SETUP_CODE=$NEW_CODE"
        echo "# Time zone of the daily Telegram summary, e.g. TZ=Europe/Paris"
        echo "TZ=Etc/UTC"
    } > "$ETC/hl-spot.env"
    umask 022
fi
chown root:root "$ETC/hl-spot.env"
chmod 600 "$ETC/hl-spot.env"

echo "== 6. systemd service hl-spot"
install -m 644 "$KIT/hl-spot.service" /etc/systemd/system/hl-spot.service
systemctl daemon-reload
systemctl enable hl-spot
systemctl restart hl-spot
sleep 5
systemctl --no-pager status hl-spot | head -n 5 || true

echo "== 7. Caddy: HTTPS on $SITE"
mkdir -p /etc/caddy
sed "s|{\$HL_SPOT_SITE}|$SITE|g" "$KIT/Caddyfile.$KIND" > /etc/caddy/Caddyfile.new
caddy validate --config /etc/caddy/Caddyfile.new --adapter caddyfile
mv /etc/caddy/Caddyfile.new /etc/caddy/Caddyfile
# "caddy validate" run as root may create files owned by root: Caddy (user caddy) must be able
# to open them (problem seen on the license server on 2026-10-02)
if [ -d /var/log/caddy ]; then chown -R caddy:caddy /var/log/caddy; fi
systemctl enable caddy
systemctl reload caddy || systemctl restart caddy

echo "== 8. ufw firewall: SSH, 80, 443 (the bot's port 60000 stays closed)"
# SSH ports, from every source (a wrong guess would cut your access when ufw is enabled):
# Port and ListenAddress of sshd, ports really listened to by sshd or ssh.socket, and the
# server port of the SSH connection running this script.
SSH_PORTS="$( {
    sshd -T 2>/dev/null | awk '$1=="port"{print $2} $1=="listenaddress"{n=split($2,a,":"); print a[n]}'
    ss -Hltnp 2>/dev/null | awk '/"sshd"/{n=split($4,a,":"); print a[n]}'
    systemctl show -p Listen ssh.socket 2>/dev/null | grep -o ':[0-9]*' | tr -d ':'
    [ -n "${SSH_CONNECTION:-}" ] && echo "$SSH_CONNECTION" | awk '{print $4}'
} | grep -E '^[0-9]+$' | sort -un | tr '\n' ' ')"
UFW_ACTIVE=no
ufw status 2>/dev/null | grep -q "Status: active" && UFW_ACTIVE=yes
# Other services listening on public addresses: enabling ufw (deny by default) would cut them
OTHERS="$(ss -Hltn 2>/dev/null | awk '{print $4}' | grep -v -E '^(127\.|\[::1\]|::1)' | awk -F: '{print $NF}' | sort -un \
    | while read -r p; do case " $SSH_PORTS 80 443 60000 " in *" $p "*) ;; *) printf '%s ' "$p";; esac; done)"
if [ -z "$SSH_PORTS" ]; then
    echo "WARNING: SSH port not found: firewall NOT changed, so as not to cut your access."
    echo "Do it yourself: ufw allow <SSH port>/tcp ; ufw allow 80/tcp ; ufw allow 443/tcp ; ufw enable"
elif [ "$UFW_ACTIVE" = no ] && [ -n "$OTHERS" ]; then
    echo "WARNING: other services listen on public ports ($OTHERS): enabling ufw would block them."
    echo "Firewall NOT enabled. Allow what you need, then: ufw allow 80/tcp ; ufw allow 443/tcp ;"
    for p in $SSH_PORTS; do echo "  ufw allow $p/tcp"; done
    echo "  ufw enable"
else
    for p in $SSH_PORTS; do ufw allow "$p/tcp"; done
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw --force enable
    ufw status
fi

echo
echo "================================================================"
echo " HL-Spot $VERSION installed."
echo " Web page: https://$SITE  (first certificate: a few seconds to a few minutes)"
if [ -n "$NEW_CODE" ]; then
    echo " First-launch code: $NEW_CODE"
    echo "   (to enter on the first-launch page; kept in $ETC/hl-spot.env)"
else
    echo " First-launch code: unchanged (see $ETC/hl-spot.env)"
fi
echo " Then, in the bot: Settings > Web interface > Listening address = 127.0.0.1,"
echo " then: sudo systemctl restart hl-spot"
echo " Service log: journalctl -u hl-spot -f"
echo " Also open ports 80 and 443 in your hosting provider's firewall, if it has one."
echo "================================================================"
