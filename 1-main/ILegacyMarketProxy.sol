// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ILegacyMarketProxy {
    error ImplementationIsSterile(address implementation);
    error InsufficientCollateralMigrated(uint256 amountRequested, uint256 amountAvailable);
    error InvalidParameter(string parameter, string reason);
    error MarketAlreadyRegistered(uint256 existingMarketId);
    error MigrationInProgress();
    error NoChange();
    error NotAContract(address contr);
    error NotNominated(address addr);
    error NothingToMigrate();
    error OverflowUint256ToUint128();
    error Paused();
    error Unauthorized(address addr);
    error UpgradeSimulationFailed();
    error V2xPaused();
    error ZeroAddress();
    event AccountLiquidatedInMigration(address staker, uint256 collateralAmount, uint256 debtAmount, uint256 cratio);
    event AccountMigrated(address indexed staker, uint256 indexed accountId, uint256 collateralAmount, uint256 debtAmount);
    event ConvertedUSD(address indexed account, uint256 amount);
    event DebtForgiven(address indexed staker, uint256 indexed accountId, uint256 debtForgiven);
    event MarketRegistered(address indexed marketAddress, uint128 indexed marketId, address indexed sender);
    event OwnerChanged(address oldOwner, address newOwner);
    event OwnerNominated(address newOwner);
    event PauseMigrationSet(address indexed sender, bool paused);
    event PauseStablecoinConversionSet(address indexed sender, bool paused);
    event ReturnedUSD(address indexed account, uint256 amount);
    event Upgraded(address indexed self, address implementation);
    function MIN_DELEGATION_TIME() external view returns (uint32);
    function acceptOwnership() external;
    function convertUSD(uint256 amount) external;
    function getImplementation() external view returns (address);
    function marketId() external view returns (uint128);
    function migrate(uint128 accountId) external;
    function migrateOnBehalf(address staker, uint128 accountId) external;
    function minimumCredit(uint128) external pure returns (uint256 lockedAmount);
    function name(uint128) external pure returns (string memory);
    function nominateNewOwner(address newNominatedOwner) external;
    function nominatedOwner() external view returns (address);
    function onERC721Received(address operator, address, uint256, bytes memory) external view returns (bytes4);
    function owner() external view returns (address);
    function pauseMigration() external view returns (bool);
    function pauseStablecoinConversion() external view returns (bool);
    function registerMarket() external returns (uint128 newMarketId);
    function renounceNomination() external;
    function reportedDebt(uint128 requestedMarketId) external view returns (uint256 debt);
    function returnUSD(uint256 amount) external;
    function rewardsDistributor() external view returns (address);
    function setPauseMigration(bool paused) external;
    function setPauseStablecoinConversion(bool paused) external;
    function setSystemAddresses(address v2xResolverAddress, address v3SystemAddress, address snxDistributor) external returns (bool didInitialize);
    function simulateUpgradeTo(address newImplementation) external;
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function transferDeferredAccount(uint256 accountId, address to) external;
    function upgradeTo(address to) external;
    function v2xResolver() external view returns (address);
    function v3System() external view returns (address);
}
