# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.
```
CrossChainToken deployed to: 0xB576C4724FB60B17Aa898A620D1A868c69a0C8b5
Bridge deployed to: 0x010bf7E47001C70b5798c856750a970B09aC8575
```

## Configuration

To use the HolySky network, update your `hardhat.config.js` file with the HolySky RPC URL and your wallet's private key:

```javascript
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: "0.8.18",
  networks: {
    holysky: {
      url: "https://holysky-rpc-url", // Replace with your HolySky RPC URL
      accounts: ["0xYourPrivateKey"]   // Replace with your private key
    }
  }
};
```

### Deployment and Verification
Try running some of the following tasks:

```
npx hardhat node

npx hardhat run scripts/deploy.js --network holysky

```