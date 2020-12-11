const ether = require("@openzeppelin/test-helpers/src/ether");
const { BN } = require('@openzeppelin/test-helpers');
const Tourisme = artifacts.require('Tourisme');


module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(Tourisme, accounts[0], new BN('100000000000000000'), '0x57D8494097AD67A7E439807C03cd1A3E4d3d2a32', { from: accounts[0] });
};
