## `TourToken`

/** 
Un token qui prend en paramètre un _owner et un defaultOperators.


Tous les appels de fonction sont actuellement implémentés sans effets secondaires.
/
con


### `constructor(address owner_, address[] defaultOperators)` (public)





### `mint(address account, uint256 amount) → bool` (public)

L'owner mint un amount à un account.


Seul le owner (addresse de l'agence) peut exécuter cette fonction.



