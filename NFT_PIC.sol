// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "PIC_Modifier.sol";

contract NFTMarketplace is ERC721Enumerable, Ownable, PIC_Modifier {
    uint256 mintNFTNumber;

    // 挖的數量 test git master -> develop
    uint256 public supplyNFT1;

    //價錢範圍
    uint256 public nftPrice;

    // 圖片網址
    string public baseUri;

    // 檔案附檔名
    string public extensionFileName;

    //每個人限制數量
    uint256 mintLimit;

    bool public enabled;

    // _tokenURIS[key] = "value"
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("Picture", "PIC") {
        supplyNFT1 = 100;
        nftPrice = 0.0001 ether;
        baseUri = "https://testNFT.com/";
        extensionFileName = ".json";
        mintLimit = 2;
        enabled = true;
    }

    function mintNFT() public mintNFTModifier payable {
        // 開關
        if (!enabled) {
            require(true, "this nft already closed.");
        }

        // 目前已挖出數量，如果這次再挖會不會超過
        uint256 mintIndex = getCurrentNFTIndex();
        require(mintIndex + 1 <= supplyNFT1, "Sale would exceed max supply");

        // 是否傳入足夠的錢
        require(1 * nftPrice <= msg.value, "Not enough ether sent");

        _safeMint(msg.sender, mintIndex);
    }

    function transferNFT() public {}

    function getNFTList() public view returns (string[] memory) {
        uint256 nftIndex = getCurrentNFTIndex();
        string[] memory urlArr = new string[](nftIndex);
        string memory base = _baseURI();

        for (uint256 i = 0; i < nftIndex; i++) {
            urlArr[i] = string(
                abi.encodePacked(base, Strings.toString(i), extensionFileName)
            );
        }

        return urlArr;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        if (bytes(base).length == 0) {
            return _tokenURI;
        }

        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        // 組成圖片url
        return
            string(
                abi.encodePacked(
                    base,
                    Strings.toString(tokenId),
                    extensionFileName
                )
            );
    }

    // inherit function
    function getCurrentNFTIndex() private view returns (uint256) {
        return totalSupply();
    }

    //only owner
    function setBaseUrl(string memory _baseUrl) public onlyOwner {
        baseUri = _baseUrl;
    }

    // internal
    function _baseURI() internal view virtual override returns (string memory) {
        return baseUri;
    }
}
