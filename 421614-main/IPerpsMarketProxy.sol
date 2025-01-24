// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IPerpsMarketProxy {
    function facets() external pure returns (S_0[] memory);
    function facetFunctionSelectors(address facet) external pure returns (bytes4[] memory functionSelectors);
    function facetAddresses() external pure returns (address[] memory addresses);
    function facetAddress(bytes4 functionSelector) external pure returns (address);
    function emitDiamondCutEvent() external returns (bool);
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
    error InvalidMarket(uint128 marketId);
    error InvalidParameter(string parameter, string reason);
    error OverflowInt256ToUint256();
    error OverflowUint256ToInt256();
    error OverflowUint256ToUint128();
    error PerpsMarketAlreadyInitialized();
    error PerpsMarketNotInitialized();
    event FactoryInitialized(uint128 globalPerpsMarketId);
    event MarketCreated(uint128 indexed perpsMarketId, string marketName, string marketSymbol);
    function createMarket(uint128 requestedMarketId, string memory marketName, string memory marketSymbol) external returns (uint128);
    function initializeFactory(address synthetix, address spotMarket) external returns (uint128);
    function interestRate() external view returns (uint128);
    function minimumCredit(uint128 perpsMarketId) external view returns (uint256);
    function name(uint128 perpsMarketId) external view returns (string memory);
    function reportedDebt(uint128 perpsMarketId) external view returns (uint256);
    function setPerpsMarketName(string memory marketName) external;
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function utilizationRate() external view returns (uint256 rate, uint256 delegatedCollateral, uint256 lockedCredit);
    error AccountLiquidatable(uint128 accountId);
    error AccountNotFound(uint128 accountId);
    error InsufficientCollateral(uint128 collateralId, uint256 collateralAmount, uint256 withdrawAmount);
    error InsufficientCollateralAvailableForWithdraw(int256 withdrawableMarginUsd, uint256 requestedMarginUsd);
    error InsufficientSynthCollateral(uint128 collateralId, uint256 collateralAmount, uint256 withdrawAmount);
    error InvalidAmountDelta(int256 amountDelta);
    error InvalidDistributor(uint128 collateralId);
    error InvalidId(uint128 id);
    error KeeperCostsNotSet();
    error MaxCollateralExceeded(uint128 collateralId, uint256 maxAmount, uint256 collateralAmount, uint256 depositAmount);
    error MaxCollateralsPerAccountReached(uint128 maxCollateralsPerAccount);
    error NonexistentDebt(uint128 accountId);
    error OverflowUint128ToInt128();
    error PendingOrderExists();
    error PriceFeedNotSet(uint128 marketId);
    error SynthNotEnabledForCollateral(uint128 collateralId);
    event CollateralModified(uint128 indexed accountId, uint128 indexed collateralId, int256 amountDelta, address indexed sender);
    event DebtPaid(uint128 indexed accountId, uint256 amount, address indexed sender);
    event InterestRateUpdated(uint128 indexed superMarketId, uint128 interestRate);
    function debt(uint128 accountId) external view returns (uint256 accountDebt);
    function getAccountCollateralIds(uint128 accountId) external view returns (uint256[] memory);
    function getAccountOpenPositions(uint128 accountId) external view returns (uint256[] memory);
    function getAvailableMargin(uint128 accountId) external view returns (int256 availableMargin);
    function getCollateralAmount(uint128 accountId, uint128 collateralId) external view returns (uint256);
    function getOpenPosition(uint128 accountId, uint128 marketId) external view returns (int256 totalPnl, int256 accruedFunding, int128 positionSize, uint256 owedInterest);
    function getOpenPositionSize(uint128 accountId, uint128 marketId) external view returns (int128 positionSize);
    function getRequiredMargins(uint128 accountId) external view returns (uint256 requiredInitialMargin, uint256 requiredMaintenanceMargin, uint256 maxLiquidationReward);
    function getWithdrawableMargin(uint128 accountId) external view returns (int256 withdrawableMargin);
    function modifyCollateral(uint128 accountId, uint128 collateralId, int256 amountDelta) external;
    function payDebt(uint128 accountId, uint256 amount) external;
    function totalAccountOpenInterest(uint128 accountId) external view returns (uint256);
    function totalCollateralValue(uint128 accountId) external view returns (uint256);
    function currentFundingRate(uint128 marketId) external view returns (int256);
    function currentFundingVelocity(uint128 marketId) external view returns (int256);
    function fillPrice(uint128 marketId, int128 orderSize, uint256 price) external view returns (uint256);
    function getMarketSummary(uint128 marketId) external view returns (IPerpsMarketModule.MarketSummary memory summary);
    function indexPrice(uint128 marketId) external view returns (uint256);
    function maxOpenInterest(uint128 marketId) external view returns (uint256);
    function metadata(uint128 marketId) external view returns (string memory name, string memory symbol);
    function size(uint128 marketId) external view returns (uint256);
    function skew(uint128 marketId) external view returns (int256);
    error ExceedsMarketCreditCapacity(int256 delegatedCollateral, int256 newLockedCredit);
    error InsufficientMargin(int256 availableMargin, uint256 minMargin);
    error InvalidSettlementStrategy(uint256 settlementStrategyId);
    error MaxOpenInterestReached(uint128 marketId, uint256 maxMarketSize, int256 newSideSize);
    error MaxPositionsPerAccountReached(uint128 maxPositionsPerAccount);
    error MaxUSDOpenInterestReached(uint128 marketId, uint256 maxMarketValue, int256 newSideSize, uint256 price);
    error OverflowInt256ToInt128();
    error ZeroSizeOrder();
    event OrderCommitted(uint128 indexed marketId, uint128 indexed accountId, uint8 orderType, int128 sizeDelta, uint256 acceptablePrice, uint256 commitmentTime, uint256 expectedPriceTime, uint256 settlementTime, uint256 expirationTime, bytes32 indexed trackingCode, address sender);
    event PreviousOrderExpired(uint128 indexed marketId, uint128 indexed accountId, int128 sizeDelta, uint256 acceptablePrice, uint256 commitmentTime, bytes32 indexed trackingCode);
    function commitOrder(AsyncOrder.OrderCommitmentRequest memory commitment) external returns (AsyncOrder.Data memory retOrder, uint256 fees);
    function computeOrderFees(uint128 marketId, int128 sizeDelta) external view returns (uint256 orderFees, uint256 fillPrice);
    function computeOrderFeesWithPrice(uint128 marketId, int128 sizeDelta, uint256 price) external view returns (uint256 orderFees, uint256 fillPrice);
    function getOrder(uint128 accountId) external view returns (AsyncOrder.Data memory order);
    function getSettlementRewardCost(uint128 marketId, uint128 settlementStrategyId) external view returns (uint256);
    function requiredMarginForOrder(uint128 accountId, uint128 marketId, int128 sizeDelta) external view returns (uint256 requiredMargin);
    function requiredMarginForOrderWithPrice(uint128 accountId, uint128 marketId, int128 sizeDelta, uint256 price) external view returns (uint256 requiredMargin);
    error AcceptablePriceExceeded(uint256 fillPrice, uint256 acceptablePrice);
    error OrderNotValid();
    error OverflowInt128ToUint128();
    error OverflowUint256ToUint64();
    error SettlementStrategyNotFound(uint8 strategyType);
    error SettlementWindowExpired(uint256 timestamp, uint256 settlementTime, uint256 settlementExpiration);
    error SettlementWindowNotOpen(uint256 timestamp, uint256 settlementTime);
    event AccountCharged(uint128 accountId, int256 amount, uint256 accountDebt);
    event InterestCharged(uint128 indexed accountId, uint256 interest);
    event MarketUpdated(uint128 marketId, uint256 price, int256 skew, uint256 size, int256 sizeDelta, int256 currentFundingRate, int256 currentFundingVelocity, uint128 interestRate);
    event OrderSettled(uint128 indexed marketId, uint128 indexed accountId, uint256 fillPrice, int256 pnl, int256 accruedFunding, int128 sizeDelta, int128 newSize, uint256 totalFees, uint256 referralFees, uint256 collectedFees, uint256 settlementReward, bytes32 indexed trackingCode, address settler);
    function settleOrder(uint128 accountId) external;
    error AcceptablePriceNotExceeded(uint256 fillPrice, uint256 acceptablePrice);
    event OrderCancelled(uint128 indexed marketId, uint128 indexed accountId, uint256 desiredPrice, uint256 fillPrice, int128 sizeDelta, uint256 settlementReward, bytes32 indexed trackingCode, address settler);
    function cancelOrder(uint128 accountId) external;
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
    error AccountHasOpenPositions(uint128 accountId);
    error InvalidDistributor(uint128 id, address distributor);
    error NotEligibleForLiquidation(uint128 accountId);
    error NotEligibleForMarginLiquidation(uint128 accountId);
    event AccountFlaggedForLiquidation(uint128 indexed accountId, int256 availableMargin, uint256 requiredMaintenanceMargin, uint256 liquidationReward, uint256 flagReward);
    event AccountLiquidationAttempt(uint128 indexed accountId, uint256 reward, bool fullLiquidation);
    event AccountMarginLiquidation(uint128 indexed accountId, uint256 seizedMarginValue, uint256 liquidationReward);
    event PositionLiquidated(uint128 indexed accountId, uint128 indexed marketId, uint256 amountLiquidated, int128 currentPositionSize);
    function canLiquidate(uint128 accountId) external view returns (bool isEligible);
    function canLiquidateMarginOnly(uint128 accountId) external view returns (bool isEligible);
    function flaggedAccounts() external view returns (uint256[] memory accountIds);
    function liquidate(uint128 accountId) external returns (uint256 liquidationReward);
    function liquidateFlagged(uint256 maxNumberOfAccounts) external returns (uint256 liquidationReward);
    function liquidateFlaggedAccounts(uint128[] memory accountIds) external returns (uint256 liquidationReward);
    function liquidateMarginOnly(uint128 accountId) external returns (uint256 liquidationReward);
    function liquidationCapacity(uint128 marketId) external view returns (uint256 capacity, uint256 maxLiquidationInWindow, uint256 latestLiquidationTimestamp);
    error InvalidSettlementWindowDuration(uint256 duration);
    event FundingParametersSet(uint128 indexed marketId, uint256 skewScale, uint256 maxFundingVelocity);
    event LiquidationParametersSet(uint128 indexed marketId, uint256 initialMarginRatioD18, uint256 maintenanceMarginRatioD18, uint256 minimumInitialMarginRatioD18, uint256 flagRewardRatioD18, uint256 minimumPositionMargin);
    event LockedOiRatioSet(uint128 indexed marketId, uint256 lockedOiRatioD18);
    event MarketPriceDataUpdated(uint128 indexed marketId, bytes32 feedId, uint256 strictStalenessTolerance);
    event MaxLiquidationParametersSet(uint128 indexed marketId, uint256 maxLiquidationLimitAccumulationMultiplier, uint256 maxSecondsInLiquidationWindow, uint256 maxLiquidationPd, address endorsedLiquidator);
    event MaxMarketSizeSet(uint128 indexed marketId, uint256 maxMarketSize);
    event MaxMarketValueSet(uint128 indexed marketId, uint256 maxMarketValue);
    event OrderFeesSet(uint128 indexed marketId, uint256 makerFeeRatio, uint256 takerFeeRatio);
    event SettlementStrategyAdded(uint128 indexed marketId, SettlementStrategy.Data strategy, uint256 indexed strategyId);
    event SettlementStrategySet(uint128 indexed marketId, uint256 indexed strategyId, SettlementStrategy.Data strategy);
    function addSettlementStrategy(uint128 marketId, SettlementStrategy.Data memory strategy) external returns (uint256 strategyId);
    function getFundingParameters(uint128 marketId) external view returns (uint256 skewScale, uint256 maxFundingVelocity);
    function getLiquidationParameters(uint128 marketId) external view returns (uint256 initialMarginRatioD18, uint256 minimumInitialMarginRatioD18, uint256 maintenanceMarginScalarD18, uint256 flagRewardRatioD18, uint256 minimumPositionMargin);
    function getLockedOiRatio(uint128 marketId) external view returns (uint256);
    function getMaxLiquidationParameters(uint128 marketId) external view returns (uint256 maxLiquidationLimitAccumulationMultiplier, uint256 maxSecondsInLiquidationWindow, uint256 maxLiquidationPd, address endorsedLiquidator);
    function getMaxMarketSize(uint128 marketId) external view returns (uint256 maxMarketSize);
    function getMaxMarketValue(uint128 marketId) external view returns (uint256 maxMarketValue);
    function getOrderFees(uint128 marketId) external view returns (uint256 makerFee, uint256 takerFee);
    function getPriceData(uint128 perpsMarketId) external view returns (bytes32 feedId, uint256 strictStalenessTolerance);
    function getSettlementStrategy(uint128 marketId, uint256 strategyId) external view returns (SettlementStrategy.Data memory settlementStrategy);
    function setFundingParameters(uint128 marketId, uint256 skewScale, uint256 maxFundingVelocity) external;
    function setLiquidationParameters(uint128 marketId, uint256 initialMarginRatioD18, uint256 minimumInitialMarginRatioD18, uint256 maintenanceMarginScalarD18, uint256 flagRewardRatioD18, uint256 minimumPositionMargin) external;
    function setLockedOiRatio(uint128 marketId, uint256 lockedOiRatioD18) external;
    function setMaxLiquidationParameters(uint128 marketId, uint256 maxLiquidationLimitAccumulationMultiplier, uint256 maxSecondsInLiquidationWindow, uint256 maxLiquidationPd, address endorsedLiquidator) external;
    function setMaxMarketSize(uint128 marketId, uint256 maxMarketSize) external;
    function setMaxMarketValue(uint128 marketId, uint256 maxMarketValue) external;
    function setOrderFees(uint128 marketId, uint256 makerFeeRatio, uint256 takerFeeRatio) external;
    function setSettlementStrategy(uint128 marketId, uint256 strategyId, SettlementStrategy.Data memory strategy) external;
    function setSettlementStrategyEnabled(uint128 marketId, uint256 strategyId, bool enabled) external;
    function updatePriceData(uint128 perpsMarketId, bytes32 feedId, uint256 strictStalenessTolerance) external;
    error InvalidDistributorContract(address distributor);
    event CollateralConfigurationSet(uint128 indexed collateralId, uint256 maxCollateralAmount, uint256 upperLimitDiscount, uint256 lowerLimitDiscount, uint256 discountScalar);
    event CollateralLiquidateRewardRatioSet(uint128 collateralLiquidateRewardRatioD18);
    event RewardDistributorRegistered(address distributor);
    function getCollateralConfiguration(uint128 collateralId) external view returns (uint256 maxCollateralAmount);
    function getCollateralConfigurationFull(uint128 collateralId) external view returns (uint256 maxCollateralAmount, uint256 upperLimitDiscount, uint256 lowerLimitDiscount, uint256 discountScalar);
    function getCollateralLiquidateRewardRatio() external view returns (uint128 collateralLiquidateRewardRatioD18);
    function getRegisteredDistributor(uint128 collateralId) external view returns (address distributor, address[] memory poolDelegatedCollateralTypes);
    function isRegistered(address distributor) external view returns (bool);
    function registerDistributor(address token, address distributor, uint128 collateralId, address[] memory poolDelegatedCollateralTypes) external;
    function setCollateralConfiguration(uint128 collateralId, uint256 maxCollateralAmount, uint256 upperLimitDiscount, uint256 lowerLimitDiscount, uint256 discountScalar) external;
    function setCollateralLiquidateRewardRatio(uint128 collateralLiquidateRewardRatioD18) external;
    error InvalidFeeCollectorInterface(address invalidFeeCollector);
    error InvalidInterestRateParameters(uint128 lowUtilizationInterestRateGradient, uint128 highUtilizationInterestRateGradient);
    error InvalidReferrerShareRatio(uint256 shareRatioD18);
    event FeeCollectorSet(address feeCollector);
    event InterestRateParametersSet(uint256 lowUtilizationInterestRateGradient, uint256 interestRateGradientBreakpoint, uint256 highUtilizationInterestRateGradient);
    event KeeperCostNodeIdUpdated(bytes32 keeperCostNodeId);
    event KeeperRewardGuardsSet(uint256 minKeeperRewardUsd, uint256 minKeeperProfitRatioD18, uint256 maxKeeperRewardUsd, uint256 maxKeeperScalingRatioD18);
    event PerAccountCapsSet(uint128 maxPositionsPerAccount, uint128 maxCollateralsPerAccount);
    event ReferrerShareUpdated(address referrer, uint256 shareRatioD18);
    function getFeeCollector() external view returns (address feeCollector);
    function getInterestRateParameters() external view returns (uint128 lowUtilizationInterestRateGradient, uint128 interestRateGradientBreakpoint, uint128 highUtilizationInterestRateGradient);
    function getKeeperCostNodeId() external view returns (bytes32 keeperCostNodeId);
    function getKeeperRewardGuards() external view returns (uint256 minKeeperRewardUsd, uint256 minKeeperProfitRatioD18, uint256 maxKeeperRewardUsd, uint256 maxKeeperScalingRatioD18);
    function getMarkets() external view returns (uint256[] memory marketIds);
    function getPerAccountCaps() external view returns (uint128 maxPositionsPerAccount, uint128 maxCollateralsPerAccount);
    function getReferrerShare(address referrer) external view returns (uint256 shareRatioD18);
    function getSupportedCollaterals() external view returns (uint256[] memory supportedCollaterals);
    function globalCollateralValue(uint128 collateralId) external view returns (uint256 collateralValue);
    function setFeeCollector(address feeCollector) external;
    function setInterestRateParameters(uint128 lowUtilizationInterestRateGradient, uint128 interestRateGradientBreakpoint, uint128 highUtilizationInterestRateGradient) external;
    function setKeeperRewardGuards(uint256 minKeeperRewardUsd, uint256 minKeeperProfitRatioD18, uint256 maxKeeperRewardUsd, uint256 maxKeeperScalingRatioD18) external;
    function setPerAccountCaps(uint128 maxPositionsPerAccount, uint128 maxCollateralsPerAccount) external;
    function totalGlobalCollateralValue() external view returns (uint256 totalCollateralValue);
    function updateInterestRate() external;
    function updateKeeperCostNodeId(bytes32 keeperCostNodeId) external;
    function updateReferrerShare(address referrer, uint256 shareRatioD18) external;
}

interface IAccountModule {
    struct AccountPermissions {
        address user;
        bytes32[] permissions;
    }
}

interface IPerpsMarketModule {
    struct MarketSummary {
        int256 skew;
        uint256 size;
        uint256 maxOpenInterest;
        int256 currentFundingRate;
        int256 currentFundingVelocity;
        uint256 indexPrice;
    }
}

interface AsyncOrder {
    struct OrderCommitmentRequest {
        uint128 marketId;
        uint128 accountId;
        int128 sizeDelta;
        uint128 settlementStrategyId;
        uint256 acceptablePrice;
        bytes32 trackingCode;
        address referrer;
    }

    struct Data {
        uint256 commitmentTime;
        OrderCommitmentRequest request;
    }
}

interface SettlementStrategy {
    struct Data {
        uint8 strategyType;
        uint256 settlementDelay;
        uint256 settlementWindowDuration;
        address priceVerificationContract;
        bytes32 feedId;
        uint256 settlementReward;
        bool disabled;
        uint256 commitmentPriceDelay;
    }
}

struct S_0 {
    address facetAddress;
    bytes4[] functionSelectors;
}
