// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IRewardsDistributor_1_sBTC {
    function SYSTEM_PRECISION() external view returns (uint256);
    function authorizedExternalDistributor() external view returns (address);
    function distributeRewards(uint128 poolId_, address collateralType_, uint256 amount_, uint64 start_, uint32 duration_) external;
    function name() external view returns (string memory);
    function onPositionUpdated(uint128, uint128, address, uint256) external;
    function payout(uint128, uint128 poolId_, address, address payoutTarget_, uint256 payoutAmount_) external returns (bool);
    function payoutToken() external view returns (address);
    function poolId() external view returns (uint128);
    function precision() external view returns (uint256);
    function rewardManager() external view returns (address);
    function rewardedAmount() external view returns (uint256);
    function setShouldFailPayout(bool shouldFailPayout_) external;
    function shouldFailPayout() external view returns (bool);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function token() external view returns (address);
    error FailedTransfer(address from, address to, uint256 value);
    error InvalidParameter(string parameter, string reason);
    error NotEnoughBalance(uint256 amountRequested, uint256 currentBalance);
    error NotEnoughRewardsLeft(uint256 amountRequested, uint256 amountLeft);
    error OverflowInt256ToUint256();
    error OverflowUint256ToInt256();
    error Unauthorized(address addr);
}
