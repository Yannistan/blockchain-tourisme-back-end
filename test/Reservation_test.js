/* eslint-disable no-unused-expressions */
/*const { accounts, contract } = require('@openzeppelin/test-environment');

const { BN, expectRevert, time } = require('@openzeppelin/test-helpers');

const { expect } = require('chai');

const Tourisme = contract.fromArtifact('Tourisme');

describe('Tourisme', async function () {
  const [dev, owner, user1] = accounts;
  const _NO_DAYS = new BN(10);
  const _NUM = new BN(1);
  const _TRANSPORT = 'AVION';
  const _RESTINCLUS = true;

  context('Tourisme initial state', function () {
    this.timeout(0);
    // Execute this before each test
    beforeEach(async function () {
      this.reservation = await Reservation.new(owner, { from: dev });
    });

    it('add reservation data', async function () {
      await this.reservation.addReservation(_NO_DAYS, _TRANSPORT, _RESTINCLUS, { from: owner });
      const result1 = await this.reservation.getReservation(_NUM);
      console.log(result1);
      // expect(await this.formation.getMessage()).to.equal(_MESSAGE);
    });

    it('has owner', async function () {
      expect(await this.reservation.owner()).to.equal(owner);
    });
  });
});

 test à adapter à la version la plus recente du contrat Tourisme */
