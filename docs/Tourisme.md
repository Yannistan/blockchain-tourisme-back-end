## `Tourisme`

contract deployed at 0xff396842c25bD2Ac248A2c5BAa9192CDF840411a 
Un Client commence par se register. 


Tous les appels de fonction sont actuellement implémentés sans effets secondaires

### `onlyClient()`

ui vérifie que l'utilisateur est un Client.
modifier onlyClient



### `onlyNotRegistered()`

i vérifie que l'utilisateur n'est pas un Client.
modifier onlyNotRegis




### `constructor(address owner, uint256 _price, address payable _addrAgence)` (public)





### `setTourToken(address tourAddress)` (external)

v Seul l'owner peut éxecuter cette fonction.
On passe en argument l'addresse du contrat TourToken.
/
functio



### `register(string _name, string _email)` (public)

Seul un utilisateur non enregistré peut exécuter cette fonction.
Un utilisateur se register comme Client.




### `isRegistered(address _addr) → bool` (public)

e Vérifie si une addresse est déjà enregistrée.




### `clientId() → uint256` (public)

père l'id du dernier Client enregistré.
 function clientId



### `getClient(address _addr) → struct Tourisme.Client` (public)

ion des données d'un Client.




### `choose_offer(string _destination, bool _isSejour, bool _isTransport, bool _isRestauration, bool _isActivities, bool _isTours)` (public)

lient peut éxecuter cette fonction.
Un Client choisis les paramètres de son voyage.




### `getofferID() → uint256` (public)

d de la dernière Offer.
 function getofferID() public vie



### `getPrice(uint256 _id) → uint256` (public)

e locale de type Offer afin de récupérer le prix de la réservation.




### `getOffer(uint256 _id) → struct Tourisme.Offer` (public)

d'une Offer.




### `buyTokens(uint256 nbTokens) → bool` (public)

e fonction.
Achat de tokens TRM auprès de l'agence.




### `reserveByClient(uint256 _id)` (public)

fonction.
Paiement de la réservation par le Client et enregistrement de sa réservation.





