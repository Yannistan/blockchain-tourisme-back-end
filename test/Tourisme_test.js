/* eslint-disable no-unused-expressions */
const { contract, accounts } = require('@openzeppelin/test-environment');
const { BN, singletons } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

const Tourisme = contract.fromArtifact('Tourisme');
const TourToken = contract.fromArtifact('TourToken');

describe('Tourisme', function () {
  const NAME = 'Tour';
  const SYMBOL = 'TRM';
  const DECIMALS = 18;
  const INITIAL_SUPPLY = new BN('1000000' + '0'.repeat(DECIMALS));
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

  it('moves funds from user1 to user2', async function () {
    await this.app.reserveByAdmin(user1, user2, USER1_INITIAL_AMOUNT, { from: admin });
    expect(await this.tour.balanceOf(user1)).to.be.a.bignumber.equal(new BN(0));
    expect(await this.tour.balanceOf(user2)).to.be.a.bignumber.equal(USER1_INITIAL_AMOUNT);
  });

  // it('reverts if moveToByOwner is not called by admin', async function () {});
});
