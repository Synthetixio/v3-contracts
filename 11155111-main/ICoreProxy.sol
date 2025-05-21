// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ICoreProxy {
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
    error ValueAlreadyInSet();
    error ValueNotInSet();
    event FeatureFlagAllowAllSet(bytes32 indexed feature, bool allowAll);
    event FeatureFlagAllowlistAdded(bytes32 indexed feature, address account);
    event FeatureFlagAllowlistRemoved(bytes32 indexed feature, address account);
    event FeatureFlagDeniersReset(bytes32 indexed feature, address[] deniers);
    event FeatureFlagDenyAllSet(bytes32 indexed feature, bool denyAll);
    function addToFeatureFlagAllowlist(bytes32 feature, address account) external;
    function getDeniers(bytes32 feature) external view returns (address[] memory);
    function getFeatureFlagAllowAll(bytes32 feature) external view returns (bool);
    function getFeatureFlagAllowlist(bytes32 feature) external view returns (address[] memory);
    function getFeatureFlagDenyAll(bytes32 feature) external view returns (bool);
    function isFeatureAllowed(bytes32 feature, address account) external view returns (bool);
    function removeFromFeatureFlagAllowlist(bytes32 feature, address account) external;
    function setDeniers(bytes32 feature, address[] memory deniers) external;
    function setFeatureFlagAllowAll(bytes32 feature, bool allowAll) external;
    function setFeatureFlagDenyAll(bytes32 feature, bool denyAll) external;
    error FeatureUnavailable(bytes32 which);
    error InvalidAccountId(uint128 accountId);
    error InvalidPermission(bytes32 permission);
    error OnlyAccountTokenProxy(address origin);
    error PermissionDenied(uint128 accountId, bytes32 permission, address target);
    error PermissionNotGranted(uint128 accountId, bytes32 permission, address user);
    error PositionOutOfBounds();
    event AccountCreated(uint128 indexed accountId, address indexed owner);
    event PermissionGranted(uint128 indexed accountId, bytes32 indexed permission, address indexed user, address sender);
    event PermissionRevoked(uint128 indexed accountId, bytes32 indexed permission, address indexed user, address sender);
    function createAccount() external returns (uint128 accountId);
    function createAccount(uint128 requestedAccountId) external;
    function getAccountLastInteraction(uint128 accountId) external view returns (uint256);
    function getAccountOwner(uint128 accountId) external view returns (address);
    function getAccountPermissions(uint128 accountId) external view returns (IAccountModule.AccountPermissions[] memory accountPerms);
    function getAccountTokenAddress() external view returns (address);
    function grantPermission(uint128 accountId, bytes32 permission, address user) external;
    function hasPermission(uint128 accountId, bytes32 permission, address user) external view returns (bool);
    function isAuthorized(uint128 accountId, bytes32 permission, address user) external view returns (bool);
    function notifyAccountTransfer(address to, uint128 accountId) external;
    function renouncePermission(uint128 accountId, bytes32 permission) external;
    function revokePermission(uint128 accountId, bytes32 permission, address user) external;
    error AccountNotFound(uint128 accountId);
    error EmptyDistribution();
    error EmptyRevertReason();
    error Errors(bytes[] errors);
    error InsufficientCollateralRatio(uint256 collateralValue, uint256 debt, uint256 ratio, uint256 minRatio);
    error MarketNotFound(uint128 marketId);
    error NotFundedByPool(uint256 marketId, uint256 poolId);
    error OverflowInt256ToInt128();
    error OverflowInt256ToUint256();
    error OverflowUint128ToInt128();
    error OverflowUint256ToInt256();
    error OverflowUint256ToUint128();
    event DebtAssociated(uint128 indexed marketId, uint128 indexed poolId, address indexed collateralType, uint128 accountId, uint256 amount, int256 updatedDebt);
    function associateDebt(uint128 marketId, uint128 poolId, address collateralType, uint128 accountId, uint256 amount) external returns (int256);
    error MismatchAssociatedSystemKind(bytes32 expected, bytes32 actual);
    error MissingAssociatedSystem(bytes32 id);
    event AssociatedSystemSet(bytes32 indexed kind, bytes32 indexed id, address proxy, address impl);
    function getAssociatedSystem(bytes32 id) external view returns (address addr, bytes32 kind);
    function initOrUpgradeNft(bytes32 id, string memory name, string memory symbol, string memory uri, address impl) external;
    function initOrUpgradeToken(bytes32 id, string memory name, string memory symbol, uint8 decimals, address impl) external;
    function registerUnmanagedSystem(bytes32 id, address endpoint) external;
    error InvalidMessage();
    error NotCcipRouter(address);
    error UnsupportedNetwork(uint64);
    function ccipReceive(CcipClient.Any2EVMMessage memory message) external;
    error AccountActivityTimeoutPending(uint128 accountId, uint256 currentTime, uint256 requiredTime);
    error CollateralDepositDisabled(address collateralType);
    error CollateralNotFound();
    error FailedTransfer(address from, address to, uint256 value);
    error InsufficientAccountCollateral(uint256 amount);
    error InsufficientAllowance(uint256 required, uint256 existing);
    error InsufficientAvailableCollateral(uint256 amountAvailableForDelegationD18, uint256 amountD18);
    error InvalidParameter(string parameter, string reason);
    error OverflowUint256ToUint64();
    error PrecisionLost(uint256 tokenAmount, uint8 decimals);
    event CollateralLockCreated(uint128 indexed accountId, address indexed collateralType, uint256 tokenAmount, uint64 expireTimestamp);
    event CollateralLockExpired(uint256 tokenAmount, uint64 expireTimestamp);
    event Deposited(uint128 indexed accountId, address indexed collateralType, uint256 tokenAmount, address indexed sender);
    event Withdrawn(uint128 indexed accountId, address indexed collateralType, uint256 tokenAmount, address indexed sender);
    function cleanExpiredLocks(uint128 accountId, address collateralType, uint256 offset, uint256 count) external returns (uint256 cleared, uint256 remainingLockAmountD18);
    function createLock(uint128 accountId, address collateralType, uint256 amount, uint64 expireTimestamp) external;
    function deposit(uint128 accountId, address collateralType, uint256 tokenAmount) external;
    function getAccountAvailableCollateral(uint128 accountId, address collateralType) external view returns (uint256);
    function getAccountCollateral(uint128 accountId, address collateralType) external view returns (uint256 totalDeposited, uint256 totalAssigned, uint256 totalLocked);
    function getLocks(uint128 accountId, address collateralType, uint256 offset, uint256 count) external view returns (CollateralLock.Data[] memory locks);
    function withdraw(uint128 accountId, address collateralType, uint256 tokenAmount) external;
    event CollateralConfigured(address indexed collateralType, CollateralConfiguration.Data config);
    function configureCollateral(CollateralConfiguration.Data memory config) external;
    function getCollateralConfiguration(address collateralType) external pure returns (CollateralConfiguration.Data memory);
    function getCollateralConfigurations(bool hideDisabled) external view returns (CollateralConfiguration.Data[] memory);
    function getCollateralPrice(address collateralType) external view returns (uint256);
    error InsufficientCcipFee(uint256 requiredAmount, uint256 availableAmount);
    event TransferCrossChainInitiated(uint64 indexed destChainId, uint256 indexed amount, address sender);
    function transferCrossChain(uint64 destChainId, uint256 amount) external payable returns (uint256 gasTokenUsed);
    error InsufficientDebt(int256 currentDebt);
    error PoolNotFound(uint128 poolId);
    event UsdBurned(uint128 indexed accountId, uint128 indexed poolId, address collateralType, uint256 amount, address indexed sender);
    event UsdMinted(uint128 indexed accountId, uint128 indexed poolId, address collateralType, uint256 amount, address indexed sender);
    function burnUsd(uint128 accountId, uint128 poolId, address collateralType, uint256 amount) external;
    function mintUsd(uint128 accountId, uint128 poolId, address collateralType, uint256 amount) external;
    error CannotScaleEmptyMapping();
    error IneligibleForLiquidation(uint256 collateralValue, int256 debt, uint256 currentCRatio, uint256 cratio);
    error InsufficientMappedAmount();
    error MustBeVaultLiquidated();
    error OverflowInt128ToUint128();
    error OverflowUint256ToUint32();
    error OverflowUint32ToInt32();
    error OverflowUint64ToInt64();
    event Liquidation(uint128 indexed accountId, uint128 indexed poolId, address indexed collateralType, ILiquidationModule.LiquidationData liquidationData, uint128 liquidateAsAccountId, address sender);
    event VaultLiquidation(uint128 indexed poolId, address indexed collateralType, ILiquidationModule.LiquidationData liquidationData, uint128 liquidateAsAccountId, address sender);
    function isPositionLiquidatable(uint128 accountId, uint128 poolId, address collateralType) external returns (bool);
    function isVaultLiquidatable(uint128 poolId, address collateralType) external returns (bool);
    function liquidate(uint128 accountId, uint128 poolId, address collateralType, uint128 liquidateAsAccountId) external returns (ILiquidationModule.LiquidationData memory liquidationData);
    function liquidateToTreasury(uint128 accountId, uint128 poolId, address collateralType) external returns (ILiquidationModule.LiquidationData memory liquidationData);
    function liquidateVault(uint128 poolId, address collateralType, uint128 liquidateAsAccountId, uint256 maxUsd) external returns (ILiquidationModule.LiquidationData memory liquidationData);
    error InsufficientMarketCollateralDepositable(uint128 marketId, address collateralType, uint256 tokenAmountToDeposit);
    error InsufficientMarketCollateralWithdrawable(uint128 marketId, address collateralType, uint256 tokenAmountToWithdraw);
    event MarketCollateralDeposited(uint128 indexed marketId, address indexed collateralType, uint256 tokenAmount, address indexed sender, int128 creditCapacity, int128 netIssuance, uint256 depositedCollateralValue, uint256 reportedDebt);
    event MarketCollateralWithdrawn(uint128 indexed marketId, address indexed collateralType, uint256 tokenAmount, address indexed sender, int128 creditCapacity, int128 netIssuance, uint256 depositedCollateralValue, uint256 reportedDebt);
    event MaximumMarketCollateralConfigured(uint128 indexed marketId, address indexed collateralType, uint256 systemAmount, address indexed owner);
    function configureMaximumMarketCollateral(uint128 marketId, address collateralType, uint256 amount) external;
    function depositMarketCollateral(uint128 marketId, address collateralType, uint256 tokenAmount) external;
    function getMarketCollateralAmount(uint128 marketId, address collateralType) external view returns (uint256 collateralAmountD18);
    function getMarketCollateralValue(uint128 marketId) external view returns (uint256);
    function getMaximumMarketCollateral(uint128 marketId, address collateralType) external view returns (uint256);
    function withdrawMarketCollateral(uint128 marketId, address collateralType, uint256 tokenAmount) external;
    error IncorrectMarketInterface(address market);
    error NotEnoughLiquidity(uint128 marketId, uint256 amount);
    event MarketRegistered(address indexed market, uint128 indexed marketId, address indexed sender);
    event MarketUsdDeposited(uint128 indexed marketId, address indexed target, uint256 amount, address indexed market, int128 creditCapacity, int128 netIssuance, uint256 depositedCollateralValue);
    event MarketUsdWithdrawn(uint128 indexed marketId, address indexed target, uint256 amount, address indexed market, int128 creditCapacity, int128 netIssuance, uint256 depositedCollateralValue);
    event SetMarketMinLiquidityRatio(uint128 indexed marketId, uint256 minLiquidityRatio);
    event SetMinDelegateTime(uint128 indexed marketId, uint32 minDelegateTime);
    function depositMarketUsd(uint128 marketId, address target, uint256 amount) external returns (uint256 feeAmount);
    function distributeDebtToPools(uint128 marketId, uint256 maxIter) external returns (bool);
    function getMarketAddress(uint128 marketId) external view returns (address);
    function getMarketCapacityContributionFromPool(uint128 marketId, uint128 poolId) external view returns (uint256);
    function getMarketCollateral(uint128 marketId) external view returns (uint256);
    function getMarketDebtPerShare(uint128 marketId) external returns (int256);
    function getMarketFees(uint128, uint256 amount) external view returns (uint256 depositFeeAmount, uint256 withdrawFeeAmount);
    function getMarketMinDelegateTime(uint128 marketId) external view returns (uint32);
    function getMarketNetIssuance(uint128 marketId) external view returns (int128);
    function getMarketPoolDebtDistribution(uint128 marketId, uint128 poolId) external returns (uint256 sharesD18, uint128 totalSharesD18, int128 valuePerShareD27);
    function getMarketPoolMaxDebtPerShare(uint128 marketId, uint128 poolId) external view returns (int256);
    function getMarketPools(uint128 marketId) external returns (uint128[] memory inRangePoolIds, uint128[] memory outRangePoolIds);
    function getMarketReportedDebt(uint128 marketId) external view returns (uint256);
    function getMarketTotalDebt(uint128 marketId) external view returns (int256);
    function getMinLiquidityRatio(uint128 marketId) external view returns (uint256);
    function getOracleManager() external view returns (address);
    function getUsdToken() external view returns (address);
    function getWithdrawableMarketUsd(uint128 marketId) external view returns (uint256);
    function isMarketCapacityLocked(uint128 marketId) external view returns (bool);
    function registerMarket(address market) external returns (uint128 marketId);
    function setMarketMinDelegateTime(uint128 marketId, uint32 minDelegateTime) external;
    function setMinLiquidityRatio(uint128 marketId, uint256 minLiquidityRatio) external;
    function withdrawMarketUsd(uint128 marketId, address target, uint256 amount) external returns (uint256 feeAmount);
    event PoolApprovedAdded(uint256 poolId);
    event PoolApprovedRemoved(uint256 poolId);
    event PreferredPoolSet(uint256 poolId);
    function addApprovedPool(uint128 poolId) external;
    function getApprovedPools() external view returns (uint256[] memory);
    function getPreferredPool() external view returns (uint128);
    function removeApprovedPool(uint128 poolId) external;
    function setPreferredPool(uint128 poolId) external;
    error CapacityLocked(uint256 marketId);
    error MinDelegationTimeoutPending(uint128 poolId, uint32 timeRemaining);
    error PoolAlreadyExists(uint128 poolId);
    event PoolCollateralConfigurationUpdated(uint128 indexed poolId, address collateralType, PoolCollateralConfiguration.Data config);
    event PoolCollateralDisabledByDefaultSet(uint128 poolId, bool disabled);
    event PoolConfigurationSet(uint128 indexed poolId, MarketConfiguration.Data[] markets, address indexed sender);
    event PoolCreated(uint128 indexed poolId, address indexed owner, address indexed sender);
    event PoolNameUpdated(uint128 indexed poolId, string name, address indexed sender);
    event PoolNominationRenounced(uint128 indexed poolId, address indexed owner);
    event PoolNominationRevoked(uint128 indexed poolId, address indexed owner);
    event PoolOwnerNominated(uint128 indexed poolId, address indexed nominatedOwner, address indexed owner);
    event PoolOwnershipAccepted(uint128 indexed poolId, address indexed owner);
    event PoolOwnershipRenounced(uint128 indexed poolId, address indexed owner);
    event SetMinLiquidityRatio(uint256 minLiquidityRatio);
    function acceptPoolOwnership(uint128 poolId) external;
    function createPool(uint128 requestedPoolId, address owner) external;
    function getMinLiquidityRatio() external view returns (uint256);
    function getNominatedPoolOwner(uint128 poolId) external view returns (address);
    function getPoolCollateralConfiguration(uint128 poolId, address collateralType) external view returns (PoolCollateralConfiguration.Data memory config);
    function getPoolCollateralIssuanceRatio(uint128 poolId, address collateral) external view returns (uint256);
    function getPoolConfiguration(uint128 poolId) external view returns (MarketConfiguration.Data[] memory);
    function getPoolDebtPerShare(uint128 poolId) external returns (int256 debtPerShareD18);
    function getPoolName(uint128 poolId) external view returns (string memory poolName);
    function getPoolOwner(uint128 poolId) external view returns (address);
    function getPoolTotalDebt(uint128 poolId) external returns (int256 totalDebtD18);
    function nominatePoolOwner(address nominatedOwner, uint128 poolId) external;
    function rebalancePool(uint128 poolId, address optionalCollateralType) external;
    function renouncePoolNomination(uint128 poolId) external;
    function renouncePoolOwnership(uint128 poolId) external;
    function revokePoolNomination(uint128 poolId) external;
    function setMinLiquidityRatio(uint256 minLiquidityRatio) external;
    function setPoolCollateralConfiguration(uint128 poolId, address collateralType, PoolCollateralConfiguration.Data memory newConfig) external;
    function setPoolCollateralDisabledByDefault(uint128 poolId, bool disabled) external;
    function setPoolConfiguration(uint128 poolId, MarketConfiguration.Data[] memory newMarketConfigurations) external;
    function setPoolName(uint128 poolId, string memory name) external;
    error RewardUnavailable(address distributor);
    event RewardsClaimed(uint128 indexed accountId, uint128 indexed poolId, address indexed collateralType, address distributor, uint256 amount);
    event RewardsDistributed(uint128 indexed poolId, address indexed collateralType, address distributor, uint256 amount, uint256 start, uint256 duration);
    event RewardsDistributorRegistered(uint128 indexed poolId, address indexed collateralType, address indexed distributor);
    event RewardsDistributorRemoved(uint128 indexed poolId, address indexed collateralType, address indexed distributor);
    function claimPoolRewards(uint128 accountId, uint128 poolId, address collateralType, address distributor) external returns (uint256);
    function claimRewards(uint128 accountId, uint128 poolId, address collateralType, address distributor) external returns (uint256);
    function distributeRewards(uint128 poolId, address collateralType, uint256 amount, uint64 start, uint32 duration) external returns (int256);
    function distributeRewardsByOwner(uint128 poolId, address collateralType, address rewardsDistributor, uint256 amount, uint64 start, uint32 duration) external returns (int256);
    function getAvailablePoolRewards(uint128 accountId, uint128 poolId, address collateralType, address distributor) external returns (uint256);
    function getAvailableRewards(uint128 accountId, uint128 poolId, address collateralType, address distributor) external returns (uint256);
    function getRewardRate(uint128 poolId, address collateralType, address distributor) external view returns (uint256);
    function registerRewardsDistributor(uint128 poolId, address collateralType, address distributor) external;
    function removeRewardsDistributor(uint128 poolId, address collateralType, address distributor) external;
    function updateRewards(uint128 poolId, address collateralType, uint128 accountId) external returns (uint256[] memory, address[] memory, uint256);
    event ConfigSet(bytes32 indexed k, bytes32 v);
    event NewSupportedCrossChainNetwork(uint64 newChainId);
    function configureChainlinkCrossChain(address ccipRouter, address ccipTokenPool) external;
    function configureOracleManager(address oracleManagerAddress) external;
    function getConfig(bytes32 k) external view returns (bytes32 v);
    function getConfigAddress(bytes32 k) external view returns (address v);
    function getConfigUint(bytes32 k) external view returns (uint256 v);
    function getTrustedForwarder() external pure returns (address);
    function isTrustedForwarder(address forwarder) external pure returns (bool);
    function setConfig(bytes32 k, bytes32 v) external;
    function setSupportedCrossChainNetworks(uint64[] memory supportedNetworks, uint64[] memory ccipSelectors) external returns (uint256 numRegistered);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    error InsufficientDelegation(uint256 minDelegation);
    error InsufficientVaultCollateralRatio(uint128 poolId, address collateralType);
    error InvalidCollateralAmount();
    error InvalidLeverage(uint256 leverage);
    error PoolCollateralLimitExceeded(uint128 poolId, address collateralType, uint256 currentCollateral, uint256 maxCollateral);
    event DelegationUpdated(uint128 indexed accountId, uint128 indexed poolId, address collateralType, uint256 amount, uint256 leverage, address indexed sender);
    function delegateCollateral(uint128 accountId, uint128 poolId, address collateralType, uint256 newCollateralAmountD18, uint256 leverage) external;
    function getLastDelegationTime(uint128 accountId, uint128 poolId, address collateralType) external view returns (uint256 lastDelegationTime);
    function getPosition(uint128 accountId, uint128 poolId, address collateralType) external returns (uint256 collateralAmount, uint256 collateralValue, int256 debt, uint256 collateralizationRatio);
    function getPositionCollateral(uint128 accountId, uint128 poolId, address collateralType) external view returns (uint256 amount);
    function getPositionCollateralRatio(uint128 accountId, uint128 poolId, address collateralType) external returns (uint256);
    function getPositionDebt(uint128 accountId, uint128 poolId, address collateralType) external returns (int256 debt);
    function getVaultCollateral(uint128 poolId, address collateralType) external view returns (uint256 amount, uint256 value);
    function getVaultCollateralRatio(uint128 poolId, address collateralType) external returns (uint256);
    function getVaultDebt(uint128 poolId, address collateralType) external returns (int256);
    function migrateDelegation(uint128 accountId, uint128 oldPoolId, address collateralType, uint128 newPoolId) external;
}

interface IAccountModule {
    struct AccountPermissions {
        address user;
        bytes32[] permissions;
    }
}

interface CcipClient {
    struct EVMTokenAmount {
        address token;
        uint256 amount;
    }

    struct Any2EVMMessage {
        bytes32 messageId;
        uint64 sourceChainSelector;
        bytes sender;
        bytes data;
        EVMTokenAmount[] tokenAmounts;
    }
}

interface CollateralLock {
    struct Data {
        uint128 amountD18;
        uint64 lockExpirationTime;
    }
}

interface CollateralConfiguration {
    struct Data {
        bool depositingEnabled;
        uint256 issuanceRatioD18;
        uint256 liquidationRatioD18;
        uint256 liquidationRewardD18;
        bytes32 oracleNodeId;
        address tokenAddress;
        uint256 minDelegationD18;
    }
}

interface ILiquidationModule {
    struct LiquidationData {
        uint256 debtLiquidated;
        uint256 collateralLiquidated;
        uint256 amountRewarded;
    }
}

interface PoolCollateralConfiguration {
    struct Data {
        uint256 collateralLimitD18;
        uint256 issuanceRatioD18;
    }
}

interface MarketConfiguration {
    struct Data {
        uint128 marketId;
        uint128 weightD18;
        int128 maxDebtShareValueD18;
    }
}

struct S_0 {
    address facetAddress;
    bytes4[] functionSelectors;
}
