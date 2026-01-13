// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Bridge Destination Token (Chain B)
/// @notice Represents the wrapped token on the destination chain.
/// @dev Tokens are minted only when a valid proof of burn is received from the Source Chain.
contract BridgeDestination is ERC20, Ownable {

    // Events
    event BridgeMint(address indexed user, uint256 amount, uint256 timestamp);

    constructor() ERC20("Polygon Wrapped Token", "POLY-T") Ownable(msg.sender) {}

    /// @notice Completes the bridging process by minting tokens.
    /// @dev In production, this would verify a cryptographic signature from the Relayer.
    /// @param _user The address receiving the tokens.
    /// @param _amount The amount to mint.
    function completeBridging(address _user, uint256 _amount) external onlyOwner {
        _mint(_user, _amount);
        emit BridgeMint(_user, _amount, block.timestamp);
    }
}
