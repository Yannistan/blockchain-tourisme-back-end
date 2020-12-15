/* eslint-disable no-unused-expressions */
const { contract, accounts } = require('@openzeppelin/test-environment');
const { BN, singletons } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');


const Tourisme = contract.fromArtifact('Tourisme');
const TourToken = contract.fromArtifact('TourToken');
const isSameClient = (_client, client) => {
  return  _client[0] === client.name && _client[1] === client.email;
};
describe('Tourisme', function () {
  this.timeout(0);
  const NAME = 'Tour';
  const SYMBOL = 'TRM';
  const USER1 = {
    name: 'Alice',
    email: 'alice@mail.com',
  };
  const USER2 = {
    name: 'Bob',
    email: 'bob@mail.com',
  };
  
  const EMAIL = 'pantz77@gmail.com';
  const DESTINATION = 'NewYork';
  const IS_TRANSPORT = true;
  const IS_SEJOUR = true;
  const IS_RESTAURATION = true;
  const IS_ACTIVITES = false;
  const IS_TOURS = false;
  const ID = new BN(1);
  const [owner, dev, admin, user1, user2, registryFunder] = accounts;

  before(async function () {
    this.erc1820 = await singletons.ERC1820Registry(registryFunder);
  });

  beforeEach(async function () {
    this.app = await Tourisme.new(admin, new BN('100000000000000000'), '0x57D8494097AD67A7E439807C03cd1A3E4d3d2a32', { from: dev });
    this.tour = await TourToken.new(owner, [this.app.address], { from: dev });
    await this.app.setTourToken(this.tour.address, { from: admin });
   
  });

  it('increments _clientIds by calling register()', async function () {
    await this.app.register(NAME, EMAIL);
    expect(await this.app.clientId()).to.be.a.bignumber.equal(new BN(1));
    
  });

 /* it('add and get client data', async function () {
    await this.app.register(NAME, EMAIL, { from: user1 });
    const client1 = await this.app.getClient(user1);
    console.log(client1);   
    expect(client1[0] == NAME).to.be.true;
    expect(client1[1] == EMAIL).to.be.true;
  }); */

  it('add and get client data', async function () {
    await this.app.register(USER1.name, USER1.email, { from: user1 });
    await this.app.register(USER2.name, USER2.email, { from: user2 });

    const _client1 = await this.app.getClient(user1);
    const _client2 = await this.app.getClient(user2);
    expect(isSameClient(_client1, USER1)).to.be.true;
    expect(isSameClient(_client2, USER2)).to.be.true;
  });

 
  it('add and get reservation data', async function () {
    await this.app.choose_offer(DESTINATION, IS_TRANSPORT, IS_SEJOUR, IS_RESTAURATION, IS_ACTIVITES, IS_TOURS);
    const result1 = await this.app.getOffer(new BN(1));
    console.log(result1);
    expect(result1[0] == DESTINATION).to.be.true;
    expect(result1[1]).to.be.a.bignumber.equal(new BN(200));
  
  });

});
