 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./TourToken.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Tourisme is ERC777, Ownable{
TourToken private _tour;


using Counters for Counters.Counter;
Counters.Counter private _clientIds;
 Counters.Counter private _offerIds;

address payable superAdmin;

//uint256 counterClient;
//uint256 counterOffer;
//uint256 price;

address payable _addrClient;
address payable _addrAgence;

 
mapping (address => Client) public clients;

mapping (uint256 => Offer) public offers;

mapping (address => uint256) public balances_client;

mapping (address => uint256) public balances_agence;

 constructor(
    transferOwnership(owner);
    
  ) 

function setTourToken(address tourAddress) external onlyOwner {
  _tour = TourToken(tourAddress),
}

function register(address _addrClient, string memory _nom, string memory _email, string memory _password, uint _age) public {
    _clientIds.increment();
    //counterClient++;
    require(!clients[_addrClient], "only non-clients can call this function not active any more");
    uint newclientId = _clientIds.current();
    clients[_addrClient] = Client(_nom, _email, _password, true, _age, 0, block.timestamp, newclientId);
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

 function getCurrentPrice() public view returns (uint256) {
    return _price;
  }


function choose_offer(string memory _destination, bool _isTransport, bool _isSejour, bool _isRestauration, bool _isActivites, bool _isTours) {
    //counterOffer++;
    _offerIds.increment();
    uint256 newofferId = _offerIds.current();
    if (_isTransport == true)
    offers[counterOffer].priceinTokens += 50;
    if (_isSejour == true)
    offers[counterOffer].priceinTokens += 100;
    if (_isRestauration == true)
    offers[counterOffer].priceinTokens += 100;
    if (_isActivites == true)
    offers[counterOffer].priceinTokens += 20;
    if (_isTours == true)
    offers[counterOffer].priceinTokens += 100;
    uint totalPrice = offers[counterOffer].priceinTokens;
    offers[_counterOffer] = Offer(counterOffer, _destination, _isTransport, _isSejour, isRestauration, _isActivites, _isTours, totalPrice);
}

 function getOffer(uint256 _id) public returns (Offer memory) {
        return offers[_id];
    }
 
 
function reserveByAdmin (address src, address dst, uint256 amount) public onlyOwner {
   // amount = offers[_id].priceinTokens;
    _tour.operatorSend(src, dst, amount, "", "");
  }
  
}
