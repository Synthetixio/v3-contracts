// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ISynthToken_swstETH {
    error AlreadyInitialized();
    error InsufficientAllowance(uint256 required, uint256 existing);
    error InsufficientBalance(uint256 required, uint256 existing);
    error InvalidDecayRate();
    error InvalidParameter(string parameter, string reason);
    error Unauthorized(address addr);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);
    function advanceEpoch() external returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address user) external view returns (uint256);
    function burn(address from, uint256 amount) external;
    function decayRate() external view returns (uint256);
    function decimals() external view returns (uint8);
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    function initialize(string memory tokenName, string memory tokenSymbol, uint8 tokenDecimals) external;
    function isInitialized() external view returns (bool);
    function mint(address to, uint256 amount) external;
    function name() external view returns (string memory);
    function setAllowance(address from, address spender, uint256 amount) external;
    function setDecayRate(uint256 _rate) external;
    function symbol() external view returns (string memory);
    function totalShares() external view returns (uint256);
    function totalSupply() external view returns (uint256 supply);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
