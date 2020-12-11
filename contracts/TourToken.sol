// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC777/ERC777.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TourToken is ERC777, Ownable {
    constructor(
       
        address owner_,
       // uint256 initialSupply,
       
        address[] memory defaultOperators
       
    ) public ERC777("Tour", "TRM", defaultOperators) {
     // ) public ERC777("Tour", "TRM",  new address[](0)) {
        transferOwnership(owner_);
        _mint(msg.sender, 1000000, "", "");
    }

    function mint(address account, uint256 amount) public onlyOwner returns (bool) {
        _mint(account, amount, "", "");
        return true;
    }
}
