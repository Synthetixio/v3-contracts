// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IBfpAccountProxy {
    function facets() external pure returns (S_0[] memory);
    function facetFunctionSelectors(address facet) external pure returns (bytes4[] memory functionSelectors);
    function facetAddresses() external pure returns (address[] memory addresses);
    function facetAddress(bytes4 functionSelector) external pure returns (address);
    function emitDiamondCutEvent() external returns (bool);
    error ImplementationIsSterile(address implementation);
    error NoChange();
    error NotAContract(address contr);
    error NotNominated(address addr);
    error Unauthorized(address addr);
    error UpgradeSimulationFailed();
    error ZeroAddress();
    event OwnerChanged(address oldOwner, address newOwner);
    event OwnerNominated(address newOwner);
    event Upgraded(address indexed self, address implementation);
    function acceptOwnership() external;
    function getImplementation() external view returns (address);
    function nominateNewOwner(address newNominatedOwner) external;
    function nominatedOwner() external view returns (address);
    function owner() external view returns (address);
    function renounceNomination() external;
    function simulateUpgradeTo(address newImplementation) external;
    function upgradeTo(address newImplementation) external;
    error AlreadyInitialized();
    error CannotSelfApprove(address addr);
    error IndexOverrun(uint256 requestedIndex, uint256 length);
    error InvalidOwner(address addr);
    error InvalidParameter(string parameter, string reason);
    error InvalidTransferRecipient(address addr);
    error OverflowUint256ToUint128();
    error TokenAlreadyMinted(uint256 id);
    error TokenDoesNotExist(uint256 id);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    function approve(address to, uint256 tokenId) external;
    function balanceOf(address holder) external view returns (uint256 balance);
    function burn(uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function initialize(string memory tokenName, string memory tokenSymbol, string memory uri) external;
    function isApprovedForAll(address holder, address operator) external view returns (bool);
    function isInitialized() external view returns (bool);
    function mint(address to, uint256 tokenId) external;
    function name() external view returns (string memory);
    function ownerOf(uint256 tokenId) external view returns (address);
    function safeMint(address to, uint256 tokenId, bytes memory data) external;
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) external;
    function setAllowance(uint256 tokenId, address spender) external;
    function setApprovalForAll(address operator, bool approved) external;
    function setBaseTokenURI(string memory uri) external;
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function symbol() external view returns (string memory);
    function tokenByIndex(uint256 index) external view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
    function tokenURI(uint256 tokenId) external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function transferFrom(address from, address to, uint256 tokenId) external;
}

struct S_0 {
    address facetAddress;
    bytes4[] functionSelectors;
}
