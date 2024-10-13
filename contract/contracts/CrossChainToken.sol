// contracts/CrossChainToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrossChainToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    address public bridge; // Store the bridge address

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = 0; // Initial supply is zero
    }

    modifier onlyBridge() {
        require(msg.sender == bridge, "Not the bridge");
        _;
    }

    // Add this function to set the bridge address
    function setBridge(address _bridge) external {
        bridge = _bridge;
    }

    function mint(address to, uint256 amount) external onlyBridge {
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function burn(address from, uint256 amount) external onlyBridge {
        require(balanceOf[from] >= amount, "Insufficient balance");
        totalSupply -= amount;
        balanceOf[from] -= amount;
        emit Transfer(from, address(0), amount);
    }
}
