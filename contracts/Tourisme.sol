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

address payable superAdmin;

uint256 counterClient;
uint256 counterOffer;
uint256 price;

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
     uint256 no_client;
 
}

struct Offer {
    uint id;
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
    _addrClient = msg.sender;
    counterClient++;
   // _clientIds.increment();
    //counterClient++;
    require (clients[_addrClient].isClient == false, 'only nonClients can use this function');
    uint newclientId = counterClient;
    clients[_addrClient] = Client(_nom, _email, _password, true, _age, 0, block.timestamp, newclientId);
} 

 function clientbyId() public view returns (uint256) {
        
        return counterClient;
    } 

function choose_offer(string memory _destination, bool _isTransport, bool _isSejour, bool _isRestauration, bool _isActivites, bool _isTours) public {
    counterOffer++;
    //_offerIds.increment();
    uint256 newofferId = counterOffer;
    if (_isTransport == true)
    offers[newofferId].priceinTokens += 50;
    if (_isSejour == true)
    offers[newofferId].priceinTokens += 100;
    if (_isRestauration == true)
    offers[newofferId].priceinTokens += 100;
    if (_isActivites == true)
    offers[newofferId].priceinTokens += 20;
    if (_isTours == true)
    offers[newofferId].priceinTokens += 10;
    uint totalPrice = offers[newofferId].priceinTokens;
    offers[newofferId] = Offer(newofferId, _destination, _isTransport, _isSejour, _isRestauration, _isActivites, _isTours, totalPrice);
    price = totalPrice;
}

 function getOffer(uint256 _id) public view returns (Offer memory) {
        return offers[_id];
    }
 
 
function reserveByAdmin (address src, address dst, uint256 amount) public onlyOwner {
   // amount = offers[_id].priceinTokens;
   require(amount == price, 'the function should transfer the amount corrsponding to the reservation price');
    _tour.operatorSend(src, dst, amount, "", "");
  }
  
}
