// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CrossChainToken.sol";

contract Bridge {
    CrossChainToken public token;
    mapping(bytes32 => bool) public processedTransactions;

    event TokenLocked(address indexed user, uint256 amount, bytes32 indexed transactionId);
    event TokenMinted(address indexed user, uint256 amount);
    event TokenUnlocked(address indexed user, uint256 amount, bytes32 indexed transactionId);

    constructor(CrossChainToken _token) {
        token = _token;
    }

    function lockTokens(uint256 amount) external {
        token.burn(msg.sender, amount);
        bytes32 transactionId = keccak256(abi.encodePacked(msg.sender, amount, block.timestamp));
        processedTransactions[transactionId] = true;
        emit TokenLocked(msg.sender, amount, transactionId);
    }

    function mintTokens(address to, uint256 amount, bytes32 transactionId) external {
        require(processedTransactions[transactionId], "Transaction not processed");
        token.mint(to, amount);
        emit TokenMinted(to, amount);
    }

    function unlockTokens(address to, uint256 amount, bytes32 transactionId) external {
        require(processedTransactions[transactionId], "Transaction not processed");
        token.mint(to, amount);
        emit TokenUnlocked(to, amount, transactionId);
    }

    function resetProcessedTransaction(bytes32 transactionId) external {
        processedTransactions[transactionId] = false;
    }

    // Cross-Chain Verification
    function verifyCrossChainTransaction(bytes32 transactionId) external view returns (bool) {
        return processedTransactions[transactionId];
    }
}
