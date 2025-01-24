// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IV2xUsd {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Burned(address indexed account, uint256 value);
    event CacheUpdated(bytes32 name, address destination);
    event Issued(address indexed account, uint256 value);
    event OwnerChanged(address oldOwner, address newOwner);
    event OwnerNominated(address newOwner);
    event ProxyUpdated(address proxyAddress);
    event TokenStateUpdated(address newTokenState);
    event Transfer(address indexed from, address indexed to, uint256 value);
    function CONTRACT_NAME() external view returns (bytes32);
    function DECIMALS() external view returns (uint8);
    function FEE_ADDRESS() external view returns (address);
    function acceptOwnership() external;
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function burn(address account, uint256 amount) external;
    function currencyKey() external view returns (bytes32);
    function decimals() external view returns (uint8);
    function isResolverCached() external view returns (bool);
    function issue(address account, uint256 amount) external;
    function messageSender() external view returns (address);
    function name() external view returns (string memory);
    function nominateNewOwner(address _owner) external;
    function nominatedOwner() external view returns (address);
    function owner() external view returns (address);
    function proxy() external view returns (address);
    function rebuildCache() external;
    function resolver() external view returns (address);
    function resolverAddressesRequired() external view returns (bytes32[] memory addresses);
    function setMessageSender(address sender) external;
    function setProxy(address _proxy) external;
    function setTokenState(address _tokenState) external;
    function setTotalSupply(uint256 amount) external;
    function symbol() external view returns (string memory);
    function tokenState() external view returns (address);
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function transferAndSettle(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transferFromAndSettle(address from, address to, uint256 value) external returns (bool);
    function transferableSynths(address account) external view returns (uint256);
}
