// scripts/deploy.js
const hre = require("hardhat");

async function main() {
    // Deploy the CrossChainToken contract
    const Token = await hre.ethers.getContractFactory("CrossChainToken");
    const token = await Token.deploy("My Cross Chain Token", "MCCT", 18);
    await token.deployed();
    console.log("CrossChainToken deployed to:", token.address);

    // Deploy the Bridge contract with the token address
    const Bridge = await hre.ethers.getContractFactory("Bridge");
    const bridge = await Bridge.deploy(token.address);
    await bridge.deployed();
    console.log("Bridge deployed to:", bridge.address);

    // Set the bridge address in the token contract
    const setBridgeTx = await token.setBridge(bridge.address);
    await setBridgeTx.wait();
    console.log("Bridge address set in the token contract.");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

// CrossChainToken deployed to: 0xB576C4724FB60B17Aa898A620D1A868c69a0C8b5
// Bridge deployed to: 0x010bf7E47001C70b5798c856750a970B09aC8575