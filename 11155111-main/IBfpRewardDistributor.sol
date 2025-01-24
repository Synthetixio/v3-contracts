// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IBfpRewardDistributor {
    error FailedTransfer(address from, address to, uint256 value);
    error InsufficientRewardBalance(uint256 amount, uint256 balance);
    error InvalidParameter(string parameter, string reason);
    error Unauthorized(address addr);
    event Initialized(uint8 version);
    function distributeRewards(address collateralType, uint256 amount) external;
    function getPoolCollateralTypes() external view returns (address[] memory);
    function getPoolId() external view returns (uint128);
    function initialize(address rewardManager, address perpMarket, uint128 poolId_, address[] memory poolCollateralTypes_, address payoutToken_, string memory name_) external;
    function name() external view returns (string memory);
    function onPositionUpdated(uint128, uint128, address, uint256) external pure;
    function payout(uint128, uint128 poolId, address, address payoutTarget_, uint256 payoutAmount_) external returns (bool);
    function setShouldFailPayout(bool _shouldFailedPayout) external;
    function shouldFailPayout() external view returns (bool);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function token() external view returns (address);
}
