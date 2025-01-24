// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IBfpMarketProxy {
    error FeatureUnavailable(bytes32 which);
    error InvalidAccountId(uint128 accountId);
    error InvalidPermission(bytes32 permission);
    error OnlyAccountTokenProxy(address origin);
    error PermissionDenied(uint128 accountId, bytes32 permission, address target);
    error PermissionNotGranted(uint128 accountId, bytes32 permission, address user);
    error PositionOutOfBounds();
    error ValueAlreadyInSet();
    error ValueNotInSet();
    error ZeroAddress();
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
    error MismatchAssociatedSystemKind(bytes32 expected, bytes32 actual);
    error MissingAssociatedSystem(bytes32 id);
    error Unauthorized(address addr);
    event AssociatedSystemSet(bytes32 indexed kind, bytes32 indexed id, address proxy, address impl);
    function getAssociatedSystem(bytes32 id) external view returns (address addr, bytes32 kind);
    function initOrUpgradeNft(bytes32 id, string memory name, string memory symbol, string memory uri, address impl) external;
    function initOrUpgradeToken(bytes32 id, string memory name, string memory symbol, uint8 decimals, address impl) external;
    function registerUnmanagedSystem(bytes32 id, address endpoint) external;
    error ImplementationIsSterile(address implementation);
    error NoChange();
    error NotAContract(address contr);
    error NotNominated(address addr);
    error UpgradeSimulationFailed();
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
    event FeatureFlagAllowAllSet(bytes32 indexed feature, bool allowAll);
    event FeatureFlagAllowlistAdded(bytes32 indexed feature, address account);
    event FeatureFlagAllowlistRemoved(bytes32 indexed feature, address account);
    event FeatureFlagDeniersReset(bytes32 indexed feature, address[] deniers);
    event FeatureFlagDenyAllSet(bytes32 indexed feature, bool denyAll);
    event PerpMarketSuspended(bool suspended);
    function addToFeatureFlagAllowlist(bytes32 feature, address account) external;
    function enableAllFeatures() external;
    function getDeniers(bytes32 feature) external view returns (address[] memory);
    function getFeatureFlagAllowAll(bytes32 feature) external view returns (bool);
    function getFeatureFlagAllowlist(bytes32 feature) external view returns (address[] memory);
    function getFeatureFlagDenyAll(bytes32 feature) external view returns (bool);
    function isFeatureAllowed(bytes32 feature, address account) external view returns (bool);
    function removeFromFeatureFlagAllowlist(bytes32 feature, address account) external;
    function setDeniers(bytes32 feature, address[] memory deniers) external;
    function setFeatureFlagAllowAll(bytes32 feature, bool allowAll) external;
    function setFeatureFlagDenyAll(bytes32 feature, bool denyAll) external;
    function suspendAllFeatures() external;

    error InvalidCoreAddress(address synthetixCore);
    error MarketNotFound(uint128 marketId);
    error OverflowInt256ToInt128();
    error OverflowInt256ToUint256();
    error OverflowUint128ToInt128();
    error OverflowUint256ToInt256();
    error OverflowUint256ToUint128();
    error OverflowUint256ToUint64();
    event FundingRecomputed(uint128 indexed marketId, int128 skew, int128 fundingRate, int128 fundingVelocity);
    event MarketCreated(uint128 indexed id, bytes32 name);
    event MarketSizeUpdated(uint128 indexed marketId, uint128 size, int128 skew);
    event OrderCanceled(uint128 indexed accountId, uint128 indexed marketId, uint256 keeperFee, uint64 commitmentTime);
    event UtilizationRecomputed(uint128 indexed marketId, int128 skew, uint128 utilizationRate);
    function createMarket(IPerpMarketFactoryModule.CreatePerpMarketParameters memory data) external returns (uint128);
    function getActiveMarketIds() external view returns (uint128[] memory);
    function getMarketDigest(uint128 marketId) external view returns (IPerpMarketFactoryModule.MarketDigest memory);
    function getUtilizationDigest(uint128 marketId) external view returns (IPerpMarketFactoryModule.UtilizationDigest memory);
    function minimumCredit(uint128 marketId) external view returns (uint256);
    function name(uint128) external pure returns (string memory);
    function recomputeFunding(uint128 marketId) external;
    function recomputeUtilization(uint128 marketId) external;
    function reportedDebt(uint128 marketId) external view returns (uint256);
    function setEthOracleNodeId(bytes32 ethOracleNodeId) external;
    function setPyth(address pyth) external;
    function setRewardDistributorImplementation(address implementation) external;
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    error InvalidParameter(string parameter, string reason);
    event GlobalMarketConfigured(address indexed from);
    event MarketConfigured(uint128 indexed marketId, address indexed from);
    function getMarketConfiguration() external pure returns (PerpMarketConfiguration.GlobalData memory);
    function getMarketConfigurationById(uint128 marketId) external pure returns (PerpMarketConfiguration.Data memory);
    function setMarketConfiguration(IMarketConfigurationModule.GlobalMarketConfigureParameters memory data) external;
    function setMarketConfigurationById(IMarketConfigurationModule.ConfigureByMarketParameters memory data) external;
    function setMinDelegationTime(uint128 marketId, uint32 minDelegationTime) external;
    error AccountNotFound(uint128 accountId);
    error AccountSplitProportionTooLarge();
    error AccountSplitProportionTooSmall();
    error CanLiquidatePosition();
    error CollateralFound();
    error DuplicateEntries();
    error InsufficientMargin();
    error InvalidHook(address hook);
    error InvalidPositionSide();
    error OrderFound();
    error OverflowInt128ToUint128();
    error PositionFlagged();
    error PositionFound(uint128 accountId, uint128 marketId);
    error PositionNotFound();
    error ZeroProportion();
    event AccountSplit(uint128 indexed fromId, uint128 indexed toId, uint128 indexed marketId);
    event AccountsMerged(uint128 indexed fromId, uint128 indexed toId, uint128 indexed marketId);
    function getAccountDigest(uint128 accountId, uint128 marketId) external view returns (IPerpAccountModule.AccountDigest memory);
    function getPositionDigest(uint128 accountId, uint128 marketId) external view returns (IPerpAccountModule.PositionDigest memory);
    function mergeAccounts(uint128 fromId, uint128 toId, uint128 marketId) external;
    function splitAccount(uint128 fromId, uint128 toId, uint128 marketId, uint128 proportion) external;
    error ArrayLengthMismatch();
    error DebtFound(uint128 accountId, uint128 marketId);
    error InsufficientCollateral(address collateralAddress, uint256 available, uint256 value);
    error InvalidRewardDistributor(address distributor);
    error MaxCollateralExceeded(uint256 value, uint256 max);
    error MissingRequiredCollateral(address collateralAddress);
    error NilCollateral();
    error NoDebt();
    error UnsupportedCollateral(address collateralAddress);
    error ZeroAmount();
    event DebtPaid(uint128 indexed accountId, uint128 indexed marketId, uint128 oldDebt, uint128 newDebt, uint128 paidFromUsdCollateral);
    event MarginCollateralConfigured(address indexed from, uint256 collaterals);
    event MarginDeposit(address indexed from, address indexed to, uint256 value, address collateralAddress);
    event MarginWithdraw(address indexed from, address indexed to, uint256 value, address collateralAddress);
    function getDiscountedCollateralPrice(address collateralAddress, uint256 amount) external view returns (uint256);
    function getMarginCollateralConfiguration() external view returns (IMarginModule.ConfiguredCollateral[] memory);
    function getMarginDigest(uint128 accountId, uint128 marketId) external view returns (Margin.MarginValues memory);
    function getMarginLiquidationOnlyReward(uint128 accountId, uint128 marketId) external view returns (uint256);
    function getNetAssetValue(uint128 accountId, uint128 marketId, uint256 oraclePrice) external view returns (uint256);
    function getWithdrawableMargin(uint128 accountId, uint128 marketId) external view returns (uint256);
    function modifyCollateral(uint128 accountId, uint128 marketId, address collateralAddress, int256 amountDelta) external;
    function payDebt(uint128 accountId, uint128 marketId, uint128 amount) external;
    function setCollateralMaxAllowable(address collateralAddress, uint128 maxAllowable) external;
    function setMarginCollateralConfiguration(address[] memory collateralAddresses, bytes32[] memory oracleNodeIds, uint128[] memory maxAllowables, uint128[] memory skewScales, address[] memory rewardDistributors) external;
    function withdrawAllCollateral(uint128 accountId, uint128 marketId) external;
    error DuplicateHook(address hook);
    error InsufficientLiquidity();
    error InvalidPrice();
    error MaxHooksExceeded();
    error MaxMarketSizeExceeded();
    error NilOrder();
    error OrderNotFound();
    error OrderNotReady();
    error OrderNotStale();
    error OrderStale();
    error PriceToleranceExceeded(int128 sizeDelta, uint256 price, uint256 limitPrice);
    error PriceToleranceNotExceeded(int128 sizeDelta, uint256 price, uint256 limitPrice);
    event OrderCommitted(uint128 indexed accountId, uint128 indexed marketId, uint64 commitmentTime, int128 sizeDelta, uint256 estimatedOrderFee, uint256 estimatedKeeperFee, bytes32 trackingCode);
    event OrderSettled(uint128 indexed accountId, uint128 indexed marketId, uint64 settlementTime, int128 sizeDelta, uint256 orderFee, uint256 keeperFee, int128 accruedFunding, uint128 accruedUtilization, int256 pnl, uint256 fillPrice, uint128 accountDebt);
    event OrderSettlementHookExecuted(uint128 indexed accountId, uint128 indexed marketId, address hook);
    function cancelOrder(uint128 accountId, uint128 marketId, bytes memory priceUpdateData) external payable;
    function cancelStaleOrder(uint128 accountId, uint128 marketId) external;
    function commitOrder(uint128 accountId, uint128 marketId, int128 sizeDelta, uint256 limitPrice, uint128 keeperFeeBufferUsd, address[] memory hooks, bytes32 trackingCode) external;
    function getFillPrice(uint128 marketId, int128 size) external view returns (uint256);
    function getOraclePrice(uint128 marketId) external view returns (uint256);
    function getOrderDigest(uint128 accountId, uint128 marketId) external view returns (IOrderModule.OrderDigest memory);
    function getOrderFees(uint128 marketId, int128 sizeDelta, uint128 keeperFeeBufferUsd) external view returns (uint256 orderFee, uint256 keeperFee);
    function settleOrder(uint128 accountId, uint128 marketId, bytes memory priceUpdateData) external payable;
    error CannotLiquidateMargin();
    error CannotLiquidatePosition();
    error LiquidationZeroCapacity();
    error PositionNotFlagged();
    event MarginLiquidated(uint128 indexed accountId, uint128 indexed marketId, uint256 keeperReward);
    event PositionFlaggedLiquidation(uint128 indexed accountId, uint128 indexed marketId, address flagger, uint256 flagKeeperReward, uint256 flaggedPrice);
    event PositionLiquidated(uint128 indexed accountId, uint128 indexed marketId, int128 sizeBeforeLiquidation, int128 remainingSize, address keeper, address flagger, uint256 liqKeeperFee, uint256 liquidationPrice);
    function flagPosition(uint128 accountId, uint128 marketId) external;
    function getHealthFactor(uint128 accountId, uint128 marketId) external view returns (uint256);
    function getLiquidationFees(uint128 accountId, uint128 marketId) external view returns (uint256 flagKeeperReward, uint256 liqKeeperFee);
    function getLiquidationMarginUsd(uint128 accountId, uint128 marketId, int128 sizeDelta) external view returns (uint256 im, uint256 mm);
    function getRemainingLiquidatableSizeCapacity(uint128 marketId) external view returns (uint128 maxLiquidatableCapacity, uint128 remainingCapacity, uint128 lastLiquidationTimestamp);
    function isMarginLiquidatable(uint128 accountId, uint128 marketId) external view returns (bool);
    function isPositionLiquidatable(uint128 accountId, uint128 marketId) external view returns (bool);
    function liquidateMarginOnly(uint128 accountId, uint128 marketId) external;
    function liquidatePosition(uint128 accountId, uint128 marketId) external;
    error ZeroLength();
    event RewardDistributorCreated(address indexed distributor);
    function createRewardDistributor(IPerpRewardDistributorFactoryModule.CreatePerpRewardDistributorParameters memory data) external returns (address);
    event SettlementHookConfigured(address indexed from, uint256 hooks);
    function getSettlementHookConfiguration() external view returns (ISettlementHookModule.SettlementHookConfigureParameters memory);
    function isSettlementHookWhitelisted(address hook) external view returns (bool);
    function setSettlementHookConfiguration(ISettlementHookModule.SettlementHookConfigureParameters memory data) external;
    event SplitAccountConfigured(address indexed from, uint256 hooks);
    function getEndorsedSplitAccounts() external view returns (address[] memory addresses);
    function isEndorsedForSplitAccount(address addr) external view returns (bool);
    function setEndorsedSplitAccounts(address[] memory addresses) external;
}

interface IAccountModule {
    struct AccountPermissions {
        address user;
        bytes32[] permissions;
    }
}

interface IPerpMarketFactoryModule {
    struct CreatePerpMarketParameters {
        bytes32 name;
        uint32 minDelegateTime;
    }

    struct DepositedCollateral {
        address collateralAddress;
        uint256 available;
    }

    struct MarketDigest {
        DepositedCollateral[] depositedCollaterals;
        bytes32 name;
        int128 skew;
        uint128 size;
        uint256 oraclePrice;
        int128 fundingVelocity;
        int128 fundingRate;
        uint128 utilizationRate;
        uint128 remainingLiquidatableSizeCapacity;
        uint128 lastLiquidationTime;
        uint128 totalTraderDebtUsd;
        uint256 totalCollateralValueUsd;
        int128 debtCorrection;
    }

    struct UtilizationDigest {
        uint128 lastComputedUtilizationRate;
        uint64 lastComputedTimestamp;
        uint128 currentUtilizationRate;
        uint256 utilization;
    }
}

interface PerpMarketConfiguration {
    struct GlobalData {
        address pyth;
        bytes32 ethOracleNodeId;
        address rewardDistributorImplementation;
        uint64 pythPublishTimeMin;
        uint64 pythPublishTimeMax;
        uint64 minOrderAge;
        uint64 maxOrderAge;
        uint256 minKeeperFeeUsd;
        uint256 maxKeeperFeeUsd;
        uint128 keeperProfitMarginUsd;
        uint128 keeperProfitMarginPercent;
        uint128 keeperSettlementGasUnits;
        uint128 keeperCancellationGasUnits;
        uint128 keeperLiquidationGasUnits;
        uint128 keeperFlagGasUnits;
        uint128 keeperLiquidateMarginGasUnits;
        address keeperLiquidationEndorsed;
        uint128 collateralDiscountScalar;
        uint128 minCollateralDiscount;
        uint128 maxCollateralDiscount;
        uint128 utilizationBreakpointPercent;
        uint128 lowUtilizationSlopePercent;
        uint128 highUtilizationSlopePercent;
    }

    struct Data {
        bytes32 oracleNodeId;
        bytes32 pythPriceFeedId;
        uint128 makerFee;
        uint128 takerFee;
        uint128 maxMarketSize;
        uint128 maxFundingVelocity;
        uint128 skewScale;
        uint128 fundingVelocityClamp;
        uint128 minCreditPercent;
        uint256 minMarginUsd;
        uint256 minMarginRatio;
        uint256 incrementalMarginScalar;
        uint256 maintenanceMarginScalar;
        uint256 maxInitialMarginRatio;
        uint256 liquidationRewardPercent;
        uint128 liquidationLimitScalar;
        uint128 liquidationWindowDuration;
        uint128 liquidationMaxPd;
    }
}

interface IMarketConfigurationModule {
    struct GlobalMarketConfigureParameters {
        uint64 pythPublishTimeMin;
        uint64 pythPublishTimeMax;
        uint64 minOrderAge;
        uint64 maxOrderAge;
        uint256 minKeeperFeeUsd;
        uint256 maxKeeperFeeUsd;
        uint128 keeperProfitMarginPercent;
        uint128 keeperProfitMarginUsd;
        uint128 keeperSettlementGasUnits;
        uint128 keeperCancellationGasUnits;
        uint128 keeperLiquidationGasUnits;
        uint128 keeperFlagGasUnits;
        uint128 keeperLiquidateMarginGasUnits;
        address keeperLiquidationEndorsed;
        uint128 collateralDiscountScalar;
        uint128 minCollateralDiscount;
        uint128 maxCollateralDiscount;
        uint128 utilizationBreakpointPercent;
        uint128 lowUtilizationSlopePercent;
        uint128 highUtilizationSlopePercent;
    }

    struct ConfigureByMarketParameters {
        uint128 marketId;
        bytes32 oracleNodeId;
        bytes32 pythPriceFeedId;
        uint128 makerFee;
        uint128 takerFee;
        uint128 maxMarketSize;
        uint128 maxFundingVelocity;
        uint128 skewScale;
        uint128 fundingVelocityClamp;
        uint128 minCreditPercent;
        uint256 minMarginUsd;
        uint256 minMarginRatio;
        uint256 incrementalMarginScalar;
        uint256 maintenanceMarginScalar;
        uint256 maxInitialMarginRatio;
        uint256 liquidationRewardPercent;
        uint128 liquidationLimitScalar;
        uint128 liquidationWindowDuration;
        uint128 liquidationMaxPd;
    }
}

interface IPerpAccountModule {
    struct DepositedCollateral {
        address collateralAddress;
        uint256 available;
        uint256 oraclePrice;
    }

    struct PositionDigest {
        uint128 accountId;
        uint128 marketId;
        uint256 remainingMarginUsd;
        uint256 healthFactor;
        uint256 notionalValueUsd;
        int256 pnl;
        int128 accruedFunding;
        uint128 accruedUtilization;
        uint256 entryPythPrice;
        uint256 entryPrice;
        uint256 oraclePrice;
        int128 size;
        uint256 im;
        uint256 mm;
    }

    struct AccountDigest {
        DepositedCollateral[] depositedCollaterals;
        uint256 collateralUsd;
        uint128 debtUsd;
        PositionDigest position;
    }
}

interface IMarginModule {
    struct ConfiguredCollateral {
        address collateralAddress;
        bytes32 oracleNodeId;
        uint128 maxAllowable;
        uint128 skewScale;
        address rewardDistributor;
    }
}

interface Margin {
    struct MarginValues {
        uint256 discountedMarginUsd;
        uint256 marginUsd;
        uint256 discountedCollateralUsd;
        uint256 collateralUsd;
    }
}

interface IOrderModule {
    struct OrderDigest {
        int128 sizeDelta;
        uint64 commitmentTime;
        uint256 limitPrice;
        uint128 keeperFeeBufferUsd;
        address[] hooks;
        bool isStale;
        bool isReady;
    }
}

interface IPerpRewardDistributorFactoryModule {
    struct CreatePerpRewardDistributorParameters {
        uint128 poolId;
        address[] collateralTypes;
        string name;
        address token;
    }
}

interface ISettlementHookModule {
    struct SettlementHookConfigureParameters {
        address[] whitelistedHookAddresses;
        uint32 maxHooksPerOrder;
    }
}
