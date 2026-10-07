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
| 📊 Painel | saldos, estado do mercado, estado de cada ciclo spot |
| 📈 Estatísticas | resultados dos ciclos spot e perp, por período |
| 🧩 Pares negociados | pares spot e perp configurados para o bot, e as respetivas configurações |
| 🟣 Ciclos perp | entradas, take-profits, stop-losses e fechamentos dos pares perp |
| 🖐️ Ordens manuais | coloque uma ordem manualmente; o bot então acompanha o ciclo como os demais |
| 🌐 Pares Hyperliquid | lista dos pares spot e perp da Hyperliquid; adicione aqui um par ao bot |
| ⚙️ Configurações | configurações globais (aplicadas sem reiniciar, exceto a porta e o endereço de escuta) |
| 📝 Log | erros (e avisos, se ativados) |
| 🔑 Conta Hyperliquid | carteira, chave da API wallet, data de expiração |
| 📜 Licença | licença, assinatura, pagamento, instalação, eliminação da conta |

O bot só negoceia se **a sua conta Hyperliquid estiver verificada** e **a sua licença for
válida**. Sem uma licença válida, apenas as páginas Conta Hyperliquid e Licença estão
disponíveis.

Quando o bot deixa de negociar (licença terminada, API wallet expirada ou recusada), **não
toca nas ordens e posições já abertas**: estas ficam sob a sua responsabilidade.

As subsecções seguintes explicam como o bot decide e, depois, cada campo das páginas **Pares
negociados** e **Configurações**.

### 6.1 Análise de mercado: BULL, BEAR ou RANGE

Antes de cada compra (spot) ou entrada (perp), o bot analisa **o próprio par**, com as velas
desse par:

1. Obtém as últimas **Número de velas obtidas** velas (configuração `LIMIT`) do
   **Intervalo das velas** do par (vazio = a configuração global **Intervalo das velas**).
2. O **preço atual** é o fecho da vela mais recente.
3. Calcula três médias móveis dos fechos: **MA4**, **MA8** e **MA12** (o respetivo
   número de velas é definido em **Configurações → Análise de mercado**).
4. Decide o tipo de mercado, por esta ordem:
   - **RANGE** se a MA12 estiver plana: nos últimos **Períodos da MA12 verificados**, a MA12
     variou no máximo **Limite RANGE da MA12 (%)** entre o seu valor mais baixo e o mais alto;
   - caso contrário, **BULL** se MA4 > MA8 > MA12;
   - caso contrário, **BEAR** se MA4 < MA8 < MA12;
   - caso contrário, **RANGE**.
5. Calcula também o **range**: o fecho mais alto e o mais baixo nas últimas
   **RANGE - períodos do range** velas. A sua amplitude é máximo − mínimo.

Cada par usa então **as suas próprias configurações para o tipo de mercado detetado** (bloco
BULL, BEAR ou RANGE do par). Se a análise falhar (Hyperliquid inacessível), nada é colocado
e o bot tenta novamente na passagem seguinte.

### 6.2 Ciclo spot, passo a passo

Um ciclo spot é uma compra seguida de uma venda da mesma quantidade.

1. **Quando.** O bot verifica cada par spot ativado a cada **Pausa curta do loop de compra (min)**.
   É tentada uma compra quando:
   - o par não está em pausa (ver passo 6);
   - desde a tentativa anterior neste par, passou pelo menos o **menor** dos três valores de
     **Intervalo entre compras (min)** do par (BULL, BEAR, RANGE), seja qual for o
     mercado atual. A primeira tentativa após o arranque do bot aguarda **Atraso antes da primeira
     compra (min)**.
2. **Permitida?** As compras têm de estar ativadas globalmente (**Compras ativadas (global)**) **e** no
   bloco do par correspondente ao mercado atual (**Compras ativadas**). Caso contrário, a tentativa conta, mas
   nada é colocado.
3. **Preços.** Com *P* = preço atual:
   - preço de compra = *P* + **Offset de compra**; preço de venda alvo = *P* + **Offset de venda**;
   - com a **Unidade do offset** `abs`, os offsets são em USDC; com `pct`, em % de *P*;
   - **num mercado RANGE**, os offsets são **dinâmicos**: compra = *P* − *d*, venda = *P* + *d*,
     com *d* = amplitude do range × **RANGE - % do range usado** / 100 / 2. Os offsets RANGE
     estáticos do par só são usados se o range não puder ser calculado (amplitude 0).
4. **Quantidade.** Montante = **% do saldo USDC** × o USDC **disponível** (não já retido por
   ordens abertas). Quantidade = montante / preço de compra, arredondada **por defeito** ao passo de tamanho do
   par. Se o valor da ordem for inferior a **Valor mínimo de ordem (USDC)** (pelo menos 10 USDC,
   mínimo da Hyperliquid), a compra é recusada e o log mostra "Value too low".
5. **Ordem.** É colocada uma ordem de compra limit ao preço de compra. O ciclo aparece no
   Painel como **Compra pendente**, com o preço de venda alvo já registado.
6. **Pausa.** Após cada tentativa, colocada ou não, o par aguarda **Pausa após tentativa
   (min)** do bloco do mercado atual.
7. **Compra executada.** O bot sabe-o pelo histórico da Hyperliquid, obtido a cada
   **Intervalo de busca na Hyperliquid (min)**. O ciclo passa a **Venda pendente**. Uma compra
   parcialmente executada que ainda está aberta permanece **Compra pendente**.
8. **Venda.** O loop de venda (a cada **Intervalo do loop de venda (s)**) coloca uma ordem de venda limit ao
   **preço de venda alvo registado no passo 3**. Vende a quantidade efetivamente recebida:
   a Hyperliquid cobra a taxa de compra no token comprado, pelo que o bot vende a quantidade comprada
   menos essa taxa, arredondada por defeito ao passo de tamanho. Pode ficar um pequeno resto na sua carteira;
   um ciclo posterior vende-o quando o saldo o permitir.
   - O preço de venda não é recalculado. Se o mercado já estiver acima dele, a venda é
     executada imediatamente ao preço de mercado (melhor do que o previsto).
   - Se o saldo não for suficiente, o bot tenta novamente; após 3 tentativas, o problema é
     registado como **erro** no log.
9. **Venda executada.** O ciclo passa a **Concluído**. O lucro é calculado com o preço e a
   quantidade de venda reais e as taxas reais: quantidade vendida × (preço de venda − preço de compra) − taxa
   de compra − taxa de venda.

Os interruptores **Vendas ativadas** não têm atualmente qualquer efeito: assim que uma compra é executada, a respetiva venda é
sempre colocada.

**Exemplo prático (RANGE).** Preço atual 85 000; nas últimas 20 velas, o fecho mais alto
é 85 200 e o mais baixo 84 770: amplitude 430. Com **RANGE - % do range usado** =
75: *d* = 430 × 75 / 100 / 2 = 161,25. Compra a 85 000 − 161,25 = 84 838,75; venda alvo a
85 000 + 161,25 = 85 161,25. Com **% do saldo USDC** = 5 e 400 USDC disponíveis: 20 USDC,
ou seja 20 / 84 838,75 = 0,0002357 do token base, arredondado por defeito ao passo de tamanho do par.

### 6.3 Ciclo perp, passo a passo

Um ciclo perp é uma entrada (long ou short) e, depois, uma saída por take-profit, stop-loss ou fecho.

1. **Quando.** As mesmas regras que no spot: cada par perp ativado é verificado a cada **Pausa curta do
   loop de compra (min)**; pausa após cada tentativa (**Pausa após tentativa (min)** do bloco do mercado
   atual) e o menor dos três **Intervalo entre entradas (min)**.
2. **Antes de qualquer entrada, em cada passagem**, o bot aplica a **Direção** atual aos ciclos
   já abertos no par:
   - direção **none**: as entradas ainda não executadas são canceladas; as posições abertas seguem
     **Direção definida como "nenhuma" com uma posição aberta** (`keep_tp_sl` = manter o take-profit
     e o stop-loss; `close_market` / `close_limit` = fechar a posição);
   - direção **oposta** a um ciclo aberto (por exemplo `short` com um long aberto):
     uma entrada ainda não executada é cancelada, uma posição aberta é fechada de acordo com **Fechar
     em uma reversão** (`market` = ordem a mercado; `limit` = ordem limit ao preço atual).
3. **Que lado.** `long` ou `short`: esse lado. `none`: nenhuma entrada. `both`: de acordo com
   **Regra da direção "both"**:
   - `first_filled`: são colocadas uma entrada long e uma entrada short; a primeira executada cancela a
     outra;
   - `range_position`: long se o preço estiver na metade inferior do range, short na
     metade superior; fora de um mercado RANGE, nenhuma entrada;
   - `alternate`: o lado oposto ao do ciclo anterior do par.
4. **Filtro de funding.** Nenhum long se a taxa de funding for superior a +**Limite de funding (%)**; nenhum
   short se for inferior a −limite. Se o funding não estiver disponível, nenhuma entrada.
5. **Alavancagem e margem.** Se necessário, o bot define a **Alavancagem** e o **Modo de
   margem** do par na Hyperliquid antes da entrada.
6. **Preços e tamanho.** Com *P* = preço atual: entrada = *P* + offset de entrada do lado, take-
   profit = *P* + offset de take-profit do lado (USDC ou % de acordo com **Unidade do offset**).
   Margem usada = **% da margem disponível** × margem disponível; tamanho = margem × alavancagem
   / preço de entrada, arredondado por defeito.
7. **Entrada.** Ordem limit ao preço de entrada. Quando é executada, o bot coloca um
   **take-profit** (limit, reduce-only) ao preço registado e um **stop-loss** (stop
   market, reduce-only) a **Stop-loss (% do preço de entrada)** do preço de entrada real.
8. **Saída.** O ciclo termina quando o take-profit, o stop-loss ou um fecho é executado. As ordens market e
   stop market aceitam um desvio de, no máximo, **Slippage das ordens market (%)**.

Acompanhe os ciclos perp na página **🟣 Ciclos perp**.

### 6.4 Página Pares negociados

A página **🧩 Pares negociados** lista os pares configurados para o bot.

- **Adicionar um par**: em **🌐 Pares Hyperliquid**, clique em **Adicionar** na linha do par. Um novo par fica
  **desativado**; as suas configurações spot são pré-preenchidas com os padrões BULL / BEAR / RANGE da
  página **Configurações**. As configurações perp têm de ser introduzidas.
- **Editar**: abre as configurações do par: uma parte geral e, depois, um bloco por tipo de mercado
  (BULL, BEAR, RANGE). **Salvar** verifica cada valor; os campos incorretos ficam destacados.
- Coluna **Configuração**: **completo**, ou o número de campos **a completar**. Um par
  só pode ser ativado quando estiver completo.
- **Ativar / Desativar**: só os pares ativados e completos são negociados. Só os pares spot
  cotados em USDC podem ser ativados. Um par desativado não coloca nenhuma nova entrada, mas **os seus ciclos abertos continuam
  até fecharem**.
- **Excluir**: só é possível quando o par não tem nenhum ciclo em curso. Desative-o primeiro e
  aguarde que os seus ciclos terminem.
- As alterações aplicam-se na passagem seguinte do loop em causa, sem reiniciar.

**Offsets** — preço de compra ou de entrada = preço atual + offset; preço de venda ou de take-profit =
preço atual + offset. Um offset negativo fica abaixo do preço atual.

#### Configurações dos pares spot

Parte geral:

| Campo | Significado |
|---|---|
| Unidade do offset | `abs` = offsets em USDC; `pct` = offsets em % do preço atual |
| Intervalo das velas | velas da análise de mercado deste par; vazio = **Intervalo das velas** global |
| RANGE - % do range usado | offsets dinâmicos em RANGE = ± (amplitude do range × esta %) / 2 |

Um bloco para BULL, um para BEAR, um para RANGE:

| Campo | Significado |
|---|---|
| Compras ativadas | compras permitidas quando este tipo de mercado é detetado |
| Vendas ativadas | atualmente sem efeito: as vendas são sempre colocadas |
| Offset de compra | preço de compra = preço atual + este offset (normalmente negativo); em RANGE, substituído pelo offset dinâmico |
| Offset de venda | preço de venda alvo = preço atual + este offset; em RANGE, substituído pelo offset dinâmico |
| % do saldo USDC | parte do USDC disponível usada em cada compra |
| Pausa após tentativa (min) | espera após cada tentativa de compra neste mercado |
| Intervalo entre compras (min) | tempo mínimo entre duas tentativas de compra; é usado o menor dos três blocos |

#### Configurações dos pares perp

Parte geral:

| Campo | Significado |
|---|---|
| Unidade do offset | `abs` = USDC; `pct` = % do preço atual |
| Intervalo das velas | como no spot |
| Alavancagem | limitada à alavancagem máxima do ativo |
| Modo de margem | `cross` ou `isolated` (alguns ativos exigem `isolated`) |
| Stop-loss (% do preço de entrada) | ordem stop market a esta % do preço de entrada real |
| Limite de funding (%) | nenhum long se funding > +limite; nenhum short se funding < −limite |
| Slippage das ordens market (%) | desvio máximo aceite nas ordens market e stop market |
| Regra da direção "both" | `first_filled`, `range_position` ou `alternate` (ver 6.3); obrigatória assim que um bloco usa `both` |
| Fechar em uma reversão | `market` ou `limit` |
| Direção definida como "nenhuma" com uma posição aberta | `keep_tp_sl`, `close_market` ou `close_limit` |

Um bloco para BULL, um para BEAR, um para RANGE:

| Campo | Significado |
|---|---|
| Direção | `long`, `short`, `both` ou `none` (nenhuma entrada) |
| Offset de entrada Long / Offset de take-profit Long | o take-profit tem de estar acima da entrada |
| Offset de entrada Short / Offset de take-profit Short | o take-profit tem de estar abaixo da entrada |
| % da margem disponível | parte da margem disponível usada em cada entrada, igual para long e short |
| Pausa após tentativa (min) | espera após cada tentativa de entrada neste mercado |
| Intervalo entre entradas (min) | tempo mínimo entre duas tentativas de entrada; é usado o menor dos três blocos |

### 6.5 Página Configurações

**⚙️ Configurações** contém as configurações globais. Um valor alterado aqui é guardado e aplicado
imediatamente (porta e endereço de escuta: no próximo reinício). **Valor padrão** repõe
o valor original. O endereço da carteira e a chave da API wallet não são definidos aqui (página
**🔑 Conta Hyperliquid**).

**Modo de operação**

| Configuração | Padrão | Significado |
|---|---|---|
| Modo simulação (DRY_RUN) | não | o bot lê a Hyperliquid normalmente, mas não envia nenhuma ordem nem regista nenhum ciclo |

**Análise de mercado** — comum a todos os pares (ver 6.1)

| Configuração | Padrão | Significado |
|---|---|---|
| Intervalo das velas | 1h | velas usadas quando um par não tem intervalo de velas próprio |
| Período da MA4 / Período da MA8 / Período da MA12 | 4 / 8 / 12 | número de velas de cada média móvel |
| Limite RANGE da MA12 (%) | 0,25 | variação máxima da MA12 para detetar um mercado RANGE |
| Períodos da MA12 verificados | 5 | número de períodos ao longo dos quais a MA12 é verificada |
| Número de velas obtidas | 100 | tem de cobrir o maior período usado (MA12 + períodos verificados, períodos do range) |

**Ativação das ordens**

| Configuração | Padrão | Significado |
|---|---|---|
| Compras ativadas (global) | sim | interruptor geral: desligado = nenhuma compra em nenhum par spot |
| Compras em BULL / BEAR / RANGE | sim / não / sim | valor padrão para os novos pares spot |
| Vendas ativadas (global), Vendas em BULL / BEAR / RANGE | — | atualmente sem efeito |

**Mercado BULL / BEAR / RANGE — padrões para novos pares spot**: offsets de compra e de venda (USDC),
% do saldo USDC, pausa após uma tentativa, intervalo entre compras. Pré-preenchem um par spot
quando é adicionado; **alterá-los não altera os pares já adicionados**. O bloco RANGE
contém também:

| Configuração | Padrão | Significado |
|---|---|---|
| RANGE - períodos do range | 20 | número de velas usadas para o máximo e o mínimo do range (todos os pares) |
| RANGE - % do range usado | 75 | valor padrão para os novos pares spot |

Padrões: BULL compra 0 / venda +1000, 3 %, pausa 10 min, intervalo 360 min; BEAR compra −1000 /
venda 0, 3 %, pausa 10 min, intervalo 360 min; RANGE compra −400 / venda +400, 5 %, pausa 10 min,
intervalo 180 min.

**Ordens e taxas**

| Configuração | Padrão | Significado |
|---|---|---|
| Valor mínimo de ordem (USDC) | 10 | as ordens mais pequenas não são colocadas (mínimo da Hyperliquid: 10) |
| Taxa maker (%) | 0,04 | usada apenas quando faltam as taxas reais de uma transação |
| Taxa taker (%) | 0,07 | estimativa da taxa para as ordens market e stop market |

**Tempo e sincronização**

| Configuração | Padrão | Significado |
|---|---|---|
| Intervalo de busca na Hyperliquid (min) | 10 | frequência com que as ordens abertas, as execuções e o histórico são obtidos: uma execução é vista, no máximo, este tempo após ocorrer |
| Atraso antes da primeira compra (min) | 0 | após o arranque do bot; aplicado no próximo arranque |
| Pausa curta do loop de compra (min) | 1 | espera entre duas verificações do intervalo de compra, e após um erro |
| Intervalo do loop de venda (s) | 120 | espera entre duas passagens do loop de venda |

**Notificações Telegram** — ver secção 9.

**Interface web**

| Configuração | Padrão | Significado |
|---|---|---|
| Idioma | English | idioma da interface web e das mensagens Telegram |
| Tema | Escuro | apresentação escura ou clara |
| Endereço de escuta | 0.0.0.0 | 0.0.0.0 = acessível a partir da rede local; 127.0.0.1 = apenas este computador (reinício) |
| Porta da interface web | 60000 | aplicada no reinício |
| Cache da lista de pares (s) | 43200 | a lista de pares da Hyperliquid é mantida durante 12 h e atualizada em segundo plano |
| Atraso entre requisições do catálogo (ms) | 150 | pausa entre dois pedidos ao carregar a lista de pares |
| Duração da sessão (h) | 12 | aplica-se aos próximos inícios de sessão |
| Logins falhos antes do bloqueio | 5 | por endereço IP |
| Duração do bloqueio (min) | 15 | |

**Ficheiro de log**

| Configuração | Padrão | Significado |
|---|---|---|
| Registar os avisos | não | os erros são sempre registados; os avisos só se ativados (secção 12) |

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
