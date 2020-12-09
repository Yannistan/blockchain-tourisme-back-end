
const Tourisme = artifacts.require('Tourisme');
const TourToken = artifacts.require('TourToken');

require('@openzeppelin/test-helpers/configure')({ provider: web3.currentProvider, environment: 'truffle' });

const { singletons } = require('@openzeppelin/test-helpers');

module.exports = async function (deployer, network, accounts) {
    if (network === 'development') {
        // In a test environment an ERC777 token requires deploying an ERC1820 registry
        await singletons.ERC1820Registry(accounts[0]);
      }
     const tourisme = await Tourisme.deployed();
     await deployer.deploy(TourToken, [tourisme.address]);
 
};