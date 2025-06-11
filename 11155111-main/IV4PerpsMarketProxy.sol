// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IV4PerpsMarketProxy {
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
    function acceptOwnership() external;
    function getImplementation() external view returns (address);
    function nominateNewOwner(address newNominatedOwner) external;
    function nominatedOwner() external view returns (address);
    function owner() external view returns (address);
    function renounceNomination() external;
    function simulateUpgradeTo(address newImplementation) external;
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function upgradeTo(address newImplementation) external;
    event OwnerChanged(address oldOwner, address newOwner);
    event OwnerNominated(address newOwner);
    event Upgraded(address indexed self, address implementation);
    error ImplementationIsSterile(address implementation);
    error NoChange();
    error NotAContract(address contr);
    error NotNominated(address addr);
    error UpgradeSimulationFailed();

    function accountProxy() external view returns (address);
    function createMarket(uint128 requestedMarketId, string memory marketName, string memory marketSymbol) external returns (uint128);
    function depositMarketCollateral(address collateral, uint256 amount) external;
    function generalName() external view returns (bytes32);
    function interestRate() external view returns (uint128);
    function minimumCredit(uint128 marketId) external view returns (uint256);
    function name(uint128 marketId) external view returns (string memory);
    function oracle() external view returns (address);
    function perpsMarketId() external view returns (uint128);
    function reportedDebt(uint128 marketId) external view returns (uint256);
    function spotMarket() external view returns (address);
    function synthetix() external view returns (address);
    function totalWithdrawableUsd() external view returns (uint256);
    function usdToken() external view returns (address);
    function utilizationRate() external view returns (uint256 rate, uint256 delegatedCollateral, uint256 lockedCredit);
    function withdrawMarketUsd(address to, uint256 amount) external;
    event FactoryInitialized(uint128 globalPerpsMarketId);
    event MarketCreated(uint128 indexed perpsMarketId, string marketName, string marketSymbol);
    error InvalidMarket(uint128 marketId);
    error InvalidParameter(string parameter, string reason);
    error OverflowInt256ToUint256();
    error OverflowUint256ToInt256();
    error OverflowUint256ToUint128();
    error PerpsMarketAlreadyInitialized();
    error PerpsMarketNotInitialized();

    function debt(uint128 accountId) external view returns (uint256 accountDebt);
    function depositCollateral(uint128 accountId, uint128 collateralId, uint256 amount) external;
    function getAccountAllCollateralAmounts(uint128 accountId) external view returns (uint256[] memory collateralIds, uint256[] memory collateralAmounts, uint256 accountDebt);
    function getAccountCollateralIds(uint128 accountId) external view returns (uint256[] memory);
    function getAccountFullPositionInfo(uint128 accountId) external view returns (IPerpsAccountModule.DetailedPosition[] memory detailedPositions);
    function getAccountOpenPositions(uint128 accountId) external view returns (uint256[] memory);
    function getAvailableMargin(uint128 accountId) external view returns (int256 availableMargin);
    function getCollateralAmount(uint128 accountId, uint128 collateralId) external view returns (uint256);
    function getOpenPosition(uint128 accountId, uint128 marketId) external view returns (int256 totalPnl, int128 positionSize, uint256 owedInterest);
    function getOpenPositionSize(uint128 accountId, uint128 marketId) external view returns (int128 positionSize);
    function getRequiredMargins(uint128 accountId) external view returns (uint256 requiredInitialMargin, uint256 requiredMaintenanceMargin, uint256 maxLiquidationReward);
    function getWithdrawableMargin(uint128 accountId) external view returns (int256 withdrawableMargin);
    function payDebt(uint128 accountId, uint256 amount) external;
    function processSlowWithdraw(uint128 accountId, uint128 collateralId) external;
    function requestSlowWithdraw(uint128 accountId, uint128 collateralId, uint256 amount) external;
    function totalAccountOpenInterest(uint128 accountId) external view returns (uint256);
    function totalCollateralValue(uint128 accountId) external view returns (uint256 totalValue);
    event CollateralDeposited(uint128 indexed accountId, uint128 indexed collateralId, uint256 amountDeposited, uint256 totalAmount, address indexed sender);
    event DebtPaid(uint128 indexed accountId, uint256 amount, address indexed sender);
    event InterestRateUpdated(uint128 indexed superMarketId, uint128 interestRate);
    event SlowWithdrawExecuted(uint128 indexed accountId, uint128 indexed collateralId, uint256 amount, uint256 amountRemaining, address indexed sender);
    event SlowWithdrawRequested(uint128 indexed accountId, uint128 indexed collateralId, uint256 amount, uint256 amountRemaining, address indexed sender);
    error AccountLiquidatable(uint128 accountId);
    error AccountNotFound(uint128 accountId);
    error InsufficientCollateral(uint128 collateralId, uint256 collateralAmount, uint256 withdrawAmount);
    error InsufficientCollateralAvailableForWithdraw(int256 withdrawableMarginUsd, uint256 requestedMarginUsd);
    error InsufficientSynthCollateral(uint128 collateralId, uint256 collateralAmount, uint256 withdrawAmount);
    error InvalidDistributor(uint128 collateralId);
    error MaxCollateralExceeded(uint128 collateralId, uint256 maxAmount, uint256 collateralAmount, uint256 depositAmount);
    error MaxCollateralsPerAccountReached(uint128 maxCollateralsPerAccount);
    error NonexistentDebt(uint128 accountId);
    error OverflowUint128ToInt128();
    error SizeDeltaIsZero();
    error SynthNotEnabledForCollateral(uint128 collateralId);
    error WithdrawTimeoutHasNotPassed();
    function getAccountOwnerV4(uint128 accountId) external view returns (address);
    function getAccountPermissionsV4(uint128 accountId) external view returns (address[] memory accountPerms);
    function grantPermissionV4(uint128 accountId, bytes32 permission, address user) external;
    function hasPermissionV4(uint128 accountId, bytes32 permission, address user) external view returns (bool);
    function isAuthorizedV4(uint128 accountId, bytes32 permission, address target) external view returns (bool);
    function revokePermissionV4(uint128 accountId, bytes32 permission, address user) external;
    event PermissionGrantedV4(uint128 indexed accountId, bytes32 indexed permission, address indexed user, address sender);
    event PermissionRevokedV4(uint128 indexed accountId, bytes32 indexed permission, address indexed user, address sender);
    error UnauthorizedPermission(uint128 accountId, bytes32 permission);
    function currentFundingRate(uint128 marketId) external view returns (int256);
    function fillPrice(uint128 marketId, int128 orderSize, uint256 price) external view returns (uint256);
    function getMarketSummary(uint128 marketId) external view returns (IPerpsMarketModule.MarketSummary memory summary);
    function indexPrice(uint128 marketId) external view returns (uint256);
    function maxOpenInterest(uint128 marketId) external view returns (uint256);
    function metadata(uint128 marketId) external view returns (string memory name, string memory symbol);
    function size(uint128 marketId) external view returns (uint256);

    function SIGNED_BOOK_ORDER_TYPEHASH() external view returns (bytes32);
    function eip712Domain() external view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
    function settleBookOrders(uint128 marketId, IBookOrderModule.BookOrder[] memory orders) external;
    event AccountCharged(uint128 accountId, int256 amount, uint256 accountDebt);
    event BookOrderSettled(uint128 indexed marketId, IBookOrderModule.BookOrder[] orders, uint256 totalCollectedFees);
    event DoneLoop(uint128 accountId);
    event EIP712DomainChanged();
    event InterestCharged(uint128 indexed accountId, uint256 interest);
    event ItsGreater(uint128 accountId, uint128 cmpAccountId);
    event MarketUpdated(uint128 marketId, uint256 price, uint256 size, int256 sizeDelta, int256 currentFundingRate, uint128 interestRate);
    event OrderSettled(uint128 indexed marketId, uint128 indexed accountId, uint256 fillPrice, int256 pnl, int256 accruedFunding, int128 sizeDelta, int128 newSize, uint256 totalFees, uint256 referralFees, uint256 collectedFees, uint256 settlementReward, bytes32 indexed trackingCode, address settler);
    error InvalidFillPrice(int128 sizeDelta, uint128 orderPrice, uint256 filledPrice);
    error InvalidShortString();
    error NonceAlreadyUsed(uint64 nonce);
    error OverflowInt128ToUint128();
    error StringTooLong(string str);
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
    event FeatureFlagAllowAllSet(bytes32 indexed feature, bool allowAll);
    event FeatureFlagAllowlistAdded(bytes32 indexed feature, address account);
    event FeatureFlagAllowlistRemoved(bytes32 indexed feature, address account);
    event FeatureFlagDeniersReset(bytes32 indexed feature, address[] deniers);
    event FeatureFlagDenyAllSet(bytes32 indexed feature, bool denyAll);
    function canLiquidate(uint128 accountId, uint256[] memory positionPrices) external view returns (bool isEligible);
    function liquidate(uint128 accountId, uint256[] memory positionPrices, bool isLarge) external;
    event AccountLiquidationAttempt(uint128 indexed accountId, uint256 reward, bool fullLiquidation);
    event AccountMarginLiquidation(uint128 indexed accountId, uint256 seizedMarginValue, uint256 liquidationReward);
    event PositionLiquidated(uint128 indexed accountId, uint128 indexed marketId, uint256 amountLiquidated, int128 currentPositionSize);
    error AccountHasOpenPositions(uint128 accountId);
    error NoPositionsOpen();
    error NotEligibleForLiquidation(uint128 accountId);
    error NotEligibleForMarginLiquidation(uint128 accountId);

    function calculateRequiredMargins(int128 size, uint256 price) external view returns (uint256 initialMarginRatio, uint256 maintenanceMarginRatio, uint256 initialMargin, uint256 maintenanceMargin);
    function getLiquidationParameters() external view returns (uint256 _initialMarginRatioD18, uint256 _minimumInitialMarginRatioD18, uint256 _maintenanceMarginScalarD18, uint256 _minimumPositionMargin);
    function getLockedOiRatio() external view returns (uint256 _lockedOiRatioD18);
    function getMaxLiquidationParameters() external view returns (uint256 _maxLiquidationLimitAccumulationMultiplier, uint256 _maxSecondsInLiquidationWindow, uint256 _maxLiquidationPd);
    function getMaxMarketSize() external view returns (uint256 _maxMarketSize);
    function getMaxMarketValue() external view returns (uint256 _maxMarketValue);
    function getOrderFees() external view returns (uint256 _makerFee, uint256 _takerFee);
    function initialMarginRatioD18() external view returns (uint256);
    function lockedOiRatioD18() external view returns (uint256);
    function maintenanceMarginScalarD18() external view returns (uint256);
    function makerFee() external view returns (uint256);
    function maxLiquidationAmountInWindow() external view returns (uint256);
    function maxLiquidationLimitAccumulationMultiplier() external view returns (uint256);
    function maxLiquidationPd() external view returns (uint256);
    function maxMarketSize() external view returns (uint256);
    function maxMarketValue() external view returns (uint256);
    function maxSecondsInLiquidationWindow() external view returns (uint256);
    function minimumInitialMarginRatioD18() external view returns (uint256);
    function minimumPositionMargin() external view returns (uint256);
    function takerFee() external view returns (uint256);
    event LiquidationParametersSet(uint128 indexed marketId, uint256 initialMarginRatioD18, uint256 maintenanceMarginRatioD18, uint256 minimumInitialMarginRatioD18, uint256 minimumPositionMargin);
    event LockedOiRatioSet(uint128 indexed marketId, uint256 lockedOiRatioD18);
    event MarketPriceDataUpdated(uint128 indexed marketId, bytes32 feedId, uint256 strictStalenessTolerance);
    event MaxLiquidationParametersSet(uint128 indexed marketId, uint256 maxLiquidationLimitAccumulationMultiplier, uint256 maxSecondsInLiquidationWindow, uint256 maxLiquidationPd);
    event MaxMarketSizeSet(uint128 indexed marketId, uint256 maxMarketSize);
    event MaxMarketValueSet(uint128 indexed marketId, uint256 maxMarketValue);
    event OrderFeesSet(uint128 indexed marketId, uint256 makerFeeRatio, uint256 takerFeeRatio);
    error InvalidSettlementStrategy(uint256 settlementStrategyId);
    error InvalidSettlementWindowDuration(uint256 duration);
    error MaxOpenInterestReached(uint128 marketId, uint256 maxMarketSize, int256 newSideSize);
    error MaxUSDOpenInterestReached(uint128 marketId, uint256 maxMarketValue, int256 newSideSize, uint256 price);
    function getCollateralConfiguration(uint128 collateralId) external view returns (uint256 maxCollateralAmount);
    function getCollateralConfigurationFull(uint128 collateralId) external view returns (uint256 maxCollateralAmount, uint256 upperLimitDiscount, uint256 lowerLimitDiscount, uint256 discountScalar);
    function getCollateralLiquidateRewardRatio() external view returns (uint128 collateralLiquidateRewardRatioD18);
    event CollateralConfigurationSet(uint128 indexed collateralId, uint256 maxCollateralAmount, uint256 upperLimitDiscount, uint256 lowerLimitDiscount, uint256 discountScalar);
    event CollateralLiquidateRewardRatioSet(uint128 collateralLiquidateRewardRatioD18);
    event RewardDistributorRegistered(address distributor);

    function calculateCollateralLiquidateReward(uint256 notionalValue) external view returns (uint256);
    function collateralLiquidateRewardRatioD18() external view returns (uint128);
    function collateralToken() external view returns (address);
    function collectFees(uint256 orderFees, address referrer, address factory) external returns (uint256 referralFees, uint256 feeCollectorFees);
    function feeCollector() external view returns (address);
    function getFeeCollector() external view returns (address _feeCollector);
    function getInterestRateParameters() external view returns (uint128 _lowUtilizationInterestRateGradient, uint128 _interestRateGradientBreakpoint, uint128 _highUtilizationInterestRateGradient);
    function getMarkets() external view returns (uint256[] memory marketIds);
    function getPerAccountCaps() external view returns (uint128 maxPositionsPerAccount, uint128 maxCollateralsPerAccount);
    function globalCollateralValue(uint128 collateralId) external view returns (uint256 collateralValue);
    function highUtilizationInterestRateGradient() external view returns (uint128);
    function initializeFactory(address _marketFactory) external;
    function interestRateGradientBreakpoint() external view returns (uint128);
    function loadInterestRateParameters() external view returns (uint128 _lowUtilizationInterestRateGradient, uint128 _interestRateGradientBreakpoint, uint128 _highUtilizationInterestRateGradient);
    function lowUtilizationInterestRateGradient() external view returns (uint128);
    function marketFactory() external view returns (address);
    function maxCollateralsPerAccount() external view returns (uint128);
    function maxPositionsPerAccount() external view returns (uint128);
    function rewardDistributorImplementation() external view returns (address);
    function setFeeCollector(address feeCollector) external;
    function updateInterestRate() external;
    function withdrawTimeout() external view returns (uint256);
    event FeeCollectorSet(address feeCollector);
    event InterestRateParametersSet(uint256 lowUtilizationInterestRateGradient, uint256 interestRateGradientBreakpoint, uint256 highUtilizationInterestRateGradient);
    event KeeperCostNodeIdUpdated(bytes32 keeperCostNodeId);
    event PerAccountCapsSet(uint128 maxPositionsPerAccount, uint128 maxCollateralsPerAccount);
    event ReferrerShareUpdated(address referrer, uint256 shareRatioD18);
    error InvalidFeeCollectorInterface(address invalidFeeCollector);
    error InvalidInterestRateParameters(uint128 lowUtilizationInterestRateGradient, uint128 highUtilizationInterestRateGradient);
    error InvalidReferrerShareRatio(uint256 shareRatioD18);
}

interface IAccountModule {
    struct AccountPermissions {
        address user;
        bytes32[] permissions;
    }
}

interface IPerpsAccountModule {
    struct DetailedPosition {
        uint128 marketId;
        int256 size;
        int256 pnl;
        int256 accruedFunding;
        uint256 chargedInterest;
        uint256 currentPrice;
        uint256 entryPrice;
        uint256 requiredInitialMargin;
        uint256 requiredMaintenanceMargin;
        string marketName;
        string marketSymbol;
    }
}

interface IPerpsMarketModule {
    struct MarketSummary {
        uint256 size;
        uint256 maxOpenInterest;
        int256 currentFundingRate;
        uint256 indexPrice;
    }
}

interface IBookOrderModule {
    struct SignedBookOrder {
        bytes32 symbol;
        uint128 accountId;
        int128 sizeDelta;
        uint128 orderPrice;
        uint64 expiration;
        uint64 nonce;
    }

    struct BookOrder {
        SignedBookOrder signedOrder;
        uint256 filledPrice;
        bytes32 trackingCode;
        bytes signature;
    }
}

struct S_0 {
    address facetAddress;
    bytes4[] functionSelectors;
}
