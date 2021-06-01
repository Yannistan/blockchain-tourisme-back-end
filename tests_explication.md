**Tests unitaires**

### Contrat TourToken.sol

Nous avons créé trois test unitaires pour le smart contract TourToken.sol.

1. 'has name'
   Verification que le TourToken a un nom.

2. 'has symbol'
   Verification que le token a un symbol.

3. 'has no default operators'
   Verification que le token n'a pas de default operators. Comme il est marqué sur le fichier Readme.md, en verité ce contrat se deploie avec un default operator qui est le contrat de notre App, Tourisme.sol.

### Contrat Tourisme.sol

Nus avons également créé trois tests unitaires pour le contrat Tourisme.sol.

1. 'increments clientIds by calling register()'
   Verification que l'ID d'un nouveau client est bien incrementé par la librairie Counters.
2. 'add and get client data'
   Verification que les données d'un clinet sont bien enregistrées.
3. 'add and get reservation data'
   Verification que les elements d'une reservation sont bien enregistrés.
