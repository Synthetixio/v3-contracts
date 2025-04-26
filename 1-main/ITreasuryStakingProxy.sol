// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ITreasuryStakingProxy {
    error ImplementationIsSterile(address implementation);
    error NoChange();
    error NotAContract(address contr);
    error NotNominated(address addr);
    error Unauthorized(address addr);
    error UpgradeSimulationFailed();
    error ZeroAddress();
    event Deposited(address indexed sender, uint128 indexed accountId, uint256 amount);
    event OwnerChanged(address oldOwner, address newOwner);
    event OwnerNominated(address newOwner);
    event Upgraded(address indexed self, address implementation);
    function acceptOwnership() external;
    function balanceOf(uint128) external view returns (uint256);
    function deposit(uint128 accountId, uint256 amount) external;
    function getImplementation() external view returns (address);
    function nominateNewOwner(address newNominatedOwner) external;
    function nominatedOwner() external view returns (address);
    function owner() external view returns (address);
    function recipient() external view returns (address);
    function renounceNomination() external;
    function simulateUpgradeTo(address newImplementation) external;
    function stakingToken() external view returns (address);
    function totalDeposited() external view returns (uint256);
    function treasuryMarket() external view returns (address);
    function upgradeTo(address to) external;
}
