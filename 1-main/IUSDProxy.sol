// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IUSDProxy {
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
    error MismatchAssociatedSystemKind(bytes32 expected, bytes32 actual);
    error MissingAssociatedSystem(bytes32 id);
    event AssociatedSystemSet(bytes32 indexed kind, bytes32 indexed id, address proxy, address impl);
    function getAssociatedSystem(bytes32 id) external view returns (address addr, bytes32 kind);
    function initOrUpgradeNft(bytes32 id, string memory name, string memory symbol, string memory uri, address impl) external;
    function initOrUpgradeToken(bytes32 id, string memory name, string memory symbol, uint8 decimals, address impl) external;
    function registerUnmanagedSystem(bytes32 id, address endpoint) external;
    error AlreadyInitialized();
    error InsufficientAllowance(uint256 required, uint256 existing);
    error InsufficientBalance(uint256 required, uint256 existing);
    error InvalidParameter(string parameter, string reason);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address owner) external view returns (uint256);
    function burn(uint256 amount) external;
    function burn(address target, uint256 amount) external;
    function burnWithAllowance(address from, address spender, uint256 amount) external;
    function decimals() external view returns (uint8);
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    function initialize(string memory tokenName, string memory tokenSymbol, uint8 tokenDecimals) external;
    function isInitialized() external view returns (bool);
    function mint(address target, uint256 amount) external;
    function name() external view returns (string memory);
    function setAllowance(address from, address spender, uint256 amount) external;
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

struct S_0 {
    address facetAddress;
    bytes4[] functionSelectors;
}
