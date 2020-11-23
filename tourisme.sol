 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./FirstErc20.sol";

contract Tourisme {
    
FirstErc20 public token;

address payable superAdmin;

uint256 counterClient;
uint256 counterOffer;
uint256 price;

address payable _addrClient;
address payable _addrAgence;

 
mapping (address => Client) public clients;

mapping (uint256 => Offer) public offers;

//mapping (address => mapping(uint256 => bool)) public jobs;

mapping (address => uint256) public balances_client;

mapping (address => uint256) public balances_agence;

 constructor(
    address erc20Address;
    
  ) public {
    _price = price;
    _seller = seller;
    token = FirstErc20(erc20Address);
    _decimal = (10**uint256(token.decimals()));
  }

// price = 0;

//mapping (address => bool) isClient;

function register(address _addrClient, string memory _nom, string memory _email, string memory _password, uint _age) public {
    counterClient++;
    require(!clients[_addrClient], "only non-clients can call this function not active any more");
  
     uint count = counterClient;
     clients[_addrClient] = Client(_nom, _email, _password, true, _age, 0, block.timestamp, count );
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
   // string mode_transport;
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
    counterOffer++;
    
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
 
  function getPricePerNbTokens(uint256 nbTokens) public view returns (uint256) {
    uint256 buyPrice = (nbTokens * _price) / _decimal;
    require(buyPrice > 0, 'Need a higher number of tokens');
    return buyPrice;
  }
 
 receive() external payable {
    reserve(msg.value);
  }


function reserve(uint256 _priceinTokens) public payable returns (bool) {
    // check if ether > 0
    require(msg.value > 0, 'ICO: purchase price can not be 0');
    // check if nbTokens > 0
    require(nbTokens > 0, 'ICO: Can not purchase 0 tokens');
    // check if enough ethers for nbTokens
    require(
      msg.value >= getPricePerNbTokens(nbTokens),
      'ICO: Not enough ethers for purchase'
    );
    uint256 _realPrice = getPricePerNbTokens(nbTokens);
    uint256 _remaining = msg.value - _realPrice;
    token.transferFrom(_seller, msg.sender, nbTokens);
    _seller.transfer(_realPrice);
    if (_remaining > 0) {
      msg.sender.transfer(_remaining);
    }
    return true;
  }
  
}
 

