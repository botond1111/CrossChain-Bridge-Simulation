# 🌉 Cross-Chain Token Bridge (Burn & Mint)

## 💡 Overview
This repository implements a **bidirectional token bridge simulation** using the "Burn-and-Mint" architecture. It demonstrates how assets can be moved between two independent blockchains (e.g., Ethereum -> Polygon) by destroying liquidity on the source chain and creating equivalent synthetic assets on the destination chain.

This project focuses on the **on-chain logic** required to support off-chain relayers (like Chainlink CCIP or LayerZero).

## 🛠 Architecture

### 1. Source Chain (`contracts/BridgeSource.sol`)
* Acts as the "Home" chain.
* **Mechanism:** When a user wants to bridge, tokens are **Burned** (removed from circulation permanently).
* **Event:** Emits `BridgeBurn`, acting as a signal/oracle for the off-chain infrastructure.

### 2. Destination Chain (`contracts/BridgeDestination.sol`)
* Acts as the "Remote" chain.
* **Mechanism:** Upon verifying the burn event, the contract **Mints** new wrapped tokens to the user.
* **Security:** Protected by `Ownable` (simulating a verified Relayer address) to prevent unauthorized minting.

## 🚀 Workflow Simulation

1.  **User** calls `bridgeToDestination(100)` on Source Chain.
    * *Result:* User balance -100, `BridgeBurn` event emitted.
2.  **Relayer (Bot)** detects the event and captures the data.
3.  **Relayer** calls `completeBridging(user, 100)` on Destination Chain.
    * *Result:* User receives +100 wrapped tokens on the new chain.

## ⚙️ Tech Stack
* **Language:** Solidity ^0.8.20
* **Pattern:** Burn-and-Mint / Lock-and-Unlock
* **Standard:** ERC-20, Ownable
