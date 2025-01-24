// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IPythERC7412Wrapper {
    error FeeRequired(uint256 amount);
    error NotSupported(uint8 updateType);
    error OnlyOnDevFork();
    error OracleDataRequired(address oracleContract, bytes oracleQuery);
    error OverflowInt256ToUint256();
    error OverflowUint256ToInt256();
    event ForkBenchmarkPriceSet(bytes32 priceId, uint64 requestedTime, int256 newPrice, int32 expo);
    event ForkLatestPriceSet(bytes32 priceId, int256 newPrice);
    function fulfillOracleQuery(bytes memory signedOffchainData) external payable;
    function getBenchmarkPrice(bytes32 priceId, uint64 requestedTime) external view returns (int256);
    function getLatestPrice(bytes32 priceId, uint256 stalenessTolerance) external view returns (int256);
    function oracleId() external pure returns (bytes32);
    function pythAddress() external view returns (address);
    function setBenchmarkPrice(bytes32 priceId, uint64 requestedTime, int256 newPrice, int32 expo) external;
    function setLatestPrice(bytes32 priceId, int256 newPrice) external;
}
