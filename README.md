# meetup.sch site

# Fordítás és futtatás
Node 8.9.3-ra van szükséged a telepítéshez ([részletek](https://github.com/mapbox/node-sqlite3/issues/758#issuecomment-353108852)). Ha újabb van fent, használd az [nvm](https://github.com/nvm-sh/nvm) vagy [nvm-windows](https://github.com/coreybutler/nvm-windows) programot a downgrade-hez.
```
nvm install 8.9.3
nvm use 8.9.3
```

Adminisztrátorként futtasd PowerShellben ezt a parancsot:
`npm i -g windows-build-tools`.

Most már telepítheted a projektet:
```
cd meetup
npm i
node app.js
```

Ha mindent jól csináltál, az oldalt itt találod: http://localhost:3003

<b>Fontos:</b> A forráson végzett változtatások csak a szerver újraindítása után látszanak.
