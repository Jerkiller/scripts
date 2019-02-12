

# Version of NPM
npm –v

# Set Proxy in npm
npm config set proxy http://proxy.org:8080
npm config set https-proxy http://proxy.org:8080

# crea un package.json
npm init --yes

# installa un package
npm i packageName@version

# Elenca dipendenze
npm list

# Mostra dipendenze di un pack
npm view mongoose dependencies

# Mostra cosa poss aggiorn
npm outdated

# Aggiorna minor e patch che vede in outdated
npm update

# comando per installare pack utile. I pacchetti installati con -g diventano comandi da SO. E.g. ng, npm, ncu, ...
npm i -g npm-check-updates

# comando per sapere cosa c'è da aggiornare
ncu

# comando per aggiornare le major sul package.json. Dopo occorre fare npm install.
ncu -u

# installa un pack utile solo in pre, non in prod
npm i jshint --save-dev

# unistall a package
npm un packageName

# cosa aggiornare globalmente su PC
npm -g outdated

# crea un account su npmjs
npm adduser

# accede a npmjs
npm login

# pubblica un pack su npmjs
npm publish

# aggiorna versione minore
npm version minor

# install angular cli
npm install -g @angular/cli
