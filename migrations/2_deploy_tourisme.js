const Tourisme = artifacts.require('Tourisme');


module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(Tourisme, accounts[0], { from: accounts[0] });
};
