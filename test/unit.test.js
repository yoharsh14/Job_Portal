const { expect } = require("chai");
const { ethers, network } = require("hardhat");
const developmentChains = ["localhost", "hardhat"];
!developmentChains.includes(network.name)
  ? describe.skip()
  : describe("JobPortal", async () => {
      let contarct, deployer, applicant, jobProvider;
      beforeEach(async () => {
        const signer = await ethers.getSigners();
        deployer = signer[0];
        applicant = signer[1];
        jobProvider = signer[2];
        contract = await ethers.getContractFactory("JobPortal");
        contarct = await contract.deploy();
      });
      describe("Constructor", async () => {
        it("Owner is set properly", async () => {
          await expect(deployer.address).to.equal(await contarct.i_owner());
        });
      });
      describe("add Applicant function", async () => {
        const id = 123;
        const name = "harsh";
        const exp = 12;
        const skills = "blockchain";
        let txn;
        beforeEach(async () => {
          txn = await contract.connect(deployer).addApplicant(id, name, exp, skills);
          await txn.wait(1);
        });
        it("Applicant details added to the function", async () => {
          const info = await contract.applicants(id);
          expect(info.name).to.equal(name);
        });
      });
    });
