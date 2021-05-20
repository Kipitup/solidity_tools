const { expect } = require("chai");

describe("Token contract", function() {
  it("Verify signature", async function() {
    const { utils } = ethers
    const [ owner ] = await ethers.getSigners();

    const Verifier = await ethers.getContractFactory("VerifySignature");

    const verifier = await Verifier.deploy();

    const to = "0xEF13aAC4dBCF336Ed855a0Ee4166117332501C75";
    const message = "Hello my friend";
    const amount = 42;
    const nonce = 1;

    // reproduce the abi.encodePacked function
    // you can use solidityKeccak256 directly if you want
    const messagePacked = utils.solidityPack(
      [ "address", "uint256", "string", "uint256" ], [ to, amount, message, nonce ]
    );

    const messageHash = utils.keccak256(messagePacked);

    // Due to js, messageHash is considered a string and signMessage will convert
    // it in his UTF8 representation. To prevent this we have to convert it in
    // an array
    const signature = await owner.signMessage(utils.arrayify(messageHash));

    const ret = await verifier.verify(owner.address, to, amount, message, nonce, signature);
    expect(ret).to.be.true

  });
});
