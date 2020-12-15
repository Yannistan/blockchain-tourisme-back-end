Pour assurer la sécurité de nos contrats et d'eviter que certaines fonctions soient utilisé par des personnes non-autorisée, nous utilisons quelques modifiers.

### Securité et optimization du contrat TourToken

Le contrat hérite d'un contrat Ownable de la librairie OpenZeppelin. Ainsi, on peut effectuer un transfer d'ownership et definir un owner autre que la personne dont l'adresse deploie le contrat.
Vu que la fonction mint() doit être utilisé que par l'agence, nous avons utilisé un modifier du contrat Ownable qui permet que à une adresse owner d'executer une fonction. Ainsi, seulemnt l'adresse de l'agence pourra minter un amount de token vers une adresse passé en argument.
Notre token est un token ERC777. Nous avons utilisé ce dernier contrat plutôt qu' un contrat ERC20 car chez ERC777 il n'a plus besoin d' utiliser la méthode approve pour qu'un utilisateur autorise un autre utilisateur ou un autre contrat de depenser ses tokens. Ceci est accompli par l'utilisation de la notion de "default operators". Ce dernier est une adresse autorisée d'envoyer et burn des tokens pour le compte de propriétaire de ces tokens.

### Securité et optimization du contrat Tourisme

Le contrat hérite d'un contrat Ownable de la librairie OpenZeppelin ce qui permet d'effectuer un transfer d'ownership au travers de la méthode transferOwnership du contrat Ownable.
Afin que la fonction register() ne soit pas executé par une adresse déjà enregistrée en tant que client, nous utilisons le modifier OnlyNotRegistered.
Pour que la fonctions buyTokens() et reserveByClient() s'utilisent que par un client, nous avons rajouté un modifier onlyClient.
Etant donnée que l'adresse du contrat TourToken et passée en argument dans la fonction setTourToken(), nous avons également rajouté un script 4_FinalSetUp.js dans le dossier migrations/ afin que cette operation se fasse automatiquement.
