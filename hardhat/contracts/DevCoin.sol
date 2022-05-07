// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Great contracts to gain info from
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DevCoin is ERC721, Ownable {
    uint256 public mintPrice = 0.05 ether; // converts to : 50000000000000000 wei
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled; // timing of the minting 
    mapping(address => uint256) public mintedWallets;

    // initalizes the contract
    constructor() payable ERC721('Dev Coin', 'DVC') {
        maxSupply = 2;
    }

    // enabling the minting of the nft. 
    function toggleIsMintEnabled() external onlyOwner { 
        isMintEnabled = !isMintEnabled;
    }

    //  max supply function
    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    // minting function
    function mint() external payable{ 
        require(isMintEnabled, 'minting not enabled.'); // error if minting isn't available. 

        require(mintedWallets[msg.sender] <1, 'exceeds max per wallet'); // only one mint per wallet

        require(msg.value == mintPrice, 'wrong value'); // making sure the correct price is placed for mint

        require(maxSupply > totalSupply, 'Sold Out!'); // sold out gives a limit of the Nft

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;

        _safeMint(msg.sender, tokenId); // allows to mint safely with sending the address and token ids 


    }


}

