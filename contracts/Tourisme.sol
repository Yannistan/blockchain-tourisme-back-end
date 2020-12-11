  // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./TourToken.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Tourisme is Ownable {
TourToken private _tour;


using Counters for Counters.Counter;
Counters.Counter private _clientIds;
Counters.Counter private _offerIds;

address payable _agence;
uint256 price_token;
uint256 counterClient;
uint256 counterOffer;
uint256 totalprice;

address _addrClient;
address payable addrAgence;
//bool isRegistered;

mapping (address => Client) public clients;

mapping (uint256 => Offer) public offers;

 constructor(address owner, uint256 _price, address payable _addrAgence) public {
    transferOwnership(owner);
    price_token = _price;
    addrAgence = _addrAgence;
 }

function setTourToken(address tourAddress) external onlyOwner {
  _tour = TourToken(tourAddress);
}

/* Variables d'état */
struct Client {
    string name;
    string email;
    uint256 no_reservation;
    uint256 date_registration;
 
}

struct Offer {
    
    string destination;
   uint256 priceinTokens;
}

function register(string memory _name, string memory _email) onlyNotRegistered public {
   // _addrClient = 0x44F31c324702C418d3486174d2A200Df1b345376;
  
    _clientIds.increment();
    //counterClient++;
   
    clients[msg.sender] = Client(_name, _email, 0, block.timestamp);
   
} 

function isRegistered(address _addr) public view returns (bool) {
    return clients[_addr].date_registration != 0;
}

 function clientId() public view returns (uint256) {
        
        return _clientIds.current();
    } 

modifier onlyClient (){
            require (clients[msg.sender].date_registration != 0, "only a client can call this function");
            _;
        } 

modifier onlyNotRegistered (){
            require (clients[msg.sender].date_registration == 0, "only a non-client can call this function");
            _;
        }

function getClient(address _addr) public view returns (Client memory) {
        return clients[_addr];
    }
 
 function choose_offer(string memory _destination, bool _isSejour, bool _isTransport, bool _isRestauration, bool _isActivities, bool _isTours) public {
    counterOffer++;

    //_offerIds.increment();
    uint256 newofferId = counterOffer;
    uint price;
    uint PRICE_SEJOUR;
    uint PRICE_TRANSPORT;
    uint PRICE_RESTAURATION;
    uint PRICE_ACTIVITIES;
    uint PRICE_TOURS;
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
}

 function getofferID() public view returns (uint256) {
  
    return counterOffer;
  
}

function getPrice(uint256 _id) public view returns(uint256) {
    Offer memory c = offers[_id];
    return (c.priceinTokens);
}

function getOffer(uint256 _id) public view returns (Offer memory) {
        return offers[_id];
    } 
 

function buyTokens(uint256 nbTokens) public payable returns (bool) {
        
        require(msg.value > 0, " minimum 1 wei");
    
        require(
            (nbTokens * price_token) <= msg.value,
            "Not enough Ether to purchase this number of tokens"
        );
        uint256 realPrice = (nbTokens * price_token);
        uint256 remain = msg.value - realPrice;
        addrAgence.transfer(realPrice);
        _tour.operatorSend(addrAgence, msg.sender, nbTokens, "", "");
        if (remain > 0) {
            msg.sender.transfer(remain);
        }
        return true;
    }
 
function reserveByClient(uint _id) public {
   
    _tour.operatorSend(msg.sender, addrAgence, offers[_id].priceinTokens, "", "");
    clients[msg.sender].no_reservation = clients[msg.sender].date_registration;
  }
  
}