/* eslint-disable no-unused-expressions */
const { contract, accounts } = require('@openzeppelin/test-environment');
const { BN, singletons } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

const Tourisme = contract.fromArtifact('Tourisme');
const TourToken = contract.fromArtifact('TourToken');

describe('Tourisme', function () {
  this.timeout(0);
  const NAME = 'Tour';
  const SYMBOL = 'TRM';
  const DECIMALS = 18;
  const INITIAL_SUPPLY = new BN('1000000' + '0'.repeat(DECIMALS));
  //const PRICE = new BN('500' + '0'.repeat(DECIMALS));
  const _NUM = new BN(1);
  const NOM = 'Yannis';
  const EMAIL = 'pantz77@gmail.com';
  const PASSWORD = 'ldldldl77';
  const ADDR = '0x44F31c324702C418d3486174d2A200Df1b345376';
  const DESTINATION = 'Paris';
  const IS_TRANSPORT = true;
  const IS_SEJOUR = true;
  const IS_RESTAURATION = true;
  const IS_ACTIVITES = false;
  const IS_TOURS = false;
  const [owner, dev, admin, user1, user2, registryFunder] = accounts;
  const USER1_INITIAL_AMOUNT = new BN('10000' + '0'.repeat(DECIMALS));

  before(async function () {
    this.erc1820 = await singletons.ERC1820Registry(registryFunder);
  });

  beforeEach(async function () {
    this.app = await Tourisme.new(admin, { from: dev });
    this.tour = await TourToken.new(owner, INITIAL_SUPPLY, [this.app.address], { from: dev });
    await this.app.setTourToken(this.tour.address, { from: admin });
    await this.tour.transfer(user1, USER1_INITIAL_AMOUNT, { from: owner });
  });

  it('increments _clientIds by calling register()', async function () {
    await this.app.register(NOM, EMAIL, PASSWORD);
    expect(await this.app.clientId()).to.be.a.bignumber.equal(new BN(1));
    /* await this.gameloot.loot(user1, loot2, { from: owner });
    expect(await this.gameloot.tokenOfOwnerByIndex(user1, new BN(1)), 'id should be 2').to.be.bignumber.equal(
      new BN(2),
    );*/
  });

  it('add and get client data', async function () {
    await this.app.register(NOM, EMAIL, PASSWORD, { from: dev });
    const client1 = await this.app.getClient(ADDR);
    console.log(client1);
    expect(client1[0] == NOM).to.be.true;
    expect(client1[1] == EMAIL).to.be.true;
    expect(client1[2] == PASSWORD).to.be.true;
  });

  it('add and get reservation data', async function () {
    await this.app.choose_offer(DESTINATION, IS_TRANSPORT, IS_SEJOUR, IS_RESTAURATION, IS_ACTIVITES, IS_TOURS);
    const result1 = await this.app.getOffer(_NUM);
    console.log(result1);
    expect(result1[0] == DESTINATION).to.be.true;
    expect(result1[1] == IS_TRANSPORT).to.be.true;
    expect(result1[2] == IS_SEJOUR).to.be.true;
    expect(result1[3] == IS_RESTAURATION).to.be.true;
    expect(result1[4] == IS_ACTIVITES).to.be.true;
    expect(result1[5] == IS_TOURS).to.be.true;
  });

  it('moves funds from client to agency', async function () {
    this.timeout(0);
    await this.app.reserveByClient(ID, user2, { from: admin });
    expect(await this.tour.balanceOf(user1)).to.be.a.bignumber.equal(new BN(0));
    expect(await this.tour.balanceOf(user2)).to.be.a.bignumber.equal(USER1_INITIAL_AMOUNT);
  });

  // it('reverts if moveToByOwner is not called by admin', async function () {});
});
