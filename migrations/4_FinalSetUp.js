const Tourisme = artifacts.require('Tourisme');

const TourToken = artifacts.require('TourToken');

module.exports = async function (deployer, network, accounts) {
    const tourisme = await Tourisme.deployed();
    const tourToken = await TourToken.deployed();
    await tourisme.setTourToken(tourToken.address, { from: accounts[0]});
}