/*modifier onlyClient (){
            require (clients[msg.sender].isClient == true, "only a client can call this function");
            _;
        } */

/*function login(string memory _email, string memory _password) public onlyClient returns (bool) {
    require(keccak256(bytes(_email)) == keccak256(bytes(clients[msg.sender].email)) &&  keccak256(bytes(_password)) == keccak256(bytes(clients[msg.sender].password)), "a client should provide the correct email and password used for his registration.");
    return true;
} */