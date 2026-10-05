# HL-Spot — Guia do utilizador

Versão 1.0.2

O HL-Spot é um bot de trading para a **Hyperliquid**: mercados spot e perpétuos (perp), vários pares,
ordens automáticas e manuais. Funciona **no seu próprio computador** (Windows, Linux ou Docker) e
controla-o a partir do seu navegador web.

> **Site**: https://hlspot.com
> **Transferência**: https://github.com/HL-Spot-Bot/HL-Spot-Bot
> **Suporte**: HL-spot@cmails.eu

---

## 1. Antes de começar

Precisa de:

- um computador com processador x86 de 64 bits (x86_64) com **Windows** ou **Linux**, ou qualquer
  máquina com **Docker**;
- ou uma conta **Flux**, para o executar na nuvem (secção 16);
- uma conta **Hyperliquid** com fundos (a sua carteira principal);
- uma carteira capaz de **"assinar uma mensagem"** com o endereço da sua carteira principal. Uma extensão
  de navegador (MetaMask, Rabby…) é o mais simples: o bot abre-a por si. Qualquer outra carteira funciona por
  copiar e colar;
- uma ligação à Internet.

## 2. Segurança: o que deve saber

- O HL-Spot só aceita uma chave de **API wallet** da Hyperliquid. **Nunca introduza a chave privada
  da sua carteira principal.** Uma API wallet pode negociar por si, mas não pode levantar os seus fundos.
- A chave da API wallet é **encriptada** no seu computador. **Nunca é enviada** para o servidor de
  licenças.
- A sua carteira principal é usada apenas para **assinar mensagens** (criação de conta, senha esquecida,
  endereço BTC, eliminação da conta). Uma mensagem assinada não é uma transação: não custa nada
  e não movimenta fundos.
- A página web do bot está protegida pela sua senha. De preferência, utilize-a a partir da máquina do bot
  (`http://localhost:60000`): a partir de outra máquina da sua rede, a página não é
  encriptada (ver secção 15).

## 3. Criar a sua API wallet Hyperliquid

1. Aceda a **https://app.hyperliquid.xyz/API** e ligue a sua carteira principal.
2. Dê um nome à API wallet e, em seguida, gere-a.
3. **Copie a chave privada** apresentada e guarde-a num local seguro: a Hyperliquid só a mostra uma vez.
4. Autorize a API wallet (assinatura com a sua carteira principal).
5. Anote a **data de expiração** da API wallet indicada pela Hyperliquid.

Irá introduzir no HL-Spot: o **endereço da sua carteira principal** (0x…) e a **chave privada da API
wallet**.

## 4. Instalar o HL-Spot

Descarregue o ficheiro para o seu sistema e o respetivo ficheiro `.sha256` a partir de
https://github.com/HL-Spot-Bot/HL-Spot-Bot. O ficheiro `.sha256` permite verificar que a transferência está
íntegra.

### Windows

1. Descompacte `HL-Spot-1.0.2-prod-windows-x64.zip`.
2. Na pasta descompactada, execute **`HL-Spot.exe`**. Abre-se uma janela de consola: mantenha-a aberta enquanto
   o bot estiver a funcionar.
3. Abra **http://localhost:60000** no seu navegador.

### Linux (Ubuntu 22.04, 24.04, 26.04, Debian 12 ou mais recente)

```
unzip HL-Spot-1.0.2-prod-linux-x64.zip
cd HL-Spot-1.0.2-prod-linux-x64
./hl-spot
```

Em seguida, abra **http://localhost:60000** no seu navegador.

### Docker

```
docker load -i HL-Spot-1.0.2-prod-docker-x64.tar.gz
docker run -d --name hl-spot --restart unless-stopped -p 60000:60000 \
       -e TZ=Europe/Paris -v hl-spot-data:/data hl-spot:1.0.2
```

- `-p 60000:60000` é obrigatório para aceder à página web.
- `TZ` define o fuso horário (UTC se omitido).
- Os seus dados ficam no volume `hl-spot-data`, mesmo que o contentor seja removido ou a imagem
  atualizada.
- `docker stop hl-spot` para o bot de forma limpa.

Em seguida, abra **http://localhost:60000** (ou `http://<machine address>:60000`).

### Onde ficam guardados os seus dados

Os seus dados (configurações, chave encriptada, base de dados, log) ficam guardados **fora do programa**:

| Sistema | Pasta |
|---|---|
| Windows | `%LOCALAPPDATA%\HL-Spot` |
| Linux | `~/.local/share/hl-spot` |
| Docker | o volume `/data` |

Reinstalar ou atualizar o programa nunca lhes toca.

## 5. Primeira inicialização

A primeira página é **Primeira inicialização**. Escolha:

- **Criar uma conta** se for um novo utilizador;
- **Já tenho uma conta** se já tiver uma conta HL-Spot (novo computador,
  reinstalação).

### Criar uma conta

1. **Endereço da carteira**: o endereço da sua carteira principal (0x…).
2. **Chave privada da API wallet**: a chave copiada na secção 3. É verificada junto da Hyperliquid
   antes de qualquer outra coisa.
3. **Senha**: pelo menos 8 caracteres, com uma letra maiúscula, uma letra minúscula, um
   algarismo e um carácter especial. Protege tanto a sua conta HL-Spot como a página web
   do bot.
4. **Assinatura da carteira principal**:
   - **Assinar com minha carteira**: o bot abre a extensão da sua carteira; verifique o endereço e
     confirme a assinatura;
   - ou **Obter a mensagem a assinar**: copie a mensagem tal como está para a sua carteira, assine-a e
     cole a assinatura (0x…). A mensagem é válida durante 15 minutos.
5. Clique em **Criar a conta**.

O seu **período de teste gratuito de 7 dias** começa. É concedido apenas uma vez por carteira e por
instalação. O trading começa assim que a sua conta Hyperliquid for verificada.

### Já tenho uma conta

Introduza o endereço da sua carteira e a sua senha. Esta instalação é registada e a
anterior é libertada (**uma mudança de instalação a cada 30 dias**).

## 6. Utilizar o bot

O menu no topo dá acesso a:

| Página | Utilização |
|---|---|
| 📊 Painel | saldos, estado do mercado, estado de cada par |
| 📈 Estatísticas | resultados dos ciclos spot e perp, por período |
| 🧩 Pares negociados | pares spot e perp configurados para o bot |
| 🟣 Ciclos perp | entradas, take-profits, stop-losses e fechamentos dos pares perp |
| 🖐️ Ordens manuais | coloque uma ordem manualmente; o bot então acompanha o ciclo como os demais |
| 🌐 Pares Hyperliquid | lista dos pares spot e perp da Hyperliquid |
| ⚙️ Configurações | todas as configurações (aplicadas sem reiniciar, exceto a porta e o endereço de escuta) |
| 📝 Log | erros (e avisos, se ativados) |
| 🔑 Conta Hyperliquid | carteira, chave da API wallet, data de expiração |
| 📜 Licença | licença, assinatura, pagamento, instalação, eliminação da conta |

O bot só negoceia se **a sua conta Hyperliquid estiver verificada** e **a sua licença for
válida**. Sem uma licença válida, apenas as páginas Conta Hyperliquid e Licença estão
disponíveis.

Quando o bot deixa de negociar (licença terminada, API wallet expirada ou recusada), **não
toca nas ordens e posições já abertas**: estas ficam sob a sua responsabilidade.

## 7. Licença e assinatura

### Preços

| Assinatura | Preço |
|---|---|
| 7 dias | 2 $ |
| 30 dias | 6 $ |

O período pago é acrescentado ao fim da sua licença atual (ou começa na data do pagamento
se a licença tiver terminado).

### Como pagar

Na página **Licença**, bloco **Assinatura e pagamento**:

1. escolha a assinatura, o token e a rede;
2. o bot mostra o **montante exato**, o **endereço de receção** e o endereço a partir do qual deve
   **pagar**. O montante é válido durante **1 hora** (menos se o preço variar mais de
   10 %);
3. envie **exatamente este montante**, **nesta rede**, **a partir da carteira da sua conta
   HL-Spot**;
4. o pagamento é reconhecido automaticamente (alguns minutos, consoante a rede) e a
   licença é prolongada.

Os tokens e redes disponíveis são os apresentados na página Licença.

**Regras — leia-as antes de pagar:**

- pague **exatamente** o montante pedido, nem mais nem menos; **as taxas de rede são por sua conta**;
- pague **a partir da carteira da sua conta** (para BTC: a partir do endereço BTC declarado);
- pague na rede indicada, enquanto o montante for válido;
- um pagamento que não cumpra estas regras (endereço desconhecido, montante diferente, outra
  rede, após o prazo de validade) **é perdido: sem reembolso**.

### Pagar em BTC

Antes do seu primeiro pagamento em BTC, declare o seu **endereço BTC** na página Licença (prova por
assinatura da sua carteira principal). O pagamento só é reconhecido se for enviado **a partir deste endereço
BTC**: na sua carteira BTC, escolha este endereço como origem do pagamento ("coin
control").

### Verificações da licença

- A licença é verificada junto do servidor **a cada 6 horas**.
- Se o servidor não estiver acessível, o bot continua até à data de fim conhecida da
  licença.
- **24 horas antes do fim**: aviso nas páginas web e por Telegram.
- Após o fim: **24 horas de tolerância** (o trading continua, com um aviso) e, depois, o trading
  para.
- Não atrase o relógio do seu computador: um relógio atrasado mais de 5 minutos para o
  trading até à próxima verificação bem-sucedida.

## 8. API wallet: expiração e substituição

- A página **Conta Hyperliquid** mostra a data de expiração da sua API wallet. Pode introduzi-la
  manualmente, se necessário.
- Durante os **últimos 7 dias**: faixa nas páginas web e uma mensagem Telegram diária.
- Na data de expiração, o trading para. Crie uma nova API wallet (secção 3) e introduza a respetiva chave na
  página **Conta Hyperliquid**: o trading recomeça sem reiniciar o programa.
- A nova chave deve pertencer à **mesma carteira principal**: o endereço da carteira não pode ser alterado.
- O bot verifica junto da Hyperliquid, no arranque e a cada 24 horas, que a API wallet continua a
  pertencer à sua carteira.

## 9. Notificações Telegram

Em **Configurações → Notificações Telegram**:

1. crie um bot Telegram com o **@BotFather** e copie o respetivo token;
2. obtenha o seu chat ID (por exemplo, com o **@userinfobot**);
3. introduza o token e o chat ID e, em seguida, ative as notificações e escolha as mensagens
   (ordens colocadas, compras executadas, ciclos concluídos, erros, resumo diário).

## 10. Utilizar o HL-Spot noutro computador

Instale o bot no novo computador e escolha **Já tenho uma conta** na primeira
inicialização. A instalação antiga é libertada. **Uma mudança a cada 30 dias.** A página Licença
mostra a data da próxima mudança possível.

## 11. Senha esquecida

Na página de início de sessão, clique em **Esqueceu sua senha?**. Prove que é o titular da carteira através de uma
**assinatura da sua carteira principal** e, em seguida, escolha uma nova senha.

## 12. Log

A página **📝 Log** mostra os erros registados pelo bot (e os avisos, se
**Configurações → Ficheiro de log → Registar os avisos** estiver ativado). O ficheiro está limitado a 1 MB: as
entradas mais antigas são removidas. Pode filtrar, descarregar o ficheiro (útil para o suporte) e limpá-lo.

## 13. Eliminar a sua conta

Página **Licença**, **🗑️ Excluir minha conta**: senha + assinatura da sua carteira principal.

- A sua conta HL-Spot é eliminada **definitivamente**.
- O tempo de licença restante é **perdido e não é reembolsado**.
- O período de teste gratuito **não** volta a ser concedido para esta carteira.
- Neste computador, o endereço da carteira, a chave da API wallet e a senha são apagados; o
  histórico de trading é mantido.

## 14. Atualizações e cópia de segurança

- **Atualização**: instale a nova versão (descompacte-a ou carregue a nova imagem Docker); os seus dados
  são mantidos (secção 4).
- **Cópia de segurança**: copie a pasta de dados (secção 4). O ficheiro `.env` e o ficheiro `secret.key` andam
  **juntos**: os valores encriptados do `.env` e da base de dados não podem ser lidos sem
  `secret.key`. Se `secret.key` se perder, estes valores (chave da API wallet, token Telegram…) têm
  de ser introduzidos novamente.

## 15. Acesso a partir de outra máquina

Por predefinição, a página web escuta em todas as interfaces de rede, porta **60000** (**Configurações → Interface
web**, aplicado no reinício). A partir de outra máquina da sua rede: `http://<bot
machine address>:60000`.

Na rede, a página **não é encriptada**: introduza a chave da sua API wallet e a sua senha
de preferência a partir da máquina do bot. Nunca exponha a porta 60000 diretamente à Internet.

## 16. Executar o HL-Spot no Flux

O [Flux](https://runonflux.com) é uma nuvem descentralizada: aluga contentores em servidores
(nós) geridos por terceiros. O HL-Spot pode funcionar lá dia e noite sem o seu computador. O
Flux é independente do HL-Spot e é pago ao Flux.

### A chave do seu API wallet no Flux: leia primeiro

No Flux, os dados do bot (`/data`: a chave encriptada do API wallet **e** o ficheiro `secret.key`
que a desencripta) ficam em servidores geridos por outras pessoas, copiados em 3 nós. Escolhe o
tipo de aplicação ao implantá-la:

- **Aplicação «enterprise»** (nós ArcaneOS), recomendada: o Flux indica que os operadores dos
  nós não podem aceder aos dados da aplicação (disco encriptado, acesso root restrito) e que as
  variáveis de ambiente se mantêm privadas.
- **Aplicação comum**: um operador de nó pode ler `/data`, e portanto a chave do seu API
  wallet; as variáveis de ambiente, incluindo o código de primeira inicialização, podem ser
  lidas por qualquer pessoa. Um API wallet não pode levantar os seus fundos, mas quem tiver a
  sua chave pode negociar na sua conta. Por sua conta e risco.

Seja qual for o tipo, pode revogar o API wallet na Hyperliquid a qualquer momento (secção 3).

### Definições da aplicação

| Campo do Flux | Valor |
|---|---|
| Imagem | `olivier1246/hl-spot:1.0.2` |
| Porta e porta do contentor | `60000` |
| Dados do contentor | `g:/data` (**obrigatório**) |
| CPU | 0,2 |
| RAM | 300 MB (aumente-a se a aplicação reiniciar por falta de memória) |
| SSD | 3 GB |
| Instâncias | 3 (mínimo do Flux) |
| Ambiente | `HL_SPOT_SETUP_CODE=<o seu código>` (**obrigatório**), `TZ=Europe/Paris` (opcional) |

- `g:/data`: **uma só** instância executa o bot; as outras 2 guardam uma cópia sincronizada dos
  dados e assumem se ela parar. Nunca use outro valor: o bot funcionaria em 3 máquinas ao mesmo
  tempo e enviaria cada ordem 3 vezes.
- `HL_SPOT_SETUP_CODE`: um código com 12 caracteres ou mais, diferente da sua senha.
  Sem ele, qualquer pessoa que encontre o endereço da aplicação poderia criar a conta antes de
  si.

### Primeira inicialização no Flux

1. Abra o endereço **https** que o Flux indica para a aplicação.
2. Siga a secção 5 e introduza o seu código no campo **Código de primeira inicialização**.
3. Use um navegador com a extensão da sua carteira: o bot assina a mensagem com ela.

### Bom saber

- A instalação acompanha os dados: quando o bot muda de nó, isso não conta como mudança de
  instalação (secção 10).
- Após uma mudança de nó, o bot reinicia a partir da cópia sincronizada: verifique as suas
  ordens abertas na Hyperliquid.
- **Atualização**: substitua a imagem pela nova versão nas definições da aplicação no Flux.
- A página é acessível a partir da Internet: está protegida pela sua senha. Escolha uma
  forte.

## 17. Suporte

- E-mail: HL-spot@cmails.eu

Quando contactar o suporte, anexe o ficheiro de log (página **📝 Log** → Descarregar o ficheiro). Nunca
envie a chave da sua API wallet, o seu ficheiro `secret.key` nem a sua senha.
