  // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./TourToken.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// contract deployed at 0xff396842c25bD2Ac248A2c5BAa9192CDF840411a 
/// @title Un smart contract qui permet à des utilisateurs de réserver des voyages.
/// @notice Un Client commence par se register. 
/// @dev Tous les appels de fonction sont actuellement implémentés sans effets secondaires
    contract Tourisme is Ownable {
// Variables d'état
/// @dev Intégration des fonctions du contrat TourToken dans Tourisme.
    TourToken private _tour;

/// @dev Utilisation de la librairie Counters pour les incrémentations.
using Counters for Counters.Counter;
Counters.Counter private _clientIds;
Counters.Counter private _offerIds;
/// @dev prix d'un TRM.
uint256 price_token;
uint256 totalprice;

address _addrClient;
/// @dev address de l'agence.
address payable addrAgence;

/// @dev mapping d'une addresse vers un Client.
mapping (address => Client) public clients;

/// @dev mapping d'un uint vers une Offer.
mapping (uint256 => Offer) public offers;

// Constructeur
  /// @param owner : l'owner du contract.
  /// @param _price : prix d'un TRMen wei.
  /// @param _addrAgence : addresse de l'agence
 constructor(address owner, uint256 _price, address payable _addrAgence) public {
  /// @dev fonction du contrat Ownable qui execute un transfert d'ownership
  /// @param owner : address de l'owner.
    transferOwnership(owner);
    price_token = _price;
    addrAgence = _addrAgence;
 }

 /// @dev Seul l'owner peut éxecuter cette fonction.
 /// @notice On passe en argument l'addresse du contrat TourToken.
function setTourToken(address tourAddress) external onlyOwner {
  _tour = TourToken(tourAddress);
}

/// @dev srtuct Client
struct Client {
    string name;
    string email;
    uint256 no_reservation;
    uint256 date_registration;
 
}
/// @dev struct Offer
struct Offer {
    
    string destination;
   uint256 priceinTokens;
}

/// @dev Seul un utilisateur non enregistré peut exécuter cette fonction.
/// @notice Un utilisateur se register comme Client.
/// @param _name : nom du client.
/// @param _email : email du client.
function register(string memory _name, string memory _email) onlyNotRegistered public {
  
    _clientIds.increment();
    clients[msg.sender] = Client(_name, _email, 0, block.timestamp);
} 

/// @notice Vérifie si une addresse est déjà enregistrée.
/// @param _addr : addresse à vérifier.
function isRegistered(address _addr) public view returns (bool) {
    return clients[_addr].date_registration != 0;
}

/// @notice Récupère l'id du dernier Client enregistré.
 function clientId() public view returns (uint256) {
        
        return _clientIds.current();
    } 

/// @dev modifier qui vérifie que l'utilisateur est un Client.
modifier onlyClient (){
            require (clients[msg.sender].date_registration != 0, "only a client can call this function");
            _;
        } 

/// @dev mofifier qui vérifie que l'utilisateur n'est pas un Client.
modifier onlyNotRegistered (){
            require (clients[msg.sender].date_registration == 0, "only a non-client can call this function");
            _;
        }

/// @notice Récupération des données d'un Client.
/// @param _addr : addresse du Client.
function getClient(address _addr) public view returns (Client memory) {
        return clients[_addr];
    }
 
/// @dev Seul un Client peut éxecuter cette fonction.
/// @notice Un Client choisis les paramètres de son voyage.
/// @param _destination : destination demandée.
/// @param _isSejour : validation d'un séjour.
/// @param _isTransport : validation des billets de transports.
/// @param _isRestauration : validation de la prise en charge de la restauraton.
/// @param _isActivities : validation d'un supplément d'activités.
/// @param _isTours : validation d'un tour guidé.
function choose_offer(string memory _destination, bool _isSejour, bool _isTransport, bool _isRestauration, bool _isActivities, bool _isTours) public {
    _offerIds.increment();
    // Variables locales
    uint256 newofferId = _offerIds.current();
    uint price;
    uint PRICE_SEJOUR;
    uint PRICE_TRANSPORT;
    uint PRICE_RESTAURATION;
    uint PRICE_ACTIVITIES;
    uint PRICE_TOURS;

    // Voyage vers New-York
    if (keccak256(bytes(_destination)) == keccak256(bytes("NewYork"))) {
        if (_isSejour == true) {
        PRICE_SEJOUR = 100;
        price +=100;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 50;
        price +=50;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 50;
        price +=50;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 50;
        price +=50;
        }
        if (_isTours == true) {
        PRICE_TOURS = 50;
        price  += 50;
        }
    }
     // Voyage vers les Maldives
    else if (keccak256(bytes(_destination)) == keccak256(bytes("Maldives"))) {
         if (_isSejour == true) {
        PRICE_SEJOUR = 150;
        price +=150;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 30;
        price +=30;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 50;
        price +=50;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 20;
        price +=20;
        }
        if (_isTours == true) {
        PRICE_TOURS = 50;
        price  += 50;
        }
    }
    // Voyage vers Vancouver
    else if (keccak256(bytes(_destination)) == keccak256(bytes("Vancouver"))) {
        if (_isSejour == true) {
        PRICE_SEJOUR = 80;
        price +=80;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 40;
        price +=40;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 40;
        price += 40;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 30;
        price +=30;
        }
        if (_isTours == true) {
        PRICE_TOURS = 30;
        price  += 30;
        }
    }
    // Voyage vers Barcelone
    else if(keccak256(bytes(_destination)) == keccak256(bytes("Barcelona"))) {
      if (_isSejour == true) {
        PRICE_SEJOUR = 50;
        price +=50;
        }
        if (_isTransport == true) {
        PRICE_TRANSPORT = 30;
        price +=30;
        }
        if (_isRestauration == true) {
        PRICE_RESTAURATION = 30;
        price += 30;
        }
        if (_isActivities == true) {
        PRICE_ACTIVITIES = 20;
        price +=20;
        }
        if (_isTours == true) {
        PRICE_TOURS = 50;
        price  += 50;
        }
    }
    else revert("Invalid destination");
  
    offers[newofferId] = Offer(_destination, price);
    price = 0;
}

/// @notice Récupération de l'id de la dernière Offer.
function getofferID() public view returns (uint256) {
  
    return _offerIds.current();
  
}

 /// @dev Déclaration d'une variable locale de type Offer afin de récupérer le prix de la réservation.
 /// @param _id : id de l'Offer.
function getPrice(uint256 _id) public view returns(uint256) {
    Offer memory c = offers[_id];
    return (c.priceinTokens);
}


/// @notice Récupération des éléments d'une Offer.
/// @param _id : id de l'Offer.
function getOffer(uint256 _id) public view returns (Offer memory) {
        return offers[_id];
    } 
 

/// @dev Seul un Client peut éxecuter cette fonction.
/// @notice Achat de tokens TRM auprès de l'agence.
/// @param nbTokens : nombre de tokens que le Client souhaite acheter.
function buyTokens(uint256 nbTokens) public payable onlyClient returns (bool) {
        
        require(msg.value > 0, " minimum 1 wei");
    
        require(
            (nbTokens * price_token) <= msg.value,
            "Not enough Ether to purchase this number of tokens"
        );
        uint256 realPrice = (nbTokens * price_token);
        uint256 remain = msg.value - realPrice;
        /// @dev Utilisation de la fonction transfert de l'ERC777.
        addrAgence.transfer(realPrice);
        _tour.operatorSend(addrAgence, msg.sender, nbTokens, "", "");
        if (remain > 0) {
            /// @dev Utilisation de la fonction transfert de l'ERC777.
            msg.sender.transfer(remain);
        }
        return true;
    }
 
 /// @dev Seul un Client peut exécuter cette fonction.
 /// @notice Paiement de la réservation par le Client et enregistrement de sa réservation.
 /// @param _id : id de l'Offer. 
function reserveByClient(uint _id) public onlyClient {
   /// @dev Utilisation de la fonction operatorSend par le contrat TourToken
    _tour.operatorSend(msg.sender, addrAgence, offers[_id].priceinTokens, "", "");
    clients[msg.sender].no_reservation = clients[msg.sender].date_registration;
  }
  
}