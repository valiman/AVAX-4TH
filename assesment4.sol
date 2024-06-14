// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    enum ItemType { Ring, Spikes, Trousers }

    mapping(ItemType => uint256) public itemPrices;

    mapping(ItemType => uint256) public itemQuantities;

    mapping(address => mapping(ItemType => uint256)) public accountItems;

    constructor(address initialOwner) Ownable(initialOwner) ERC20("Degen", "DGN") {
        itemPrices[ItemType.Ring] = 150;
        itemPrices[ItemType.Spikes] = 250;
        itemPrices[ItemType.Trousers] = 550;

        itemQuantities[ItemType.Ring] = 100;
        itemQuantities[ItemType.Spikes] = 100;
        itemQuantities[ItemType.Trousers] = 100;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function transferTokens(address recipient, uint256 amount) external {
        _transfer(msg.sender, recipient, amount);
    }

    function redeemTokens(ItemType itemType, uint256 quantity) external {
        require(balanceOf(msg.sender) >= itemPrices[itemType] * quantity, "Insufficient balance for redemption");
        require(itemQuantities[itemType] >= quantity, "Insufficient quantity of the item");

     
        accountItems[msg.sender][itemType] += quantity;

        _burn(msg.sender, itemPrices[itemType] * quantity);
        itemQuantities[itemType] -= quantity;
    }


    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function viewInStoreItems() external view returns (string memory output) {
        uint256[3] memory quantities;
        quantities[0] = itemQuantities[ItemType.Ring];
        quantities[1] = itemQuantities[ItemType.Spikes];
        quantities[2] = itemQuantities[ItemType.Trousers];

        output = string(abi.encodePacked(
            "Ring: ", toString(quantities[0]),
            ", Spikes: ", toString(quantities[1]),
            ", Trousers: ", toString(quantities[2])
        ));

        return output;
    }

    // View items owned by an account
    function viewOwnedItems(address account) external view returns (string memory output) {
        uint256[3] memory ownedQuantities;
        ownedQuantities[0] = accountItems[account][ItemType.Ring];
        ownedQuantities[1] = accountItems[account][ItemType.Spikes];
        ownedQuantities[2] = accountItems[account][ItemType.Trousers];

        output = string(abi.encodePacked(
            "    Ring: ", toString(ownedQuantities[0]),
            ", Spikes: ", toString(ownedQuantities[1]),
            ", Trousers: ", toString(ownedQuantities[2])
        ));

        return output;
    }


    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
