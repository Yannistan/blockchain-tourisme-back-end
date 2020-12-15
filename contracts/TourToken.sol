// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC777/ERC777.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// contract deployed at 0xe7c00B5094790CD0e8ea41b82Dd4129d6f9248e8


 /// @title Création d'un token ERC77 ('TRM')
 /// @notice Un token qui prend en paramètre un _owner et un defaultOperators.
 /// @dev Tous les appels de fonction sont actuellement implémentés sans effets secondaires.
 
contract TourToken is ERC777, Ownable {
    /// @param owner_ address de l'owner
    /// @param defaultOperators address du contrat Tourisme
    constructor(
        address owner_,
        address[] memory defaultOperators
     ) public ERC777("Tour", "TRM", defaultOperators) {
        transferOwnership(owner_);
      //  _mint(msg.sender, 1000000, "", "");
     }

    /// @dev Seul le owner (addresse de l'agence) peut exécuter cette fonction.
    /// @notice L'owner mint un amount à un account.
    /// @param account : Addresse du destinataire.
    /// @param amount : Nombre de tokens mintés.
    function mint(address account, uint256 amount) public onlyOwner returns (bool) {
        _mint(account, amount, "", "");
        return true;
    }
}
