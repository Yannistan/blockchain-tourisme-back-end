 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./TourToken.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Tourisme is Ownable{
TourToken private _tour;


using Counters for Counters.Counter;
Counters.Counter private _clientIds;
Counters.Counter private _offerIds;

address payable _agence;

uint256 counterClient;
uint256 counterOffer;
//uint256 price;

address _addrClient;
//address payable _addrAgence;

 
mapping (address => Client) public clients;

mapping (uint256 => Offer) public offers;

mapping (address => uint256) public balances_client;

mapping (address => uint256) public balances_agence;

 constructor(address owner) public {
    transferOwnership(owner);
    
 }

function setTourToken(address tourAddress) external onlyOwner {
  _tour = TourToken(tourAddress);
}

/* Variables d'état */
struct Client {
     string nom;
     string email;
     string password;
     bool isClient;
     uint256 age;
     uint256 no_reservation;
     uint date_registration;
 
}

struct Offer {
    
    string destination;
    bool isTransport;
    bool isSejour;
    bool isRestauration;
    bool isActivites;
    bool isTours;
   uint256 priceinTokens;
}

/* function getCurrentPrice() public view returns (uint256) {
    return _price;
  } */

function register(string memory _nom, string memory _email, string memory _password, uint _age) public {
    _addrClient = 0x44F31c324702C418d3486174d2A200Df1b345376;
   // counterClient++;
    _clientIds.increment();
    //counterClient++;
    require (clients[msg.sender].isClient == false, 'only nonClients can use this function');
    uint newclientId = _clientIds.current();
    clients[_addrClient] = Client(_nom, _email, _password, true, _age, 0, block.timestamp);
} 

 function clientId() public view returns (uint256) {
        
        return _clientIds.current();
    } 

function getClient(address _addr) public view returns (Client memory) {
        return clients[_addr];
    }
 

function choose_offer(string memory _destination, bool _isTransport, bool _isSejour, bool _isRestauration, bool _isActivites, bool _isTours) public {
    //counterOffer++;
    _offerIds.increment();
    uint256 newofferId = _offerIds.current();
    uint price;
    if (_isTransport == true) {
    uint PRICE_TRANSPORT = 50;
    price += PRICE_TRANSPORT;
    }
    if (_isSejour == true) {
    uint PRICE_SEJOUR = 100;
    price += PRICE_SEJOUR;
    }
    if (_isRestauration == true) {
    uint PRICE_RESTAURATION = 50;
    price += PRICE_RESTAURATION;
    }
    if (_isActivites == true) {
    uint PRICE_ACTIVITIES = 50;
    price += PRICE_ACTIVITIES;
    }
    if (_isTours == true) {
    uint PRICE_TOURS = 50;
    price += PRICE_TOURS;
    }
   // uint totalPrice = offers[newofferId].priceinTokens;
    offers[newofferId] = Offer(_destination, _isTransport, _isSejour, _isRestauration, _isActivites, _isTours, price);
}

 function getOffer(uint256 _id) public view returns (Offer memory) {
        return offers[_id];
    }
 
 
function reserveByClient (uint256 _id, address dst) public {

    _tour.operatorSend(msg.sender, dst, offers[_id].priceinTokens, "", "");
    clients[msg.sender].no_reservation = _id + clients[msg.sender].date_registration;
  }
  
}
