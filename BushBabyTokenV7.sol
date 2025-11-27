// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// OpenZeppelin v5 (non-upgradeable)
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/ERC20.sol";

/**
 * @title BushBabyTokenV7 (BBBY V7 - Pure Community, Non-upgradeable)
 *
 * V7 Philosophy
 * -------------
 * - No owner
 * - No admin controls
 * - No taxes, no fees
 * - No max wallet / max tx limits
 * - No trading enable/disable switch
 * - No blacklists / whitelists
 * - No upgradeability / proxies
 * - No minting or burning functions
 *
 * Tokenomics (V7 White Paper)
 * ---------------------------
 * - Fixed total supply: 50,000,000,000 BBBY (18 decimals)
 * - 100% of supply minted to deployer
 * - Community handles burns, LP, and allocations externally
 *
 * Immutability
 * ------------
 * - No owner
 * - No setters
 * - No ability to change anything after deployment
 * - No special logic beyond simple ERC-20
 */
contract BushBabyTokenV7 is ERC20 {
    uint256 public constant TOTAL_SUPPLY = 50_000_000_000 * 10 ** 18;

    constructor() ERC20("BushBaby", "BBBY") {
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
