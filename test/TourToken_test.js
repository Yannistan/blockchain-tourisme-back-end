/* eslint-disable no-unused-expressions */
const { contract, accounts } = require('@openzeppelin/test-environment');
const { BN, singletons } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

const TourToken = contract.fromArtifact('TourToken');

describe('Tour', async function () {
  const NAME = 'Tour';
  const SYMBOL = 'TRM';
  const DECIMALS = 18;
  const INITIAL_SUPPLY = new BN('1000000' + '0'.repeat(DECIMALS));
  const [owner, dev, registryFunder] = accounts;

  before(async function () {
    this.erc1820 = await singletons.ERC1820Registry(registryFunder);
  });

  beforeEach(async function () {
    this.tour = await TourToken.new(owner, INITIAL_SUPPLY, [], { from: dev });
  });

  it('has name', async function () {
    expect(await this.tour.name()).to.equal(NAME);
  });

  it('has symbol', async function () {
    expect(await this.tour.symbol()).to.equal(SYMBOL);
  });

  it('has no default operators', async function () {
    expect(await this.tour.defaultOperators()).to.be.empty;
  });

  it('transfers ownership from msg.sender to owner', async function () {
    expect(await this.tour.owner()).to.equal(owner);
  });

  it('mints initial supply to owner', async function () {
    expect(await this.gold.balanceOf(owner)).to.be.a.bignumber.equal(INITIAL_SUPPLY);
  });
});
