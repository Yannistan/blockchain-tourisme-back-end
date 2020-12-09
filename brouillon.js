/*modifier onlyClient (){
            require (clients[msg.sender].isClient == true, "only a client can call this function");
            _;
        } */

/*function login(string memory _email, string memory _password) public onlyClient returns (bool) {
    require(keccak256(bytes(_email)) == keccak256(bytes(clients[msg.sender].email)) &&  keccak256(bytes(_password)) == keccak256(bytes(clients[msg.sender].password)), "a client should provide the correct email and password used for his registration.");
    return true;
} */

function buyTokens(uint256 nbTokens) public payable returns (bool) {
        /// @dev checks if msg.value is more than 0
        require(msg.value > 0, " minimum 1 wei");
        /// @dev checks if minimum 100 units of token are bought since 1 wei = 100 units
        require(nbTokens >= (DENOMINATION / _price), " tokens");
        /// @dev checks if enough ether is set as value to buy requested nbTokens
        require(
            (nbTokens * _price) / DENOMINATION <= msg.value,
            "Government: not enough Ether to purchase this number of tokens"
        );
        uint256 _realPrice = (nbTokens * _price) / DENOMINATION;
        uint256 _remaining = msg.value - _realPrice;
        _sovereign.transfer(_realPrice);
        _token.operatorSend(_sovereign, msg.sender, nbTokens, "", "");
        if (_remaining > 0) {
            msg.sender.transfer(_remaining);
        }
        return true;
    }
