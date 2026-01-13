// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Bridge Source Token (Chain A)
/// @notice Represents the native token on the source chain that gets burned to bridge over.
contract BridgeSource is ERC20 {
    
    // Events for the off-chain Relayer to listen to
    event BridgeBurn(address indexed user, uint256 amount, uint256 timestamp);

    // Custom Errors
    error InsufficientBalance();

    constructor() ERC20("Ethereum Native Token", "ETH-T") {
        _mint(msg.sender, 10_000 * 10**18); // Initial supply for testing
    }

    /// @notice Burns tokens to initiate a cross-chain transfer.
    /// @dev Emits a BridgeBurn event which triggers the minting on the destination chain.
    /// @param amount The amount of tokens to send across the bridge.
    function bridgeToDestination(uint256 amount) external {
        if (balanceOf(msg.sender) < amount) revert InsufficientBalance();

        // 1. Burn the tokens (Remove from circulation on Chain A)
        _burn(msg.sender, amount);

        // 2. Emit event for the Relayer
        emit BridgeBurn(msg.sender, amount, block.timestamp);
    }
}
