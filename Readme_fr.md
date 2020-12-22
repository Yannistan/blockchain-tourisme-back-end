**Presentation du projet:**

L'application BxTravel est basée sur l'economy de token et a pour but de simuler quelques fonctionnalités d'une agence de voyage. Pour cela, nous avons créé deux smart contrats, notamment le contract de notre application, Tourisme.sol et un contrat TourToken.sol qui génère le token utilisé dans notre Dapp, "TRM". Ce token est vendu par l'agence et il sera utilisé par un client pour payer sa reservation auprès l 'agence. Nous nous servons du contract ERC777 deslibrairies OpenZeppelin pour créer notre token car ce dernier, contrairement au contrat ERC20, permet d'effectuer un transfer de tokens sans avoir besoin de l'autorization de l'acheteur (fonction approve() du contrat ERC20). Le projet contient une interface graphique en React qui permet à un utilisateur de s'inscrire au site de l'agence, d'effectuer une reservation d'un voyage et, finalement, de regler le prix de sa reservationen tokens "TRM".

**Procedure d'installation**

# Environment Dev Ethereum

##Installation du solc
Etant donné que un grand nombre de librairies et de frameworks sont configurés avec la version 0.6.X nous avons installe la version la toute dernière 0.6.X: laversion 0.6.12
Nous avons installé l'interface d eligne de commande de compilateur Solidity, solc à partir du script solc-select script. Ce dernier permet de switcher de façon rapide entre des differentes versions des compilateurs Solidity.

### Docker et Solc

#### Installation du Docker

Nous avons egalement installé docker sur un ordinateur Mac, à partir de commandes suivantes:

% cd ~
% docker pull trailofbits/solc-select
% docker run --read-only -i --rm --entrypoint='/bin/sh' trailofbits/solc-select:latest -c 'cat /usr/bin/install.sh' > a.sh
% sed s+\'/usr/bin/solc\'+\'/usr/local/bin/solc\'+ a.sh > b.sh
% chmod a+x b.sh
% ./b.sh
% chmod a+x /usr/local/bin/solc
% rm a.sh b.sh

Afin d'ajouter solc dans la variable d'environment PATH, nous avons rajouté la ligne suivante:

% export PATH=/home/USERNAME/.solc-select:$PATH

Afin d' utiliser la versions 0.6.12 du solc, on tape:

% solc use 0.6.12

Pour utiliser solc extension sur VScode:

Clic droit sur un fichier `.sol` -> Solidity: Change global compiler version(remote) -> choose 0.6.12

### Linters et formatteurs du code

#### solhint - Lien: https://protofire.github.io/solhint/

solhint et un linter dont nous nous servons pour effectuer de l'analyse statique des fichiers solidity afin d'indentifier des errors ainsi que des mauvaises pratiques de code.

##### Installation

% yarn add --dev solhint

En suite, nous avons créé un fichier .solhint.json:

{
"extends": "solhint:recommended",
"rules": {
"func-order": "off",
"mark-callable-contracts": "off",
"no-empty-blocks": "off",
"compiler-version": ["error", "^0.6.0"],
"private-vars-leading-underscore": "error",
"reason-string": "off"
}
}

#### Eslint - Lien: https://eslint.org/docs/user-guide/getting-started

Eslint est un linter pour des fichiers JS.

##### Installation du eslint et de ses plugins

% yarn add --dev eslint eslint-config-standard eslint-plugin-import eslint-plugin-mocha-no-only eslint-plugin-node eslint-plugin-promise eslint-plugin-standard

En suite nous avons créé un fichier .eslintrc

{
"extends": ["standard", "plugin:promise/recommended"],
"plugins": ["mocha-no-only", "promise"],
"env": {
"browser": true,
"node": true,
"mocha": true,
"jest": true
},
"globals": {
"artifacts": false,
"contract": false,
"assert": false,
"web3": false
},
"rules": {
// Strict mode
"strict": ["error", "global"],

    // Code style
    "array-bracket-spacing": ["off"],
    "camelcase": ["error", { "properties": "always" }],
    "comma-dangle": ["error", "always-multiline"],
    "comma-spacing": ["error", { "before": false, "after": true }],
    "dot-notation": ["error", { "allowKeywords": true, "allowPattern": "" }],
    "eol-last": ["error", "always"],
    "eqeqeq": ["error", "smart"],
    "generator-star-spacing": ["error", "before"],
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],
    "max-len": ["error", 120, 2],
    "no-debugger": "off",
    "no-dupe-args": "error",
    "no-dupe-keys": "error",
    "no-mixed-spaces-and-tabs": ["error", "smart-tabs"],
    "no-redeclare": ["error", { "builtinGlobals": true }],
    "no-trailing-spaces": ["error", { "skipBlankLines": false }],
    "no-undef": "error",
    "no-use-before-define": "off",
    "no-var": "error",
    "object-curly-spacing": ["error", "always"],
    "prefer-const": "error",
    "quotes": ["error", "single"],
    "semi": ["error", "always"],
    "space-before-function-paren": ["error", "always"],

    "mocha-no-only/mocha-no-only": ["error"],

    "promise/always-return": "off",
    "promise/avoid-new": "off"

},
"parserOptions": {
"ecmaVersion": 2018
}
}

#### Prettier

Prettier est un formatteur du code permet de formatter le code automatiqument en sauvegardant

##### Installation du prettier et de ses plugins

% yarn add --dev prettier prettier-plugin-solidity

Création d'un fichier .prettierrc

and create a .prettierrc config file:

{
"overrides": [
{
"files": "*.sol",
"options": {
"printWidth": 120,
"tabWidth": 4,
"useTabs": false,
"singleQuote": false,
"bracketSpacing": false,
"explicitTypes": "always"
}
},
{
"files": "*.js",
"options": {
"printWidth": 120,
"tabWidth": 2,
"useTabs": false,
"semi": true,
"singleQuote": true,
"arrowParens": "always",
"bracketSpacing": true,
"trailingComma": "all"
}
}
]
}

#### EditorConfig

Nous avons installé l'extension EditorConfig: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig et nous avons aussi generé un fichier .editorconfig:

# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file

root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
insert_final_newline = true
trim_trailing_whitespace = false
max_line_length = 120

[*.sol]
indent_size = 4

[*.js]
indent_size = 2

[*.adoc]
max_line_length = 0

### Truffle

#### Installation

% npm install -g truffle

Nous avons créé un dossier pour la partie back-end de notre projet: tourisme-back-end

% mkdir tourisme-back
% cd tourisme-back

En suite, il faut initialiser un projet Truffle un repo git et un projet node.js :

% truffle init
% git init
% yarn init

Durant la compilation Truffle génère des fichiers build qui se trouvent dans le dossier build/. Ce dossier doit être rajouté dans le fichier .gitignore du projet.
Suite à l'initialisation du projet Tuffle 3 dossiers et 1 fichier config sont génerés:

- contracts/: Dossier contenant les contrats solidity
- migrations/: Dossier pour les scripts de deploiement
- test/: Dossier pour les fichiers de test unitaires
- truffle-config.js: Truffle fichier de configuration

#### Répertoire Contracts/

Ce dossier contient les deux smart contracts Tourisme.sol et TourToken.sol. Il y a egalement un contrat Migrations.sol. ce contrat est crée lors de l' initialization du projet truffle est c'est un contrat de configuration qui fait un suive des deploiements (migrations) effectuées.

#### Répertoire Migrations/

Documentation officiel de Migrations: https://www.trufflesuite.com/docs/truffle/getting-started/running-migrations#migration-files

Ce répertoire contient les scripts de migrations. Pour executer une migration :

% truffle migrate --network NETWORK_NAME

Networks sonts configure dans le fichier truffle-config.js.

Une migration declenche deux processus:

1. Compilation.
   Chaque fois que les fichiers .sol sont modifiés, une compilation s"execute et un artifact pour chacun de contrats est génèré dans ./build/contracts. un artifact est un fichier de type .json comprenant un ABI, code de byte est des divers informations sur le contrat. laversion du compilateur et d'autres options sont definies dans truffle-config.js.
2. Deploiement.
   Les contracts sont deployés en fonction des instructions decrites dans les fichiers javascript du dossier migrations/.

Un script de migration 1_initial_migrations.js est créé ldans migrations/ lors de l'initialization du projet truffle. Pour deployer nos deux contrats, nous avons créé les fichiers: 2_deploy_tourisme.js et 3_deploy_TourToken.js. Vu que le deploiement du contrat Tourisme necessite l'adresse du TourToken passée en argument dans la fonction setTourToken, nous avons égaalement créé le script 4_FinalSetUp.js pour que cela se ne fasse pas à la main.

Pour deployer les deux contrats, nous avons du créer un compte chez Infura API ( https://infura.io/). Infura API permet d'avoir accèss aux HTTPS et WebSockets du reseau Ethereum. Avec Infura API notre Frontend, backend et Truffle peuvent se connecter au reseau Ethereum network au travers d' HTTPS.
Suite à la création d'un projet chez Infura, on récupere le Projet ID(identifient du projet) ainsi que l' api du projet. Nous integrons ces elements dans le fichier truffle-config.js.

#### Répertoire tests/

##### Installation des test helpers et de l'environment de tests de l'OpenZeppelin

% yarn add --dev @openzeppelin/test-helpers @openzeppelin/test-environment mocha chai

Pour executer des test en utlisant yarn test, on modifie le fichier package.json en y rajoutant:

"scripts": {
    "test": "npx mocha --exit --recursive"
},

#### Testnets

Il existe 4 testnets pour deployer les contrats.

1. Ropsten id: 3
2. Rinkeby id: 4
3. Kovan id: 42
4. Goerli id: 5

Nos contrats sont deployés sur le reseau Rinkeby.

##### Création d'un nouveau compte

Afin d'effectuer une trabsaction sur le reseau Ethereum, nous avons besoin d'un nouveau compte Ethereum. Pour cela nous allons utiliser le package mnemonics qui retourne un mnemonic (un ensemble de 12 mots):

% npx mnemonics

Pour acceder à notre mnemonic ainsi qu'à notre projet ID, on utilise une variable des variables d'environment, MNEMONIC et ENDPOINT_ID. On mets ces dernières dans le fichier .env au raccine de notre projet. Ce fichier doit être rajouté dans le .gitignore pour des raisons de sécurité.

Nous avons aussi installé dotenv qui est un module qui permet de charger des variables d'environment dde fichier .env au process.env.

##### Configuration de networks

Etant donné qu'on se sert des nodes publiques, il faudra signer toutes nos transactions de façon local. Pour cela, nous utiliseronsWe will use @truffle/hdwallet-provider qui est associé à notre mnemonic. Il faudra aussi diriger le fournisseur comment se connecter au testnet en au travers d' Infura endpoint.

##### Installation di hdwallet-provider

% yarn add --dev @truffle/hdwallet-provider

#### Financement de l'account utilisé pour le deploiment

Pour deployer sur un reseau publique, le compte du deployer account a besoin d' ethers. Afin de lier à notre mnemonic tous les accounts genéré il faut se connecter sur le truffle console:

% npx truffle console --network rinkeby

En suite on se sert de fonctions javascripts web3 pour afficher une liste de tous les accounts:

truffle(rinkeby)> await web3.eth.getAccounts()
[
'0x261B63E23eCAAc767Eb5d47F9Ee731651deF9c76',
'0x8730d2185956D592d197beEc482b4e6632B6f8f3',
'0xdfE3392BC894c22AE894577345D6E8B7E8F54774',
'0x8135ef013e6a77Bb434c5e2f69a47796e1206AE1',
'0x64d68464971126F06c0F0439E84C6c78c3d37e83',
'0xC353733996fd4EfECb07f88a7CFD69c05B7aa416',
'0x65BBDf74B9d20B2a3b75e2A2e9643b561b721B8C',
'0x6Bc4eBE7096AE84570EF47c6bC389eF8FF452e71',
'0x9Eeea75C80AaBfb98b9E97211bc6fF899f6c6Aaa',
'0xBD8e7Ad3FC2A6Bfcba664C78DE5DdAFda171e789'
]

le premier account, account[0], est l'account utilisé par default par truffle. Après avoir envoyé des ethers à cet account-là, on peut deployer nos contrats:

% truffle migrate --network rinkeby

Afin que le contrat TourToken puisse se deployer, il doit se register auprès d'un autre smart contract ERC1820 Registry, déjà deployé. Nous avons accès à un tel contrat au travers des test-helpers de l'OpenZeppelin fournissant des singletons, déjà preconfigurés. En passant comme default operator du contrat TourToken.sol le contrat de notre App (i.e. Tourisme.sol), ce dernièr aura droit par default d'avoir modifier les fonds d'un utilisateur.
