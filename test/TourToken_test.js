/* eslint-disable no-unused-expressions */
const { contract, accounts } = require('@openzeppelin/test-environment');
const { BN, singletons } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

const TourToken = contract.fromArtifact('TourToken');


describe('TourToken', async function () {
  this.timeout(0);
  const NAME = 'Tour';
  const SYMBOL = 'TRM';
 
  const [owner, dev, registryFunder] = accounts;

  before(async function () {
    this.erc1820 = await singletons.ERC1820Registry(registryFunder);
  });

  beforeEach(async function () {
    this.tour = await TourToken.new( owner, [], { from: dev });
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

});
