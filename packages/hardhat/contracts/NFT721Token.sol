// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Inheriting from ERC721 contract
contract NFT721Token is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("NFT721Token", "NFT721") {}

    // Struct representing the metadata of each NFT
    struct TokenMetadata {
        uint256 id;
        string name;
        string description;
    }

    // Mapping from token ID to its metadata
    mapping(uint256 => TokenMetadata) private _tokenMetadatas;

    // Function to mint a new NFT
    function mintNFT(address recipient, string memory name, string memory description) external returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // Set the metadata for the new NFT
        _tokenMetadatas[newTokenId] = TokenMetadata(newTokenId, name, description);

        // Mint the new NFT to the recipient
        _mint(recipient, newTokenId);

        // Return the ID of the newly minted NFT
        return newTokenId;
    }

    // Function to get the metadata of an NFT
    function getTokenMetadata(uint256 tokenId) external view returns (TokenMetadata memory) {
        require(_exists(tokenId), "NFT721Token: Token does not exist");

        return _tokenMetadatas[tokenId];
    }
}