// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC777/ERC777.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TourToken is ERC777, Ownable {
    constructor(
       // string memory name,
     //   string memory symbol,
      //  address owner_
       
        address[] memory defaultOperators
       
    ) public ERC777("Tour", "TRM", defaultOperators) {
     // ) public ERC777("Tour", "TRM",  new address[](0)) {
       // transferOwnership(owner_);
        _mint(msg.sender, 10000*10**18, "", "");
    }

    function mint(address account, uint256 amount) public {
        _mint(account, amount, "", "");
    }
}
