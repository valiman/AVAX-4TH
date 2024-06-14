# DegenToken

DegenToken is an ERC20 token with additional functionalities for minting, transferring, burning, and redeeming tokens for items. The token includes an ownership model and provides an interface to view store items and owned items.

## Table of Contents

1. [Features](#features)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Contract Methods](#contract-methods)

## Features

- ERC20 Token implementation
- Ownership model using OpenZeppelin's Ownable contract
- Minting tokens
- Transferring tokens
- Burning tokens
- Redeeming tokens for specific items
- Viewing available store items
- Viewing items owned by an account

## Installation

1. Ensure you have [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed.
2. Install Truffle or Hardhat for managing smart contract deployment and testing.
3. Install dependencies:

```sh
npm install @openzeppelin/contracts
```

4. Deploy the contract using your preferred Ethereum development environment.

## Usage

### Deployment

Deploy the contract to your desired Ethereum network. The constructor requires an initial owner address:

```solidity
constructor(address initialOwner)
```

### Interacting with the Contract

Use the provided methods to interact with the DegenToken contract.

## Contract Methods

### Minting Tokens

Allows the owner to mint new tokens.

```solidity
function mint(address to, uint256 amount) external onlyOwner
```

### Transferring Tokens

Transfer tokens from the sender to a recipient.

```solidity
function transferTokens(address recipient, uint256 amount) external
```

### Redeeming Tokens

Redeem tokens for items in the store. The tokens are burned in exchange for the items.

```solidity
function redeemTokens(ItemType itemType, uint256 quantity) external
```

### Burning Tokens

Burn a specified amount of tokens from the sender's account.

```solidity
function burnTokens(uint256 amount) external
```

### Viewing Store Items

View the quantities of items available in the store.

```solidity
function viewInStoreItems() external view returns (string memory output)
```

### Viewing Owned Items

View the items owned by a specific account.

```solidity
function viewOwnedItems(address account) external view returns (string memory output)
```
