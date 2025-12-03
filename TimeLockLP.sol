// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @dev Minimal ERC-721 interface for Uniswap V3 position NFTs
interface IERC721 {
    function ownerOf(uint256 tokenId) external view returns (address);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}

/**
 * @title LPNFTTimelock
 * @notice Timelock vault for a single Uniswap V3 LP position NFT.
 *
 * - Holds ONE specific NFT (your LP position).
 * - Nobody can withdraw before `releaseTime`.
 * - After `releaseTime`, anyone can call release() and it sends the NFT
 *   to the `beneficiary`.
 *
 * Use this ONLY for your LP position NFT, not ERC20s.
 */
contract LPNFTTimelock {
    IERC721 public immutable nft;        // Uniswap V3 PositionManager (NFT contract)
    uint256 public immutable tokenId;    // Your LP position ID (e.g. 4255721)
    address public immutable beneficiary; 
    uint64  public immutable releaseTime;

    bool public released;

    event Released(address indexed beneficiary, uint256 tokenId);

    constructor(
        IERC721 _nft,
        uint256 _tokenId,
        address _beneficiary,
        uint64 _releaseTime
    ) {
        require(address(_nft) != address(0), "nft = zero");
        require(_beneficiary != address(0), "beneficiary = zero");
        require(_releaseTime > block.timestamp, "release in past");

        nft = _nft;
        tokenId = _tokenId;
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
    }

    /// @notice Sends the locked LP NFT to the beneficiary after the unlock time.
    function release() external {
        require(!released, "Already released");
        require(block.timestamp >= releaseTime, "Too early");
        require(nft.ownerOf(tokenId) == address(this), "Vault not owner");

        released = true;
        nft.safeTransferFrom(address(this), beneficiary, tokenId);

        emit Released(beneficiary, tokenId);
    }
}
