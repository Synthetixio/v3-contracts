// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ITrustedMulticallForwarder {
    error AddressInsufficientBalance(address account);
    error ERC2771ForwarderExpiredRequest(uint48 deadline);
    error ERC2771ForwarderInvalidSigner(address signer, address from);
    error ERC2771ForwarderMismatchedValue(uint256 requestedValue, uint256 msgValue);
    error ERC2771UntrustfulTarget(address target, address forwarder);
    error FailedInnerCall();
    error InvalidAccountNonce(address account, uint256 currentNonce);
    error InvalidShortString();
    error StringTooLong(string str);
    event EIP712DomainChanged();
    event ExecutedForwardRequest(address indexed signer, uint256 nonce, bool success);
    function aggregate(S_0[] memory calls) external returns (uint256 blockNumber, bytes[] memory returnData);
    function aggregate3(S_1[] memory calls) external payable returns (S_2[] memory returnData);
    function aggregate3Value(S_3[] memory calls) external payable returns (S_2[] memory returnData);
    function blockAndAggregate(S_0[] memory calls) external payable returns (uint256 blockNumber, bytes32 blockHash, S_2[] memory returnData);
    function eip712Domain() external view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
    function execute(S_4 memory request) external payable;
    function executeBatch(S_4[] memory requests) external payable returns (S_2[] memory returnData);
    function executeBatch(S_4[] memory requests, address refundReceiver) external payable;
    function getBasefee() external view returns (uint256 basefee);
    function getBlockHash(uint256 blockNumber) external view returns (bytes32 blockHash);
    function getBlockNumber() external view returns (uint256 blockNumber);
    function getChainId() external view returns (uint256 chainid);
    function getCurrentBlockCoinbase() external view returns (address coinbase);
    function getCurrentBlockGasLimit() external view returns (uint256 gaslimit);
    function getCurrentBlockTimestamp() external view returns (uint256 timestamp);
    function getEthBalance(address addr) external view returns (uint256 balance);
    function getLastBlockHash() external view returns (bytes32 blockHash);
    function getPrevRandao() external view returns (uint256 prevrandao);
    function nonces(address owner) external view returns (uint256);
    function tryAggregate(bool requireSuccess, S_0[] memory calls) external returns (S_2[] memory returnData);
    function tryBlockAndAggregate(bool requireSuccess, S_0[] memory calls) external payable returns (uint256 blockNumber, bytes32 blockHash, S_2[] memory returnData);
    function verify(S_4 memory request) external view returns (bool);
}

struct S_0 {
    address target;
    bytes callData;
}

struct S_1 {
    address target;
    bool requireSuccess;
    bytes callData;
}

struct S_2 {
    bool success;
    bytes returnData;
}

struct S_3 {
    address target;
    bool requireSuccess;
    uint256 value;
    bytes callData;
}

struct S_4 {
    address from;
    address to;
    uint256 value;
    uint256 gas;
    uint48 deadline;
    bytes data;
    bytes signature;
}
