# Nasratdemo

Aplikace pro otestovani instalace serveru pro Upíří tržiště.

## Ziskani aplikace
```bash
git clone https://github.com/laki1/nasratdemo.git
cd nasratdemo
```

## Instalace aplikace

V prostredi Node.js

```bash
npm install
```

#### Build aplikace

Pozor, pred spustenim buildu je treba mit spustenu sluzbu Postgraphile a 
kompletne nakonfigurovanou aplikaci.

[Dokumentace buildu](https://kit.svelte.dev/docs/building-your-app)

**Po zmene konfigurace je treba provest novy build!!!**

```bash
npm run build
```
Cela aplikace je pote pripravena ve slozce **./build/**

[Dokumentace nasazeni v ruznych prostredich](https://kit.svelte.dev/docs/adapter-node)

#### Spusteni aplikace

```bash
node build/index.js
```

## Konfigurace aplikace
**Po zmene konfigurace je treba provest novy build!!!**
1. nastaveni GraphQL parametru v souboru **./houdini.config.js**
```javascript
    "watchSchema": {
        "url": "http://127.0.0.1:5000/graphql"
    },
```
2. nastaveni emailoveho uctu seznam.cz skrze ktery se budou odesilat emaily z aplikace v souboru **./.env**
```bash
SEZNAM_EMAIL_LOGIN=blbec_k_veceri@seznam.cz
SEZNAM_EMAIL_PASSWORD=tajneheslo
```
3. nastaveni adresy a portu, kde aplikace pobezi v souboru **./vite.config.js**
```javascript
server: {
	host: "192.168.10.40",
	port: 5173,
```

## Spuštění podpůrných služeb

#### Databáze
K provozu je třeba zprovoznit přiloženou zalohu databáze v adresáři **./_external_/** v prostředí PostgreSQL verze min.14. 

Formát zálohy je TAR a encoding nastaven na UTF8.


#### GraphQL sluzba Postgraphile
K provozu je třeba spustit jako službu projekt **Postgraphile**. Je treba spoustet jako službu v prostredi node v samostatnem adresari, kde neni aplikace!!!!!
Do tohodo adresáře je třeba zkopirovat konfiguraci soubor **.postgraphilerc.js** z adresare **./_external_/**.

[Dokumentace Postgraphile](https://www.graphile.org/postgraphile/usage-cli/)

##### Instalace Postgraphile
Zalezi na zpusobu spousteni sluzby - vse popsano v [dokumentaci](https://www.npmjs.com/package/postgraphile).
Pro dev staci globalni instalace v prostredi Node:
```bash
npm install -g postgraphile
```

##### Spusteni Postgraphile
```bash
postgraphile
```

##### Konfigurace GraphQL - .postgraphilerc.js
1. Spravne nastavit connection string do PosgreSQL databaze
```javascript
connection: "postgres://postgres:postgres@127.0.0.1:1234/nasratdemo",
```
2. nastavit adresu, kde bude dostupny GraphQL server
```javascript
host: "127.0.0.1"
port: "5500"
```
3. pro dev prostredi nechat zapnute GraphQLi prostredi
```javascript
enhanceGraphiql: true
```

#### Pravidelne odesilani emailu
Provadi se pouhym periodickym zavolanim urcitych URL metdou **GET** s danymi parametry, v tomto pripade je to napr. takovato url:
```bash
http://localhost:5173/email?magic=123
```

Staci naplanovat periodicke spousteni programu **wget**.


## License

[MIT](https://choosealicense.com/licenses/mit/)